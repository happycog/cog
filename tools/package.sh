packageName() {
  awk '/name/{gsub(/("|",)/,"",$0); print $2; exit};' $COG_DIRECTORY/package.json
}

packageVersion() {
  awk '/version/{gsub(/("|",)/,"",$2); print $2; exit};' $COG_DIRECTORY/package.json
}

export -f packageName;
export -f packageVersion;