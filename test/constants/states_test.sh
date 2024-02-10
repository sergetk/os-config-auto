#!/bin/bash

absPath="${PWD%%os-config-auto*}os-config-auto"

# shellcheck source=../../bin/constants/states.sh
. "${absPath}/bin/constants/states.sh"

testStates() {
    assertEquals "OS_UPDATE" "$OS_UPDATE_STATE"
    assertEquals "OS_SSH" "$OS_SSH_STATE"
    assertEquals "OS_FIXES" "$OS_FIXES_STATE"
    assertEquals "GIT_SSH" "$GIT_SSH_STATE"
    assertEquals "GIT_REPOS" "$GIT_REPOS_STATE"
    assertEquals "GIT_CONFIG" "$GIT_CONFIG_STATE"
    assertEquals "SOFT_EMACS" "$SOFT_EMACS_STATE"
    assertEquals "SOFT_DEV" "$SOFT_DEV_STATE"
    assertEquals "SOFT_MISC" "$SOFT_MISC_STATE"
    assertEquals "DONE" "$DONE_STATE"
}

testStateTransitions() {
    assertEquals "updateOS $OS_FIXES_STATE" "$oSUpdateTransition"
    assertEquals "applyOsFixes $OS_SSH_STATE" "$osFixesTransition"
    assertEquals "createSshKey $GIT_SSH_STATE" "$osSshTransition"
    assertEquals "createGitToken $GIT_CONFIG_STATE" "$gitSshTransition"
    assertEquals "createGitConfig $GIT_REPOS_STATE" "$gitConfigTransition"
    assertEquals "cloneGitRepos $SOFT_MISC_STATE" "$gitReposTransition"
    assertEquals "installMisc $SOFT_EMACS_STATE" "$softMiscTransition"
    assertEquals "installEmacs $SOFT_DEV_STATE" "$emacsTransition"
    assertEquals "installDev $UTIL_CLEAN_STATE" "$devTransition"
    assertEquals "cleanUp $DONE_STATE" "$cleanTransition"
}

testStatesTransitionsMap(){
    assertEquals 10 "${#stateTransitions[*]}"
    assertEquals "$oSUpdateTransition" "${stateTransitions["$OS_UPDATE_STATE"]}"
    assertEquals "$osFixesTransition" "${stateTransitions["$OS_FIXES_STATE"]}"
    assertEquals "$osSshTransition" "${stateTransitions["$OS_SSH_STATE"]}"
    assertEquals "$gitSshTransition" "${stateTransitions["$GIT_SSH_STATE"]}"
    assertEquals "$gitConfigTransition" "${stateTransitions["$GIT_CONFIG_STATE"]}"
    assertEquals "$gitReposTransition" "${stateTransitions["$GIT_REPOS_STATE"]}"
    assertEquals "$softMiscTransition" "${stateTransitions["$SOFT_MISC_STATE"]}"
    assertEquals "$emacsTransition" "${stateTransitions["$SOFT_EMACS_STATE"]}"
    assertEquals "$devTransition" "${stateTransitions["$SOFT_DEV_STATE"]}"
    assertEquals "$cleanTransition" "${stateTransitions["$UTIL_CLEAN_STATE"]}"
}

. "${absPath}/lib/shunit2/shunit2"
