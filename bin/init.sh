#!/bin/bash

# read the state file
# if doesn't exist create new with initial state and assign it to state variable
# open until loop which uses state variable as flag
# use case for each state

absPath="${PWD%%os-config-auto*}os-config-auto"

# shellcheck source=/bin/constants/states.sh
. "${absPath}/bin/constants/states.sh"

processState() {
   local state="$1" 
   local stateLoc="${2-:${absPath}/state.txt}"
   local transition="${stateTransitions["$state"]}"

   [ -z "$transition" ] && {
       printf "%s\n" "$ERR_INVALID_STATE_TRANSITION"
       return 1
   }
   
   read -ra stateTransition <<< "$transition"

   "${stateTransition[0]}"
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
    local terminationState="${2-:$DONE_STATE}"
    local stateLoc="${1-:${absPath}/state.txt}"

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