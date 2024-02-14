#!/bin/bash

absPath="${PWD%%os-config-auto*}os-config-auto"

. "${absPath}/bin/os/os_update.sh"

setUp() {
  . "${absPath}/bin/os/os_update.sh"
}

testUpdateOs() {
  sudo_cmd() {
    printf "%s\n" "$*"
    return 0
  } 

  msg=$(updateOS)
  exitCode=$?

  assertContains "$msg"  "yes | pacman -Syu glibc-locales --overwrite /usr/lib/locale/\*/\*"
  assertEquals "0" "$exitCode"
}

oneTimeTearDown() {
  unset sudo_cmd 
}

. "${absPath}/lib/shunit2/shunit2"
