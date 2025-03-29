#!/usr/bin/env bash
#: Title        : apply fixes to os
#: Author       : sergetk
#: Description  : fix issue that fresh installtion has
#:              : specifically with sound, date and install red-shift
#: Version      : 0.1
#: Options      : none
##

absPath="${PWD%%os-config-auto*}os-config-auto"

. "${absPath}/bin/utils/util_functions.sh"

applyOsFixes() {
  [ -e "/var/lib/pacman/db.lck" ] && {
    sudo_cmd "rm /var/lib/pacman/db.lck"
  }
  # fixes sound on fresh manjaro installation
  y_install pulseaudio-alsa

  # another sound package
  y_install wireplumber
  y_install pipewire-pulse

  #install geoclue required for red-shift
  y_install geoclue2

  #enable user service for redshift
  sudo_cmd "systemctl start geoclue"

  #install red-shift
  y_install redshift
  sudo_cmd "systemctl --user enable redshift.service"

  #adding it to i3 config so it would start on startup and creating configuration file
  append_to_i3 "# geoclue needed for redshift to get location " "exec --no-startup-id /usr/lib/geoclue-2.0/demos/agent"
  append_to_i3 "# redshift-gtk startup" "exec --no-startup-id redshift-gtk"

  #installing ntp for accurate date
  y_install ntp
  sudo_cmd "timedatectl set-ntp true"
}
