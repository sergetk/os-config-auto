#!/bin/bash
absPath="${PWD%%os-config-auto*}os-config-auto"

# shellcheck source=../bin/constants/states.sh
. "${absPath}/bin/constants/states.sh"
# shellcheck source=../bin/constants/errors.sh
. "${absPath}/bin/constants/errors.sh"
# shellcheck source=../bin/init.sh
. "${absPath}/bin/init.sh"

setUp() {
   stateFile="./stubs/state.txt"
   testState="$OS_UPDATE_STATE"
   printf "%s\n" "" > "$stateFile"

   
   # shellcheck disable=SC2317
   updateOS() {
      printf "updateOS %s\n" "$*"
      return 0
   }
}

# generic test function 
# $1 command and its parameters
# $2 expected output from the command
# $3 expected state
# $4 exit code
validateValues() {
   read -ra cmd <<< "$1"
   expectedMsg=$2
   expectedState=$3
   expectedExitCode=$4

   msg=$("${cmd[@]}") 
   exitCode=$?

    assertEquals "$expectedMsg" "$msg"
    assertEquals "$expectedExitCode" "$exitCode"
    currentState=$(< "$stateFile")
    assertEquals "$expectedState" "$currentState"

}

testProcessStateInvalidTransition() {
    validateValues "processState FOO $stateFile" "$ERR_INVALID_STATE_TRANSITION" "" 1
}

testProcessStateTransitionCmdFailed() {
    # shellcheck disable=SC2317
    updateOS() {
        return 1
    }

    validateValues "processState $testState $stateFile"  "Command updateOS failed" "" 1
}

testProcessState() {
    validateValues "processState $testState $stateFile"  "updateOS " "$OS_FIXES_STATE" 0
}

testInitSuccessStateFileExist() {
    echo "$OS_UPDATE_STATE" > "$stateFile"
    validateValues "init $stateFile $OS_FIXES_STATE"  "updateOS " "$OS_FIXES_STATE" 0
}

testInitSuccessStateFileDoesntExist(){
    rm "${stateFile}"
    validateValues "init $stateFile $OS_FIXES_STATE"  "updateOS " "$OS_FIXES_STATE" 0
}

oneTimeTearDown() {
    unset updateOS
}

# shellcheck source=../lib/shunit2/shunit2
. "${absPath}/lib/shunit2/shunit2"
