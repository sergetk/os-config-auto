#!/usr/bin/env bash
##: Description    : Script used to clone all my repositories.

absPath="${PWD%%os-config-auto*}os-config-auto"
. "${absPath}/bin/utils/util_functions.sh"

cloneGitRepos() {
  gclone_p emacs.d "$HOME/.emacs.d"
  gclone_p notes "$HOME/.notes"
  gclone_p kbdx "$HOME/kbdx"
  gclone_p wallpapers "$HOME/.config/wallpapers"
  gclone https://aur.archlinux.org/nordvpn-bin.git "$HOME/nordvpn"
  # cd nordvpn-bin
  # sudo pacman -U nordvpn-bin-*.*
  # sudo systemctl enable --now nordvpnd
}
