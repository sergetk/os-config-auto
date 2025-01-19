#!/usr/bin/env bash

# read the state file
# if doesn't exist create new with initial state and assign it to state variable
# open until loop which uses state variable as flag
# use case for each state

absPath="${PWD%%os-config-auto*}os-config-auto"

# shellcheck source=/bin/constants/states.sh
. "${absPath}/bin/constants/states.sh"
. "${absPath}/bin/os/os_update.sh"
. "${absPath}/bin/os/os_fixes.sh"
. "${absPath}/bin/os/os_ssh_setup.sh"
. "${absPath}/bin/git/git_ssh_setup.sh"
. "${absPath}/bin/git/git_config_setup.sh"
. "${absPath}/bin/git/git_repos_setup.sh"
. "${absPath}/bin/soft/soft_misc.sh"
. "${absPath}/bin/soft/soft_emacs.sh"
. "${absPath}/bin/soft/soft_dev.sh"
. "${absPath}/bin/utils/util_clean_up.sh"

processState() {
  local state="$1" 
  local stateLoc="${2-:$DEFAULT_STATE_LOCATION}"
  local transition="${stateTransitions["$state"]}"

  [ -z "$transition" ] && {
    printf "%s\n" "$ERR_INVALID_STATE_TRANSITION"
    return 1
  }
  
  read -ra stateTransition <<< "$transition"
  transitionFunc="${stateTransition[0]}"
  transitionFuncParamsStr="${stateFuncParams[$transitionFunc]}"

  transitionFuncParams=();
  [ -z "$transitionFuncParamsStr" ] || {
    read -ra transitionFuncParams <<< "$transitionFuncParamsStr"
  }

  echo "--- ${transitionFunc} ${transitionFuncParams[@]}"
  "${transitionFunc}" "${transitionFuncParams[@]}"
  [ "$?" == 1 ] && {
    printf "Command %s failed\n" "${stateTransition[0]}"
    return 1
  }

  printf "%s" "${stateTransition[1]}" > "$stateLoc"
}

# entry function for setup
# $1 optional location of the state file, for testing, default state.txt
# $2 terminating state for test, for until loop
init() {
  
  local state="$OS_UPDATE_STATE" 
  local terminationState="${2:-$DONE_STATE}"
  local stateLoc="${1:-$DEFAULT_STATE_LOCATION}"

  if test -e "$stateLoc"
  then
    state=$(cat "$stateLoc")
  else
    printf "%s" "$state" > "$stateLoc" 
  fi 

  until [ "$state" == "$terminationState" ] 
  do
    processState "$state" "$stateLoc"
    state=$(cat "$stateLoc")
  done
}

init "$@"
