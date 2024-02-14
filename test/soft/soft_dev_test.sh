#!/usr/bin/env bash

absPath="${PWD%%os-config-auto*}os-config-auto"
. "${absPath}/bin/soft/soft_dev.sh"

setUp() {
  . "${absPath}/bin/soft/soft_dev.sh"
}

testSetupDev(){
  npm() {
    printf "%s\n" "$*"
    return 0
  }

  y_install() {
    printf "%s\n" "$*"
    return 0
  }

  sudo_cmd() {
    printf "%s\n" "$*"
    return 0
  }

  msg=$(installDev)
  exitCode=$?
  zshLoc=$(which zsh) 

  assertContains "$msg" "install -g bash-language-server"
  assertContains "$msg" "shellcheck"
  assertContains "$msg" "yes | chsh -s $zshLoc"
  assertEquals 0 "$exitCode"
}

oneTimeTearDown() {
  unset npm
  unset y_install
  unset sudo_cmd
}

. "${absPath}/lib/shunit2/shunit2"
