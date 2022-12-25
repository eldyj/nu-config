#################
##   aliases   ##
#################

alias b = bat
alias c = clear
alias d = doas dnf
alias e = exit
alias f = f95
alias g = git
alias h = help
alias k = killall
alias l = ls
alias m = make
alias n = nasm
alias r = rm -rfI
alias s = doas
alias t = tcc
alias v = nvim
alias x = xdg-open
alias ca = cargo
alias cc = gcc
alias sc = scala
alias cr = crystal
alias rb = ruby
alias js = node
alias py = python3
alias sc = systemctl
alias mk = mkdir
alias ffetch = freshfetch
alias tokei = tokei --exclude "*.txt"

#################
##     env     ##
#################

let-env EDITOR = "nvim"
let-env VISUAL = "nvim"
let-env PROMPT_INDICATOR = {""}
let-env PROMPT_COMMAND = {prompt left}
let-env PROMPT_COMMAND_RIGHT = {prompt right}
