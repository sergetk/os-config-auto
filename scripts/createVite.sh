#!/usr/bin/env bash

absPath="${PWD%%os-config-auto*}os-config-auto"
# shellcheck source=/dev/null
. "$absPath/bin/utils/util_functions.sh"

# shellcheck source=/dev/null
. "$absPath/scripts/programming.sh"


createViteProject() { #@ USAGE: createViteProject, $1 - path $2 - template type
  projectType=${2:-'ts'}
  
  [ -z $1 ] && {
    printf "no path specified\n"
    return 1
  }

}
