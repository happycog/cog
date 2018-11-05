version() {
  awk '/version/{gsub(/("|",)/,"",$2);print $2};' package.json
}

version=version
echo $version
