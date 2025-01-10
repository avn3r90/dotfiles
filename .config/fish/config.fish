if status is-interactive
    # Commands to run in interactive sessions can go here
end

export EDITOR=micro

#ogolne
alias cat="bat"
alias ls="eza --icons"
alias mv="mv -v"
alias cp="rsync -ah --progress"
alias poweroff="sudo /sbin/poweroff"
alias lu="du -sh * | sort -h" 
alias rm="rm -rf"

#aliasy yadm
alias ya="yadm add"
alias yc="yadm commit; yadm push"
alias ys="yadm status"
#alias yp="yadm push"

# lokalny chroot do budowania z aur
alias fetchtoo="fastfetch --config examples/2.jsonc"

#alias napisy="~/.local/bin/OpenSubtitlesDownload.py --cli -u avn3r90 -p RylBa3^C3Rj%g#&vWK73S@ -l pl"
~/.local/bin/oh-my-posh init fish --config ~/.cache/oh-my-posh/themes/peru.omp.json | source
