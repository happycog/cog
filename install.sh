installFolder="$HOME/Desktop/cog"
installUrl="https://github.com/happycog/cogfile/archive/master.tgz"

# setup
setup () {
    # echo 'Checking if a cogfile exist locally 🤔...'
    # echo ''
    # if [ ! -d $installFolder ]; then
        echo 'Creating cogfile directory 📂'
        curl -s https://github.com/happycog/cogfile/archive/master.tar.gz | tar xvz - -C $installFolder
        echo 'Creating a symbolic link to your bin 🔗'
        for f in ~/.*foo; do 
            #echo $f
            #echo 'export PATH=~/.cog/bin:$PATH' >> $f
            [ -e "$f" ] && echo 'export PATH=~/.cog/bin:$PATH' >> $f || echo "No profile found. Please add ${installFolder}/bin to your \$PATH"
        done
    # else
    #     echo 'Cogfile already exist 💁‍♂️. Updating your cogfile.'
    #     echo ''
    #     pushd $installFolder
    #     git pull --rebase origin master
    #     popd
    # fi
}

setup

exit 0;
