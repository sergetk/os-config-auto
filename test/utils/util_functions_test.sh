#!/bin/bash

absPath="${PWD%%os-config-auto*}os-config-auto"
. "${absPath}/bin/utils/util_functions.sh"
. "${absPath}/test/stubs/util_stubs.sh"

testPass="${absPath}/test/stubs/pass.txt"
testInputCmd='pacman -S node'
gitPersonal="git@github.com:sergetk/"
dummyDbLckPath="${absPath}/test/stubs/dummyDb.lck"

setUp() {
  stubGit
}

# generic test function
# $1 command
# $2 parameters
# $3 expected output from the command
# $4 exit code
# validateValues() {
#   cmd="$1"
#   args="$2"
#   expectedMsg=$3
#   expectedExitCode=$4

#   msg=$("$cmd" "$args")
#   exitCode=$?
#   assertEquals "$expectedMsg" "$msg"
#   assertEquals "$expectedExitCode" "$exitCode"
# }

# this test must be first as later tests create stab for sudo_cmd
testSudoCmd() {
  stubCat
  stubSudo

  msg=$(sudo_cmd "$testInputCmd" "$testPass")
  exitCode=$?
  assertContains "$msg" "-S sh -c $testInputCmd"
  assertEquals 0 "$exitCode"

}

testDeleteFile() {
  stubSudoCMD
  # validateValues "delete_file" "$dummyDbLckPath" "rm $dummyDbLckPath" 0
  msg=$(delete_file "$dummyDbLckPath")
  exitCode=$?
  assertContains "$msg" "rm $dummyDbLckPath"
  assertEquals 0 "$exitCode"
}

testDeleteDbLock() {
  stubSudoCMD
  #validateValues "delete_dblock" "$dummyDbLckPath" "rm $dummyDbLckPath" 0

  msg=$(delete_dblock "$dummyDbLckPath")
  exitCode=$?
  assertContains "$msg" "rm $dummyDbLckPath"
  assertEquals 0 "$exitCode"

}

testYesInstall() {
  stubSudoCMD
  msg=$(y_install "$testInputCmd" "$testPass")
  exitCode=$?
  assertContains "$msg" "$testInputCmd $testPass"
  assertEquals 0 "$exitCode"
  #validateValues "y_install" "emacs $testPass" "yes | pacman -S emacs $testPass" 0
}

testYesInstallLocal() {
  testInputCmdLocal='yes | pacman -U node'

  # shellcheck disable=SC2329
  sudo_cmd() {
    printf "%s\n" "$*"
    return 0
  }

  msg=$(y_install_local "$testInputCmdLocal" "$testPass")
  exitCode=$?
  assertContains "$msg" "$testInputCmdLocal $testPass"
  assertEquals 0 "$exitCode"
}

testAppendTo() {
  msg=$(append_to "$testInputCmd" "$testPass" 0)
  exitCode=$?
  assertContains "$msg" "$testInputCmd $testPass"
  assertEquals 0 "$exitCode"
}

testAppendToI3() {
  msg=$(append_to_i3 "Hello" "world" 0)
  exitCode=$?

  i3_target="$HOME/.i3/config"
  assertContains "$msg" "Hello $i3_target"
  assertContains "$msg" "world $i3_target"
  assertNotContains "$msg" "Hello world"
  assertEquals 0 "$exitCode"
}

testWriteTo() {
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
  assertEquals "Directory created at $currentDir" "$msg"
  assertEquals 0 "$exitCode"

  rm -r "./foo"
}

testCreateDirErrorInvalidPath() {
  currentDir=""
  msg=$(createDir "$currentDir")
  exitCode=$?
  assertEquals "invalid path = $currentDir" "$msg"
  assertEquals 1 "$exitCode"
}

testPathExists() {
  mkdir foo
  pathExists "foo"
  assertTrue 'invalid directory' $?

  touch baz.txt
  pathExists "$PWD/baz.txt"
  assertTrue "path doesnt exists" $?
  rm -rf foo
  rm -rf baz.txt
}

testContainsText() {
  file="$PWD/test.txt"
  touch $file
  append_to "foo bar" "$file"

  containsText 'foo bar' "$file"
  assertTrue $?

  containsText 'foo' ""
  assertFalse $?

  containsText "baz" "$file"
  assertFalse $?
  rm $file
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
