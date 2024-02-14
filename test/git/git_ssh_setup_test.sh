#! /usr/bin/env bash

absPath="${PWD%%os-config-auto*}os-config-auto"
stubsPath="${absPath}/test/stubs"
stubSalt="${stubsPath}/salt.txt"
stubPass="${stubsPath}/pass.txt"
stubToken="${stubsPath}/token.txt"
stubRsa="${stubsPath}/ssh/id_rsa.pub"

setUp() {
 . "${absPath}/bin/git/git_ssh_setup.sh"
}

# validate results
# $1 - command and parameters string
# $2 - expected message
# $3 - expected exit code

validateTestResult() {
   read -a cmdParams <<< $1
   expectedMsg=$2
   expectedExitCode=$3

   msg=$(${cmdParams[@]})
   actualExitCode=$?
   assertContains "$msg" "$expectedMsg"
   assertEquals "$expectedExitCode" "$actualExitCode" 
}

testInvalidSaltTokenLocation() {
   validateTestResult "createGitToken salt.txt $stubPass $stubToken ../stubs/" "$ERR_SALT_MISSING" 1
}

testInvalidPasswordFileLocation(){
   validateTestResult "createGitToken $stubSalt pass.txt $stubToken ./" "$ERR_PASS_MISSING" 1
}

testInvalidTokenLocation(){
   validateTestResult "createGitToken $stubSalt $stubPass ./ ./ssh" "$ERR_TOKEN_MISSING" 1
}

testInvalidSshDirectory(){
   validateTestResult "createGitToken $stubSalt $stubPass $stubToken ./sshh" "$ERR_SSH_DIR" 1
}

testOpenSslFailed(){
  openssl() {
    printf "%s\n" "$*"
    return 1
  }
  validateTestResult "createGitToken $stubSalt $stubPass $stubToken ${stubsPath}/ssh" "$ERR_SSL" 1
}

testCurlFailed() {
  openssl() {
    return 0
  }

  curl() {
    return 1 
  }
 
  validateTestResult "createGitToken $stubSalt $stubPass $stubToken $stubRsa" "Curl failed" 1
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

  validateTestResult "createGitToken $stubSalt $stubPass $stubToken $stubRsa" "$jexpectedSSLParams" 0
  validateTestResult "createGitToken $stubSalt $stubPass $stubToken $stubRsa" "$expectedCurlParams" 0

}

oneTimeTearDown() {
    unset curl
    unset openssl
}

. "${absPath}/lib/shunit2/shunit2"
