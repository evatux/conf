#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# dirty hack to turn on NumLock
#setleds +num

alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lh --color=auto'
alias la='ls -lha --color=auto'
alias l='ls -CF --color=auto'
alias grep='grep -n --color=auto'
alias xgrep='/bin/grep'

#alias pacman='pacman-color'

# alias init='sudo init'

alias tmux="TERM=screen-256color tmux"

# PS1='[\u@\h \W]\$ '
# PS1=">\[\033[s\]\[\033[1;\$((COLUMNS-4))f\]\$(date +%H:%M)\[\033[u\]"

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
