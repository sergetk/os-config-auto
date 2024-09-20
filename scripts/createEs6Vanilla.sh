#!/usr/bin/env bash

absPath="${PWD%%os-config-auto*}os-config-auto"
# shellcheck source=/dev/null
. "$absPath/bin/utils/util_functions.sh"

# shellcheck source=/dev/null
. "$absPath/scripts/programming.sh"

createEs6Project() { #@ USAGE: createEs6Project , S1 - path to the project
  [ -z $1 ] && {
    printf "no path specified\n"
    return 1
  }
  
  createDir $1
  
  [ $? -eq 1 ] && {
    printf "failed to create path = %b\n" "$1"
    return 1
  }
  cd $1
  createProjectJson
  setupEslint
  setupJest

  mkdir test
  mkdir src
  
}

createEs6Project $@
