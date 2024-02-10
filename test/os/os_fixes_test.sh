#!/bin/bash

absPath="${PWD%%os-config-auto*}os-config-auto"

. "${absPath}/bin/os/os_fixes.sh"

setUp() {
    . "${absPath}/bin/os/os_fixes.sh"
}

testApplyOsFixes() {
  y_install() {
    printf "%s\n" "$*"
    return 0
  }

  sudo_cmd() {
    printf "%s\n" "$*"
    return 0
  }

  append_to_i3() {
    printf "%s\n" "$*"
    return 0
  }

  msg=$(applyOsFixes)
  exitCode=$?
  #echo "--- $msg"
  assertContains "$msg" "pulseaudio-alsa"
  assertContains "$msg" "geoclue2"
  assertContains "$msg" "systemctl start geoclue"
  assertContains "$msg" "redshift"
  assertContains "$msg" "systemctl --user enable redshift.service"
  assertContains "$msg" "# geoclue needed for redshift to get location  exec --no-startup-id /usr/lib/geoclue-2.0/demos/agent"
  assertContains "$msg" "# redshift-gtk startup exec --no-startup-id redshift-gtk"
  assertContains "$msg" "ntp"
  assertContains "$msg" "timedatectl set-ntp true"

  assertEquals 0 "$exitCode" 

}

oneTimeTearDown() {
    unset append_to_i3
    unset y_install
    unset sudo_cmd
}

. "${absPath}/lib/shunit2/shunit2"
