if status is-interactive
    # Commands to run in interactive sessions can go here
end

#moje aliasy

alias cat='batcat'
alias mv='mv -v'
alias cp="rsync -ah --progress"
alias fastping='ping -c 100 -s.2'
alias poweroff='sudo /sbin/poweroff'
alias lu='du -sh * | sort -h' 
alias lt='ls --human-readable --size -1 -S --classify'
alias rm='rm -rf'
