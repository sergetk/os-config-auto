#!/bin/bash

absPath="${PWD%%os-config-auto*}os-config-auto"

. "${absPath}/bin/git/git_repos_setup.sh"


setUp() {
 . "${absPath}/bin/git/git_repos_setup.sh"
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

    msg=$(cloneGitRepos)
    exitCode=$?
    assertContains "$msg" "emacs.d .emacs.d"
    assertContains "$msg" "notes .notes"
    assertContains "$msg" "kbdx"
    assertContains "$msg" "https://aur.archlinux.org/nordvpn-bin.git"
    assertEquals "$exitCode" "0"

}

oneTimeTearDown() {
   unset gclone_p 
   unset gclone
}

. "${absPath}/lib/shunit2/shunit2"
