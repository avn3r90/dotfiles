#!/usr/bin/env bash
# shredall - rekurencyjne niszczenie plików (wraz z ukrytymi) i usuwanie pustych katalogów
# Uwaga: działanie nieodwracalne.

SHRED_CMD=("shred" "-n" "7" "-z" "-u" "-v")

files_deleted=0
dirs_deleted=0

shred_file() {
  local f="$1"
  "${SHRED_CMD[@]}" -- "$f" && ((files_deleted++)) || {
    echo "Błąd przy shreddowaniu: $f" >&2
  }
}

remove_dir_if_empty() {
  local d="$1"
  rmdir -- "$d" 2>/dev/null && ((dirs_deleted++))
}

process_arg() {
  local target="$1"

  if [[ -f "$target" ]]; then
    shred_file "$target"
    return
  fi

  if [[ -d "$target" ]]; then
    # 1) Shred wszystkich plików (włącznie z ukrytymi) - find domyślnie je uwzględnia.
    # Używamy process substitution, żeby pętle wykonywały się w tym samym środowisku (liczniki).
    while IFS= read -r -d '' file; do
      shred_file "$file"
    done < <(find -- "$target" -type f -print0)

    # 2) Usuń katalogi od najgłębszego (aby można było usunąć puste katalogi).
    # find z -depth wypisze najpierw potomków (głębokie katalogi) potem rodziców.
    while IFS= read -r -d '' dir; do
      remove_dir_if_empty "$dir"
    done < <(find -- "$target" -depth -type d -print0)

    return
  fi

  echo "Pomijam (nie istnieje lub nieobsługiwany typ): $target" >&2
}

# Jeśli brak argumentów -> krótka pomoc
if [[ $# -eq 0 ]]; then
  echo "Użycie: $0 <plik|katalog> [kolejny ...]"
  exit 1
fi

for arg in "$@"; do
  process_arg "$arg"
done

echo "----------------------------------"
echo "Usunięto plików:   $files_deleted"
echo "Usunięto folderów: $dirs_deleted"
echo "----------------------------------"

