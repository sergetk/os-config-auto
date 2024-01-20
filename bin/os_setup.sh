#!/bin/bash
#: Title        : update_os
#: Author       : sergetk
#: Description  : update manjaro
#: Version      : 0.1
#: Options      : none
##

source "../lib/functions_util.sh"

# update manjaro
sudo_cmd "yes | pacman -Syu glibc-locales --overwrite /usr/lib/locale/\*/\*"
