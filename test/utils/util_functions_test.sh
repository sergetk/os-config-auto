#!/bin/bash

absPath="${PWD%%os-config-auto*}os-config-auto"
. "${absPath}/bin/utils/util_functions.sh"

testPass="${absPath}/test/stubs/pass.txt"
testInputCmd='pacman -s node'
gitPersonal="git@github.com:sergetk/"

setUp () {

  git() {
    # shellcheck disable=SC2317
    printf "%s\n" "$*"    
    # shellcheck disable=SC2317
    return 0
  } 
}

# generic test function 
# $1 command and its parameters
# $2 expected output from the command
# $4 exit code
validateValues() {
  read -ra cmd <<< "$1"
  expectedMsg=$2
  expectedExitCode=$3

  msg=$("${cmd[*]}") 
  exitCode=$?
  assertEquals "$expectedMsg" "$msg"
  assertEquals "$expectedExitCode" "$exitCode"
}

testSudoCmd() {
  sudo() {
    printf "sudo %s\n" "$*"
    return 0
  }

  msg=$(sudo_cmd "$testInputCmd" "$testPass")
  exitCode=$?
  assertContains "$msg" "-S sh -c $testInputCmd" 
  assertEquals 0 "$exitCode"
}

testYesInstall(){
  sudo_cmd(){
    printf "%s\n" "$*"
    return 0
  } 

  msg=$(y_install "$testInputCmd" "$testPass")
  exitCode=$?
  assertContains "$msg" "$testInputCmd $testPass" 
  assertEquals 0 "$exitCode"
}

testAppendTo() {
  msg=$(append_to "$testInputCmd" "$testPass" 0)
  exitCode=$?
  assertContains "$msg" "$testInputCmd $testPass" 
  assertEquals 0 "$exitCode"
}

testAppendToI3() {
  append_to() {
    printf "%s\n" "$*" 
    return 0
  }
  
  msg=$(append_to_i3 "Hello" "world")
  exitCode=$?
  
  i3_target="$HOME/.i3/config"
  assertContains "$msg"  "Hello $i3_target"
  assertContains "$msg"  "world $i3_target"
  assertNotContains "$msg" "Hello world"
  assertEquals 0 "$exitCode"
}

testWriteTo(){
  msg=$(write_to "$testInputCmd" "$testPass" 0)
  exitCode=$?
  assertContains "$msg" "$testInputCmd $testPass" 
  assertEquals 0 "$exitCode"
}

testGitCloneWithoutFolder() {
  msg=$(gclone "${gitPersonal}bla.git")
  exitCode=$?
  _testGitCmdResults "$msg" "$exitCode" "bla" "bla"
}

testGitCloneWithFolder() {
  msg=$(gclone "${gitPersonal}bla.git" "foo")
  exitCode=$?
  _testGitCmdResults "$msg" "$exitCode" "bla" "foo"
}

testGitClonePersonalWithoutFolder() {
  msg=$(gclone_p "bla")
  exitCode=$?
  _testGitCmdResults "$msg" "$exitCode" "bla" "bla"
}

testGitClonePersonalWithFolder() {
  msg=$(gclone_p "bla" "foo")
  exitCode=$?
  _testGitCmdResults "$msg" "$exitCode" "bla" "foo"
}

testIsValidPathFormat() {
  isValidPathFormat "~/foo/bar-foo"
  exitCode=$?
  assertEquals 0 "$exitCode"

  isValidPathFormat "$HOME/foo/bar/"
  exitCode=$?
  assertEquals 0 "$exitCode"

  isValidPathFormat ""
  exitCode=$?
  assertEquals 1 "$exitCode"

  isValidPathFormat "foo"
  exitCode=$?
  assertEquals 1 "$exitCode"

}

testCreateDir() {
  currentDir="./foo/bar"
  msg=$(createDir "$currentDir")
  exitCode=$?
  assertEquals "Directory created at ./foo/bar" "$msg"
  assertEquals 0 "$exitCode"

  rm -r  "./foo"
}

# takes four parameters
# $1 - msg
# $2 - exitCode
# $3 - repository basename
# $4 - repository folder name
_testGitCmdResults() {
  assertContains "$msg" "Started cloning git repository $4"
  assertContains "$msg" "${gitPersonal}${3}.git $4"
  assertContains "$msg" "Finished cloning git repository $4"
  assertEquals 0 "$2"
}

oneTimeTearDown() {
  unset append_to
  unset sudo_cmd
  unset sudo
  unset git
  unset cat
}

# shellcheck source="../../lib/shunit2/shunit2"
. "${absPath}/lib/shunit2/shunit2"

