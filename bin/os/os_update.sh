#!/usr/bin/env bash
#: Title        : update_os
#: Author       : sergetk
#: Description  : update manjaro
#: Version      : 0.1
#: Options      : none

absPath="${PWD%%os-config-auto*}os-config-auto"
. "${absPath}/bin/utils/util_functions.sh"

updateOS(){
  # update manjaro
  sudo_cmd "echo 'Starting'"
  #sudo_cmd "
  #sudo pacman -s pacman-contrib
  #yes | pacman -Syu glibc-locales --overwrite /usr/lib/locale/\*/\*
  #sudo_cmd "yes | mhwd-kernel -i linux69 rmc"
  #sudo_cmd "pacman-mirrors --fasttrack"
  #sudo_cmd "yes $'yes\nyes\nyes\nyes\nyes\nyes\nyes\n88\nyes' | pacman -Syyu"
  sudo_cmd "timedatectl set-timezone Pacific/Auckland"
  sudo_cmd "timedatectl set-ntp true"
  sudo_cmd "pacman-key --refresh-keys"
  sudo_cmd "pacman-key --init"
  sudo_cmd "pacman-key --populate"
  sudo_cmd "yes | pacman -Sy archlinux-keyring manjaro-keyring"
  sudo_cmd "yes | pacman -Syyu"
}
