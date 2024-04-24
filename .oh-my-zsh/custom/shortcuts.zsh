# clears the shell and displays the current dir
clear-ls-all() {
    clear
    ls -lha
}
zle -N clear-ls-all

# clears the shell and displays the dir tree with all levels
clear-tree() {
    clear
    tree
}
zle -N clear-tree

# prints the current date in ISO 8601
print-current-date() {
  LBUFFER+=$(date -I)
}
zle -N print-current-date

# prints the current Unix timestamp
print-unix-timestamp() {
  LBUFFER+=$(date +%s)
}
zle -N print-unix-timestamp

bindkey '^H' clear-tree
bindkey '^K' clear-ls-all
bindkey '^T' print-current-date
bindkey '^[^T' print-unix-timestamp
