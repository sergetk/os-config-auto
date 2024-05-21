#!/usr/bin/env bash

absPath="${PWD%%os-config-auto*}os-config-auto"
. "${absPath}/scripts/wallpaper.sh"

testSetRandomWallpaper() {
  nitrogen () {
    printf "%s\n" "$*"
    return 0
  }

  msg=$(setRandomWallpaper)
  exitCode=$?
  assertEquals $exitCode 0
  assertContains "$msg" "--set-zoom-fill --random $HOME/.config/wallpapers --head=0"
  assertContains "$msg" "--set-zoom-fill --random $HOME/.config/wallpapers --head=1"
  
}

oneTimeTearDown() {
  unset nitrogen
}

# shellcheck source=../lib/shunit2/shunit2
. "${absPath}/lib/shunit2/shunit2"
