#!/usr/bin/env bash

absPath="${PWD%%os-config-auto*}os-config-auto"

setUp() {
  . "${absPath}/bin/soft/soft_emacs.sh"
}

testSetupEmacs(){
  y_install() {
    printf "y_install %s\n" "$*" 
    return 0
  }

  append_to_i3(){
    printf "%s\n" "$*" 
    return 0
  }

  msg=$(installEmacs)
  exitCode=$?
  
  assertContains "$msg" "y_install emacs"
  assertContains "$msg" "# short-cut to start emacsclient  bindsym \$mod+Ctrl+Return exec --no-startup-id emacsclient -c"
  assertContains "$msg" "# short-cut to end emacsclient  bindsym \$mod+Ctrl+Escape exec --no-startup-id emacsclient -e '(kill-emacs)'"
  assertContains "$msg" "# start emacs as daemon  exec_always --no-startup-id emacs --daemon "
  assertEquals "0" "$exitCode"
}

oneTimeTearDown() {
  unset y_install
  unset append_to_i3
}

. "${absPath}/lib/shunit2/shunit2"
