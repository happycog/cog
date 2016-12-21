#!/bin/bash

set -e

INSTALL_FOLDER="$HOME/.cog"
INSTALL_URL="https://github.com/happycog/cog/archive/master.tar.gz"

echo '📂  Creating cogfile directory'
rm -rf $INSTALL_FOLDER
rm -rf /tmp/cog && mkdir /tmp/cog/
curl -sL $INSTALL_URL | tar xz - -C /tmp/cog/
mv /tmp/cog/cog-master $INSTALL_FOLDER
chmod +x $INSTALL_FOLDER/bin/*
rm -rf /tmp/cog/
echo '🔗  Creating a symbolic link to your bin'
for f in ~/{.profile,.bash_profile,.bashrc,.zshrc}; do 
    if [ -e "$f" ] ; then
        if grep -q "PATH=$INSTALL_FOLDER/bin:\$PATH" "$f"; then
            echo "   -> $f already contains cog/bin"
        else
            echo "export PATH=$INSTALL_FOLDER/bin:\$PATH:" >> $f
            echo "   -> $f updated!"
            echo "   -> Please close and re-open your terminal for the install to take effect."
        fi
    else 
        printf "\n⚠️  No profile found. Please add \`${INSTALL_FOLDER}/bin\` to your \$PATH"
    fi
    break
done

exit 0;
