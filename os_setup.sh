#!/bin/bash
#: Title        : update_os
#: Author       : sergetk
#: Description  : update manjaro and fix issue that fresh installtion has
#:              : specifically with sound, date and install red-shift
#: Version      : 0.1
#: Options      : none
##


cat pass.txt | sudo -S sh -c "yes | pacman -Syu"

# fixes sound on fresh manjaro installation
##cat pass.txt | sudo -S sh -c "yes | pacman -S pulseaudio-alsa"

#install geoclue required for red-shift
##cat pass.txt | sudo -S sh -c "yes | pacman -S geoclue2"

#enable user service for redshift
##systemctl start geoclue

#install red-shift 
##cat pass.txt | sudo -S sh -c "yes | pacman -S redshift"
##systemctl --user enable redshift.service

#adding it to i3 config so it would start on startup and creating configuration file 
##(echo "# geoclue needed for reshift to get location " ; echo exec --no-startup-id /usr/lib/geoclue-2.0/demos/agent ; echo "")>> $HOME/.i3/config
##(echo "# redshift-gtk startup" ; echo exec --no-startup-id redshift-gtk ; echo "")>> $HOME/.i3/config

#installing ntp for accurate date
##cat pass.txt | sudo -S sh -c "yes | pacman -S ntp"
##cat pass.txt | sudo -S sh -c "timedatectl set-ntp true"


