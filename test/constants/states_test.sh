#!/usr/bin/env bash

absPath="${PWD%%os-config-auto*}os-config-auto"

# shellcheck source=../../bin/constants/states.sh
. "${absPath}/bin/constants/states.sh"
# shellcheck source=../../bin/constants/defaults.sh
. "${absPath}/bin/constants/defaults.sh"

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

testStateFunctions(){
  assertEquals "updateOS" "$OS_UPDATE_FUNC" 
  assertEquals "applyOsFixes" "$OS_FIXES_FUNC" 
  assertEquals "createSshKey" "$OS_SSH_FUNC" 
  assertEquals "createGitToken" "$GIT_SSH_FUNC" 
  assertEquals "createGitConfig" "$GIT_CONFIG_FUNC" 
  assertEquals "cloneGitRepos" "$GIT_REPOS_FUNC" 
  assertEquals "installMisc" "$SOFT_MISC_FUNC" 
  assertEquals "installEmacs" "$SOFT_EMACS_FUNC" 
  assertEquals "installDev" "$SOFT_DEV_FUNC" 
  assertEquals "cleanUp" "$UTIL_CLEAN_FUNC" 
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

testStatesFuncParams() {
  assertEquals 10 "${#stateFuncParams[*]}" 
  assertEquals "" "${stateFuncParams[${OS_UPDATE_FUNC}]}"
  assertEquals "" "${stateFuncParams[${OS_FIXES_FUNC}]}"
  assertEquals "$DEFAULT_SSH_LOCATION" "${stateFuncParams[${OS_SSH_FUNC}]}"
  assertEquals "$DEFAULT_SALT_LOCATION $DEFAULT_PASS_LOCATION $DEFAULT_TOKEN_LOCATION $DEFAULT_PUB_SSH_LOCATION" "${stateFuncParams[${GIT_SSH_FUNC}]}"
  assertEquals "$DEFAULT_EMAIL_LOCATION" "${stateFuncParams[${GIT_CONFIG_FUNC}]}"
  assertEquals "" "${stateFuncParams[${GIT_REPOS_FUNC}]}"
  assertEquals "" "${stateFuncParams[${SOFT_MISC_FUNC}]}"
  assertEquals "" "${stateFuncParams[${SOFT_EMACS_FUNC}]}"
  assertEquals "" "${stateFuncParams[${SOFT_DEV_FUNC}]}"
  assertEquals "" "${stateFuncParams[${UTIL_CLEAN_FUNC}]}"

}

. "${absPath}/lib/shunit2/shunit2"
