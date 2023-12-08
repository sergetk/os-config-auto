#!/bin/bash
##: Description    : Script used to clone all my repositories.

source "./functions_util.sh"
cd || exit ; 

gclone_p .emacs.d 
gclone_p notes .notes
gclone_p kbdx
gclone https://aur.archlinux.org/nordvpn-bin.git
# cd nordvpn-bin
# sudo pacman -U nordvpn-bin-*.*
# sudo systemctl enable --now nordvpnd
