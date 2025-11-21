###############################################
#   Podstawowa konfiguracja Oh My Zsh
###############################################

# Ścieżka do instalacji Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Motyw — minimalny i domyślny
ZSH_THEME="robbyrussell"

# Lista pluginów Oh My Zsh (tylko aktywne)
plugins=(
  git
  grc
  thefuck
  tldr
  fzf
  web-search
  z
  history-substring-search
)

# Wczytanie Oh My Zsh
source $ZSH/oh-my-zsh.sh


###############################################
#   Dodatkowe pluginy spoza Oh My Zsh
###############################################

# Zoxide — szybka nawigacja po katalogach
eval "$(zoxide init zsh)"

# Oh-my-posh — prompt
alias oh-my-posh="/home/fi9o/.local/bin/oh-my-posh"
eval "$(oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/peru.omp.json)"

# Syntax highlighting
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh

# Autosuggestions
source /usr/share/zsh/site-functions/zsh-autosuggestions.zsh


###############################################
#   Uzupełnianie (completion)
###############################################

autoload -U compinit promptinit
compinit

# Styl promptu Gentoo (potrzebny jeśli oh-my-posh nie działa)
promptinit
prompt gentoo

# Cache na automatyczne uzupełnianie — szybsze działanie
zstyle ':completion::complete:*' use-cache 1


###############################################
#   Alias: screenshot + edycja
#   grim + slurp + swappy
###############################################

alias screenshot='grim -g "$(slurp)" - | swappy -f -'


###############################################
#   Ogólne aliasy i skróty
###############################################

alias cat="bat"                     # lepszy cat
alias ls="eza --icons"              # lepszy ls
alias mv="mv -v"
alias cp_="rsync -ah --progress"
alias poweroff="doas /sbin/poweroff"
alias lu="du -sh * | sort -h"
alias rm="rm -rf"
alias fetchtoo="fastfetch --config examples/2.jsonc"

alias aria2torrent="aria2c --bt-detach-seed-only"

alias lastmerged="doas genlop -l --date '1 day ago'"
alias shred="shred -n 7 -z -u -v"

alias cheatvim="fzf < ~/.config/nvim/nvim.md"

###############################################
#   Alias: yadm
###############################################

alias ya="yadm add"
alias yc="yadm commit; yadm push"
alias ys="yadm status"


###############################################
#   Zmienne środowiskowe
###############################################

export PATH="$HOME/.cargo/bin:$PATH"
