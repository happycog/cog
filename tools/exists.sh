exists () {
    type "$1" &> /dev/null ;
}
export -f exists;
