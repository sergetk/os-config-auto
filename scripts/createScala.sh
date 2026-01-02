#!/usr/bin/env bash

absPath="${PWD%%os-config-auto*}os-config-auto"
# shellcheck source=/dev/null
. "$absPath/bin/utils/util_functions.sh"

createScalaProject() {
  [ -z "$1" ] && {
    printf "no path specified\n"
    return 1
  }

  createDir "$1"

  [ $? -eq 1 ] && {
    printf "failed to create path = %b\n" "$1"
    return 1
  }
  cd "$1" || return 1

}
