#!/usr/bin/env bash

DIR_KEYWORDS="/etc/portage/package.accept_keywords"
DIR_USE="/etc/portage/package.use"

GREEN="\033[32m"
RED="\033[31m"
RESET="\033[0m"

check_and_sort_dir() {
    local DIR="$1"
    local TITLE="$2"

    declare -a OK_LIST
    declare -a X_LIST

    for file in "$DIR"/*; do
        pkg=$(basename "$file")

        is_installed=0

        if [[ "$pkg" == */* ]]; then
            # nazwa z kategorią
            if qlist -I | grep -qx "$pkg"; then
                is_installed=1
            fi
        else
            # nazwa bez kategorii
            if qlist -I | awk -F/ '{print $2}' | grep -qx "$pkg"; then
                is_installed=1
            fi
        fi

        if [[ $is_installed -eq 1 ]]; then
            OK_LIST+=("${GREEN}[OK]${RESET}  $pkg")
        else
            X_LIST+=("${RED}[X]${RESET}   $pkg")
        fi
    done

    echo
    echo "=== $TITLE ==="

    # Print sorted: installed first
    for line in "${OK_LIST[@]}"; do
        echo -e "$line"
    done

    for line in "${X_LIST[@]}"; do
        echo -e "$line"
    done
}

check_and_sort_dir "$DIR_KEYWORDS" "package.accept_keywords"
check_and_sort_dir "$DIR_USE" "package.use"

echo

