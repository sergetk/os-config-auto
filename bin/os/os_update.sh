#!/bin/bash
#: Title        : update_os
#: Author       : sergetk
#: Description  : update manjaro
#: Version      : 0.1
#: Options      : none

absPath="${PWD%%os-config-auto*}os-config-auto"

. "${absPath}/bin/utils/util_functions.sh"


updateOS(){
  # update manjaro
  sudo_cmd "yes | pacman -Syu glibc-locales --overwrite /usr/lib/locale/\*/\*"
}
