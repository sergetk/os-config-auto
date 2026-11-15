#!/usr/bin/env bash
#: Title        : update_os
#: Author       : sergetk
#: Description  : update manjaro
#: Version      : 0.1
#: Options      : none

absPath="${PWD%%os-config-auto*}os-config-auto"
. "${absPath}/bin/utils/util_functions.sh"

updateOS() {
  # update manjaro
  sudo_cmd "echo 'Starting'"
  #sudo_cmd "
  #sudo pacman -s pacman-contrib
  #yes | pacman -Syu glibc-locales --overwrite /usr/lib/locale/\*/\*
  #sudo_cmd "yes | mhwd-kernel -i linux69 rmc"
  #When attempting to upgrade from 20250508.788aadc8-2 or earlier need following two commands
  
  sudo_cmd "yes | pacman -Rdd linux-firmware"
  sudo_cmd "yes | pacman -Syu linux-firmware"
  sudo_cmd "pacman-mirrors --country New_Zealand,Australia,United_States --api --protocols https"
  sudo_cmd "timedatectl set-timezone Pacific/Auckland"
  sudo_cmd "timedatectl set-ntp true"
  #sudo_cmd "pacman-key --refresh-keys"
  #sudo_cmd "pacman-key --init"
  #sudo_cmd "pacman-key --populate"
  sudo_cmd "yes | pacman -Sy archlinux-keyring manjaro-keyring"
  sudo_cmd "yes | pacman -Rns lib32-audit lib32-pam lib32-vulkan-intel lib32-vulkan-nouveau lib32-vulkan-radeon lib32-systemd lib32-libcap"
  sudo_cmd "yes | pacman -Syyu"
}
