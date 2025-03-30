#!/usr/bin/env bash
##: Description    : Script used to clone all my repositories.

absPath="${PWD%%os-config-auto*}os-config-auto"
# shellcheck source="../utils/util_functions.sh"
. "${absPath}/bin/utils/util_functions.sh"
# shellcheck source="../constants/defaults.sh"
. "${absPath}/bin/constants/defaults.sh"

#@ run: create known hosts entry
## creates known_hosts entry for github.com
## clones repositories
## $1 - location of KNOWN_HOSTS file

cloneGitRepos() {
  [ $# -eq 0 ] && {
    echo "$ERR_INVALID_PARAM_NUM"
    exit 1
  }

  write_to "${GIT_SSH_HOSTS_ENTRY}" "$1"

  gclone_p emacs.d "$HOME/.emacs.d"
  gclone_p notes "$HOME/.notes"
  gclone_p kbdx "$HOME/kbdx"
  gclone_p wallpapers "$HOME/.config/wallpapers"
  gclone https://aur.archlinux.org/nordvpn-bin.git "$HOME/nordvpn"
  gclone https://aur.archlinux.org/emacs-git.git/ "$HOME/emacs-repo"
}
