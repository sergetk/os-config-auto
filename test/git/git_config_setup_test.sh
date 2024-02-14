#! /usr/bin/env bash

absPath="${PWD%%os-config-auto*}os-config-auto"
emailStubsDir="${absPath}/test/stubs/emails"

. "${absPath}/bin/git/git_config_setup.sh"

# validate results of the passed command
# $1 command with parameters
# $2 expected message
# $3 expected exitCode
validateValues() {
  read -ra cmd <<< "$1"
  expectedMsg="$2"
  expectedExitCode="$3"

  msg=$("${cmd[@]}")
  exitCode=$?
  assertContains "$msg" "$expectedMsg" 
  assertEquals "$exitCode" "$expectedExitCode"
}

testInvalidParamsNumber() {
  validateValues "createGitConfig" "$ERR_INVALID_PARAM_NUM" "1"
}

testInvalidConfigFileLocation() {
  validateValues "createGitConfig ''" "$ERR_INVALID_GIT_CONFIG_LOCATION" "1"
}

testInvalidEmailEmptyString() {
  validateValues "createGitConfig ${emailStubsDir}/emptyEmail.txt" "$ERR_EMAIL" "1"
}

testInvalidEmailPattern() {
  validateValues "createGitConfig ${emailStubsDir}/invalidEmail.txt" "$ERR_EMAIL" "1"
}

testValidInput() {

  function git() {
    printf "%s\n" "$*"
    return 0
  }

  resultUserStr="config --global user.name $USER"
  resultEmailStr="config --global user.email valid@gmail.com"

  validateValues "createGitConfig ${emailStubsDir}/validEmail.txt" "$resultUserStr" "0"
  validateValues "createGitConfig ${emailStubsDir}/validEmail.txt" "$resultEmailStr" "0"

}

oneTimeTearDown() {
  unset git
}

. "${absPath}/lib/shunit2/shunit2"
