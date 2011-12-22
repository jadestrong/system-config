#!/bin/bash
set -e
mkdir ~/.logs -p
cd ~/windows-config/
mkdir -p ~/external/bin/$(uname|perl -npe 's/_.*//')
for x in `git ls-tree --name-only HEAD`
do
    if test $x = . -o $x = .. -o $x = .git; 
    then
        continue;
    fi
    if test -e ~/$x -a "$(readlink -f ~/$x)" != "$(readlink -f ~/windows-config/$x)"; 
    then
        echo "Error: ~/$x already exist and it's not softlink to ~/windows-config/$x"
        mv ~/$x ~/$x.bak
        ln -s ~/windows-config/$x ~/
    elif ! test -e ~/$x;
    then
        ln -sf ~/windows-config/$x ~/
    fi
done

if test `whoami` = bhj; then
    ln -sf ~/.gitconfig.`whoami` ~/.gitconfig
fi
ln -sf .offlineimaprc-$(uname|perl -npe 's/_.*//') ~/.offlineimaprc
mkdir -p ~/bin/$(uname|perl -npe 's/_.*//')/ext/`uname -m`/

echo OK
