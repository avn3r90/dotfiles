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
alias update="sudo apt update"
alias upgrade="sudo apt upgrade"
alias showupdate="apt list --upgradable"

#aliasy yadm
alias ya="yadm add"
alias yc="yadm commit; yadm push"
alias ys="yadm status"
#alias yp="yadm push"

# lokalny chroot do budowania z aur
export repolokalne="/home/fi9o/chroot/home/fi9o/"
