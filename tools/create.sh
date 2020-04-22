createScript() {
   
# Variables
ARG_FILENAME=$1

# Check to see if name argument was passed
if [ -z "$ARG_FILENAME" ]; then
  echo '⚠️  Not enough arguments (missing: "name").'
  echo '⚠️  Example: cog make:script <name>'
  exit 0
fi

# Check if bin folder exist
if [ ! -d './bin' ]; then
  echo '🗄  Creating bin folder...'
  mkdir bin
fi

cd ./bin

# Check if file exist
if [ ! -f "cog-$ARG_FILENAME" ]; then
  echo "[1/3] 📄  Creating cog-$ARG_FILENAME script..."
  touch cog-$ARG_FILENAME

  echo "[2/3] ⌨️  Making cog-$ARG_FILENAME Executable..."
  chmod u+x cog-$ARG_FILENAME

  echo "#!/bin/bash" >> cog-$ARG_FILENAME
  echo "#################################################" >> cog-$ARG_FILENAME
  echo "# Description: Add your descripton here" >> cog-$ARG_FILENAME
  echo "#################################################" >> cog-$ARG_FILENAME
else
  echo "⚠️  File already exist. Please try again"
  exit 0
fi

echo "[3/3] ✨  Finished. cog-$ARG_FILENAME script was created in ./bin/"

}
export -f createScript;
