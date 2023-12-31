#!/bin/bash
#: Title        : update_os
#: Author       : sergetk
#: Description  : update manjaro and fix issue that fresh installtion has
#:              : specifically with sound, date and install red-shift
#: Version      : 0.1
#: Options      : none
##

source "../lib/functions_util.sh"

# update manjaro
sudo_cmd "yes | pacman -Syu glibc-locales --overwrite /usr/lib/locale/\*/\*"

# fixes sound on fresh manjaro installation
y_install pulseaudio-alsa 

#install geoclue required for red-shift
y_install geoclue2

#enable user service for redshift
sudo_cmd "systemctl start geoclue"

#install red-shift 
y_install redshift
sudo_cmd "systemctl --user enable redshift.service"

#adding it to i3 config so it would start on startup and creating configuration file 
append_to_i3 "# geoclue needed for reshift to get location " "exec --no-startup-id /usr/lib/geoclue-2.0/demos/agent" 
append_to_i3 "# redshift-gtk startup" "exec --no-startup-id redshift-gtk"

#installing ntp for accurate date
y_install ntp
sudo_cmd "timedatectl set-ntp true"
