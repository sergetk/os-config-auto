#!/bin/bash
##: Description    : Script used to clone all my repositories.

echo "About to clone emacs config"
cd || exit ; 

#echo "$PWD"

if test -e ~/.emacs.d
then
    rm -Rf ~/.emacs.d
fi

git clone git@github.com:sergetk/emacs.d.git .emacs.d
echo "Finished cloning emacs config"

echo "cloning out notes repo"
if test -e ~/.notes
then
    rm -Rf ~/.notes
fi

git clone git@github.com:sergetk/notes.git .notes
echo "Finished cloning notes repo"

echo "cloning kbdx repo"
if test -e ~/kbdx
then
    rm -Rf ~/kbdx
fi

git clone git@github.com:sergetk/kbdx.git .notes
echo "Finished cloning kbdx repo"
