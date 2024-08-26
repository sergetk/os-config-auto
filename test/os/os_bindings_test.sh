#!/usr/bin/env bash
absPath="${PWD%%os-config-auto*}os-config-auto"
configFile="../stubs/i3stub.txt"
entry1='bindsym Print exec --no-startup-id i3-scrot'
# shellcheck disable=SC2016
entry2='bindsym $mod+Print --release exec --no-startup-id i3-scrot -w'
# shellcheck disable=SC2016
entry3='bindsym $mod+Shift+Print --release exec --no-startup-id i3-scrot -s'

setUp() {
  . "${absPath}/bin/os/os_bindings.sh"   

  y_install() {
    printf "y_install %s\n" "$*" 
    return 0
  }
}

confirmResults() {
  entry="$1"
  result=$(grep "$entry" "$configFile") 
  assertEquals "$entry" "$result" 
}

testStubFileState() {
  confirmResults "$entry1"
  confirmResults "$entry2"
  confirmResults "$entry2"
}

testUpdateI3Bindings() {
  updateI3Bindings $configFile
  exitCode=$?
  assertEquals 0 "$exitCode"

  confirmResults "#$entry1" 
  confirmResults "#$entry2"
}

testInstallSoftware() {
  result=$(installXorg)
  exitCode=$?
  assertEquals 0 "$exitCode"
  assertContains "$result" 'y_install xorg-xmodmap'
  assertContains "$result" 'y_install xorg-xev'
}

testRemapPrintKey() {
  result=$(rebindKeys)
  exitCode=$?

  printf "##### result = %s\n" "$result"

  assertContains "$result" "107"
  assertEquals 0 "$exitCode"
}

tearDown() {
  sed -i 's/#bindsym Print/bindsym Print/' "$configFile"
  # shellcheck disable=SC2016
  sed -i 's/#bindsym $mod+Print/bindsym $mod+Print/' "$configFile"
  # shellcheck disable=SC2016
  sed -i 's/bindsym $mod+Shift+p/bindsym $mod+Shift+Print/' "$configFile" 
  unset y_install
}

. "${absPath}/lib/shunit2/shunit2" 
