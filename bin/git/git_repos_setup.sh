#!/bin/bash
##: Description    : Script used to clone all my repositories.

absPath="${PWD%%os-config-auto*}os-config-auto"

. "${absPath}/bin/utils/util_functions.sh"

cloneGitRepos() {
  gclone_p emacs.d .emacs.d
  gclone_p notes .notes
  gclone_p kbdx
  gclone https://aur.archlinux.org/nordvpn-bin.git
  # cd nordvpn-bin
  # sudo pacman -U nordvpn-bin-*.*
  # sudo systemctl enable --now nordvpnd
}
