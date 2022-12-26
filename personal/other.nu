#################
##   aliases   ##
#################

alias b = bat
alias c = clear
alias d = dnf
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
##  functions  ##
#################

# dnf install
def "d i" [...packages] {
  doas dnf in $packages -y
}

# dnf remove
def "d r" [...packages] {
  doas dnf remove $packages -y
}

# dnf upgrade
def "d u" [] {
  doas dnf upgrade -y
}

# dnf history
def "d h" [] {
  doas dnf history
}

# dnf history undo
def "d hu" [nth: int] {
  doas dnf history undo $nth
}

# dnf search
def "d s" [query: string] {
  doas dnf search $query
}


#################
##     env     ##
#################

let-env EDITOR = "nvim"
let-env VISUAL = "nvim"
let-env PROMPT_INDICATOR = {""}
