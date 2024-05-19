#!/usr/bin/env bash

absPath="${PWD%%os-config-auto*}os-config-auto"

. "${absPath}/scripts/wallpaper.sh"

testWallpapers() {
  assertEquals "${#wallpapers[@]}" "17"
  assertEquals "${wallpapers[0]}" "abstract_ball"
  assertEquals "${wallpapers[1]}" "black_orange"
  assertEquals "${wallpapers[2]}" "chess_art"
  assertEquals "${wallpapers[3]}" "concrete_art"
  assertEquals "${wallpapers[4]}" "desert_water"
  assertEquals "${wallpapers[5]}" "exploring_worlds"
  assertEquals "${wallpapers[6]}" "green_city"
  assertEquals "${wallpapers[7]}" "hartbeat-uw"
  assertEquals "${wallpapers[8]}" "ice_cubes"
  assertEquals "${wallpapers[9]}" "moon_ny"
  assertEquals "${wallpapers[10]}" "sad_mood"
  assertEquals "${wallpapers[11]}" "science_fiction"
  assertEquals "${wallpapers[12]}" "sf_art"
  assertEquals "${wallpapers[13]}" "spacecat"
  assertEquals "${wallpapers[14]}" "space_kitten"
  assertEquals "${wallpapers[15]}" "spacemonkey"
  assertEquals "${wallpapers[16]}" "tokyo"
}

testSetWallpaperByIndex() {
  feh() {
    printf "%s\n" "$*"
    return 0
  }

  msg=$(setWallpaperByIndex 3)
  exitCode=$?
  assertEquals "$msg" "--no-fehbg --bg-fill $HOME/.config/wallpapers/concrete_art.jpg"
  assertEquals 0 $exitCode
}

testSetRandomWallpaper() {
  setWallpaperByIndex () {
    printf "%s\n" "$*"
    return 0
  }

  msg=$(setRandomWallpaper)
  exitCode=$?
  assertEquals $exitCode 0
  assertTrue "[ $msg -ge 0 -a $msg -le ${#wallpapers[@]} ]"
}

oneTimeTearDown() {
  unset feh
}


# shellcheck source=../lib/shunit2/shunit2
. "${absPath}/lib/shunit2/shunit2"
