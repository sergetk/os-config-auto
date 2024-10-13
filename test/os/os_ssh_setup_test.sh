#!/usr/bin/env bash

absPath="${PWD%%os-config-auto*}os-config-auto"
. "${absPath}/bin/os/os_ssh_setup.sh"

sshDir="${absPath}/test/stubs/ssh"

testInvalidParamsNumber() {
  errorMsg=$(createSshKey)
  exitCode=$?
  assertEquals "$ERR_INVALID_PARAM_NUM" "$errorMsg" 
  assertEquals 1 "$exitCode"
}

testDoNothingIfSshKeyExists() {
  msg=$(createSshKey "${sshDir}/id_rsa")
  exitCode=$?
  assertSame "" "$msg"
  assertEquals 0 "$exitCode"
}

testGenerateSshKey() {
  ssh-keygen() {
    printf "%s\n" "$*"  
  }

  ssh-add() {
    #added #2 to distinguish from ssh-keygen refernce to $1
    printf "#2%s\n" "$*" 
  }
  
  msg=$(createSshKey "${sshDir}/id_rsa_temp")
  exitCode=$?
  assertContains "$msg" "-b 4096 -t rsa -N  -f $1"
  assertContains "$msg" "#2$1"
  assertEquals 0 "$exitCode"
}

oneTimeTearDown() {
  unset ssh-add
  unset ssh-keygen
}

. "${absPath}/lib/shunit2/shunit2"

