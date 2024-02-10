#!/bin/bash

absPath="${PWD%%os-config-auto*}os-config-auto"

. "${absPath}/bin/utils/util_clean_up.sh"

testCleanUp(){
    function rm() {
       printf "%s\n" "$*" 
       return 0
    }
    
    msg=$(cleanUp)
    exitCode=$?
    assertEquals "$msg" "${absPath}/install_ohmyzsh.sh"
    assertEquals 0 "$exitCode"
}

oneTimeTearDown() {
    unset rm
}

# shellcheck source=../../lib/shunit2/shunit2
. "${absPath}/lib/shunit2/shunit2"
