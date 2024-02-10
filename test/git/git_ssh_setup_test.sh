#! /bin/bash

## invlid number of parameters
## missing files one of 4

absPath="${PWD%%os-config-auto*}os-config-auto"
stubsPath="${absPath}/test/stubs"

. "${absPath}/bin/git/git_ssh_setup.sh"

stubSalt="${stubsPath}/salt.txt"
stubPass="${stubsPath}/pass.txt"
stubToken="${stubsPath}/token.txt"
stubRsa="${stubsPath}/ssh/id_rsa.pub"

setUp() {
 . "${absPath}/bin/git/git_ssh_setup.sh"
}


testInvalidParametersNumber() {
   errorMsg=$(createGitToken)
   exitCode=$?
   assertEquals "$ERR_INVALID_PARAM_NUM" "$errorMsg" 
   assertEquals 1 "$exitCode"
}

testInvalidSaltTokenLocation() {
   errorMsg=$(createGitToken "salt.txt" "$stubPass" "$stubToken" "../stubs/")
   exitCode=$?
   assertEquals "$ERR_SALT_MISSING" "$errorMsg" 
   assertEquals 1 "$exitCode"
}

testInvalidPasswordFileLocation(){
   errorMsg=$(createGitToken "$stubSalt" "pass.txt" "$stubToken" "./")
   exitCode=$?
   assertEquals "$ERR_PASS_MISSING" "$errorMsg" 
   assertEquals 1 "$exitCode"
}

testInvalidTokenLocation(){
   errorMsg=$(createGitToken "$stubSalt" "$stubPass" "" "./ssh")
   exitCode=$?
   assertEquals "$ERR_TOKEN_MISSING" "$errorMsg" 
   assertEquals 1 "$exitCode"
}

testInvalidSshDirectory(){
   errorMsg=$(createGitToken "$stubSalt" "$stubPass" "$stubToken" "./sshh")
   exitCode=$?
   assertEquals "$ERR_SSH_DIR" "$errorMsg" 
   assertEquals 1 "$exitCode"
}

testOpenSslFailed(){
  openssl() {
    printf "%s\n" "$*"
    return 1
  }

  errorMsg=$(createGitToken "$stubSalt" "$stubPass" "$stubToken" "${stubsPath}/ssh")
  exitCode=$?
  assertContains "$errorMsg" "$ERR_SSL"
  assertEquals 1 "$exitCode"
}

testCurlFailed() {
  openssl() {
    return 0
  }

  curl() {
    return 1 
  }
 
  errorMsg=$(createGitToken "$stubSalt" "$stubPass" "$stubToken" "$stubRsa")
  exitCode=$?
  assertEquals "Curl failed" "$errorMsg" 
  assertEquals 1 "$exitCode"
}

testSuccess() {
  openssl() {
    printf "%s\n" "$*"
    return 0
  }

  curl() {
    printf "%s\n" "$*"
    return 0 
  }

  expectedSSLParams="enc -d -aes-256-cbc -in $stubSalt -out $stubToken -pass file:$stubPass -iter 1000"
  expectedCurlParams="-L -X POST -H Accept: application/vnd.github+json -H Authorization: Bearer $TOKEN -H X-GitHub-Api-Version: 2022-11-28 https://api.github.com/user/keys -d {\"title\": \"ssh-desktop-test\",\"key\":\"$PUBKEY\"}"

  msg=$(createGitToken "$stubSalt" "$stubPass" "$stubToken" "$stubRsa")
  exitCode=$?
  assertContains "$msg" "$expectedSSLParams"
  assertContains "$msg" "$expectedCurlParams"
  assertEquals 0 "$exitCode"
 
}

oneTimeTearDown() {
    unset curl
    unset openssl
}

. "${absPath}/lib/shunit2/shunit2"
