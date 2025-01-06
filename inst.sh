#!/bin/bash

# Menu glowne
echo "Wybierz opcje:"
echo "1. Konfiguracja Wi-Fi"
echo "2. Zarzadzanie partycjami"
echo "3. Instalacja bazowego systemu"
echo "4. Wyjscie"
echo "5. Wykonaj dodatkowe operacje w zainstalowanym systemie"
read -p "Wprowadz wybor: " choice

case $choice in
    1)
        # Sprawdzanie polaczenia z siecia
        ping -c 1 archlinux.org > /dev/null 2>&1

        if [ $? -ne 0 ]; then
            echo "Brak polaczenia z siecia. Konfiguracja Wi-Fi."

            # Pobranie nazwy sieci Wi-Fi (SSID)
            read -p "Podaj nazwe swojej sieci Wi-Fi (SSID): " SSID

            # Pobranie hasla do Wi-Fi
            read -sp "Podaj haslo do swojej sieci Wi-Fi: " passphrase
            echo

            # Polaczenie z Wi-Fi
            iwctl --passphrase "$passphrase" station wlan0 connect "$SSID"

            # Sprawdzanie, czy polaczenie zostalo nawiazane
            if [ $? -eq 0 ]; then
                echo "Polaczenie z siecia Wi-Fi $SSID zostalo nawiazane."
            else
                echo "Nie udalo sie polaczyc z siecia Wi-Fi $SSID. Sprawdz dane i sproboj ponownie."
                exit 1
            fi
        else
            echo "Polaczenie z siecia jest dostepne."
        fi
        ;;
    2)
        # Zarzadzanie partycjami
        echo "Wykryte dyski i partycje:"
        lsblk

        # Wykrywanie rodzaju dysku
        disk_type=$(lsblk -dn -o TYPE | grep -m1 -E 'disk')
        disk_name=$(lsblk -dn -o NAME | grep -m1 -E '^(sda|hda|vda|nvme)')

        echo "Wykryty typ dysku: $disk_type"
        echo "Wykryty dysk: $disk_name"

        mount_root="false"
        for part in $(lsblk -ln -o NAME -e 7,11 | grep -E '^[a-zA-Z]+[0-9]+$'); do
            read -p "Czy uzyc partycji $part? (tak/nie): " use_part
            if [ "$use_part" == "tak" ]; then
                # Pytanie o system plikow z walidacja
                while true; do
                    echo "Dostepne systemy plikow: btrfs, ext3, ext4, jfs, xfs, fat32, swap"
                    read -p "Wybierz system plikow dla $part: " fs_type
                    case $fs_type in
                        btrfs|ext3|ext4|jfs|xfs|fat32|swap)
                            break
                            ;;
                        *)
                            echo "Nieznany system plikow. Sprobuj ponownie."
                            ;;
                    esac
                done

                # Pytanie o zastosowanie partycji
                read -p "Podaj zastosowanie dla partycji $part (np. /, /home, swap): " mount_point

                # Tworzenie systemu plikow
                case $fs_type in
                    btrfs|ext3|ext4|jfs)
                        mkfs.$fs_type -F /dev/$part
                        ;;
                    xfs)
                        mkfs.$fs_type -f /dev/$part
                        ;;
                    fat32)
                        mkfs.vfat -F 32 /dev/$part
                        ;;
                    swap)
                        mkswap /dev/$part
                        swapon /dev/$part
                        ;;
                esac

                # Montowanie partycji
                if [ "$mount_point" == "/" ]; then
                    mount /dev/$part /mnt
                    mount_root="true"
                elif [ "$mount_point" == "/home" ]; then
                    mkdir -p /mnt/home
                    mount /dev/$part /mnt/home
                elif [ "$mount_point" == "/boot/efi" ]; then
                    mkdir -p /mnt/boot/efi
                    mount /dev/$part /mnt/boot/efi
                fi

                echo "Partyca $part zostala sformatowana jako $fs_type i przypisana do $mount_point."
            fi
        done

        if [ "$mount_root" == "false" ]; then
            echo "Brak partycji root (/). Nie mozna kontynuowac."
            exit 1
        fi
        ;;
    3)
        # Instalacja bazowego systemu
        echo "Instalowanie bazowego systemu w lokalizacji /mnt..."

        pacstrap -K /mnt base linux linux-firmware grub efibootmgr sudo networkmanager

        if [ $? -eq 0 ]; then
            echo "Bazowy system zostal pomyslnie zainstalowany."

            # Generowanie fstab
            genfstab -U /mnt >> /mnt/etc/fstab
            echo "Plik fstab zostal wygenerowany."

            # Ustawienie lokalizacji
            echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf
            echo "Plik /mnt/etc/locale.conf zostal ustawiony."

            # Ustawienia konsoli
            echo -e "KEYMAP=pl\nFONT=lat2-16" > /mnt/etc/vconsole.conf
            echo "Plik /mnt/etc/vconsole.conf zostal ustawiony."

            # Edycja locale.gen
            sed -i 's/^#pl_PL.UTF-8/ pl_PL.UTF-8/' /mnt/etc/locale.gen
            echo "Plik /mnt/etc/locale.gen zostal zmodyfikowany."

            # Ustawienie hostname
            echo "hostname" > /mnt/etc/hostname
            echo "Plik /mnt/etc/hostname zostal ustawiony."
        else
            echo "Wystapil blad podczas instalacji bazowego systemu."
            exit 1
        fi
        ;;
    5)
        # Wejście do chroota i wykonanie dodatkowych poleceń
        echo "Wejscie do chroota..."
        arch-chroot /mnt /bin/bash << EOF
            # Ustawienie strefy czasowej
            ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
            hwclock --systohc
            echo "Strefa czasowa ustawiona na Europe/Warsaw."

            # Ustawienie hasła root
            echo "Ustawianie hasła root..."
            passwd

            # Instalacja GRUB
            grub-install /dev/$disk_name
            echo "GRUB zainstalowany na dysku $disk_name."

            # Generowanie initramfs
            mkinitcpio -P
            echo "Initramfs wygenerowany."

            # Włączenie NetworkManager
            systemctl enable NetworkManager
            echo "NetworkManager włączony."

            # Generowanie konfiguracji GRUB
            grub-mkconfig -o /boot/grub/grub.cfg
            echo "Konfiguracja GRUB wygenerowana."
EOF
        echo "Dodatkowe operacje zostały wykonane, wychodzimy z chroot."
        ;;
    6)
        echo "Wyjscie z programu."
        exit 0
        ;;
    *)
        echo "Niepoprawny wybor."
        exit 1
        ;;
esac
