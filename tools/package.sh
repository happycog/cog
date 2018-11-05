name() {
  awk '/name/{gsub(/("|",)/,"",$0); print $2; exit};' package.json
}

version() {
  awk '/version/{gsub(/("|",)/,"",$2); print $2; exit};' package.json
}

