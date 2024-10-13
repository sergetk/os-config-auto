#!/usr/bin/env bash

absPath="${PWD%%os-config-auto*}os-config-auto"
. "${absPath}/bin/git/git_repos_setup.sh"
. "${absPath}/bin/utils/util_functions.sh"

# setUp() {
#   . "${absPath}/bin/git/git_repos_setup.sh"
# }

sshDir="${absPath}/test/stubs/ssh"

testInvalidParamNum() {
  msg=$(cloneGitRepos)
  exitCode=$?
  assertContains "$msg" "$ERR_INVALID_PARAM_NUM"
  assertEquals "$exitCode" "1"
}

testCloneGitRepos() {
  gclone_p() {
    printf "%s\n" "$*" 
    return 0
  }

  gclone() {
    printf "%s\n" "$*" 
    return 0
  }

  msg=$(cloneGitRepos "${sshDir}/known_hosts")
  exitCode=$?
  assertContains "$msg" "emacs.d $HOME/.emacs.d"
  assertContains "$msg" "notes $HOME/.notes"
  assertContains "$msg" "kbdx $HOME/kbdx"
  assertContains "$msg" "wallpapers $HOME/.config/wallpapers"
  assertContains "$msg" "https://aur.archlinux.org/nordvpn-bin.git $HOME/nordvp"
  assertEquals "$exitCode" "0"

  containsText "${GIT_SSH_HOSTS_ENTRY}" "${sshDir}/known_hosts"
  containsExitCode=$?
  assertEquals "$containsExitCode" "0"

  write_to "" "${sshDir}/known_hosts"
}

oneTimeTearDown() {
  unset gclone_p 
  unset gclone
}

. "${absPath}/lib/shunit2/shunit2"
