#!/usr/bin/env bash

ACCEPT_KEYWORDS_DIR="/etc/portage/package.accept_keywords"

GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

for file in "$ACCEPT_KEYWORDS_DIR"/*; do
    pkg_name=$(basename "$file")  # nazwa pliku (pakiet lub kategoria/pakiet)
    
    if [[ "$pkg_name" == */* ]]; then
        if qlist -I | grep -qx "$pkg_name"; then
            echo -e "${GREEN}[OK]${RESET}  $pkg_name"
        else
            echo -e "${RED}[X]${RESET}   $pkg_name"
        fi
    else
        if qlist -I | awk -F/ '{print $2}' | grep -qx "$pkg_name"; then
            echo -e "${GREEN}[OK]${RESET}  $pkg_name"
        else
            echo -e "${RED}[X]${RESET}   $pkg_name"
        fi
    fi
done

