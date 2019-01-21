rule() {
    eval printf %.0s= '{1..'"${COLUMNS:-$(tput cols)}"\}; echo
}
export -f rule;