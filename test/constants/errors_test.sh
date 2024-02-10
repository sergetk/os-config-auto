#!/bin/bash

absPath="${PWD%%os-config-auto*}os-config-auto"

# shellcheck source=../../bin/constants/errors.sh
. "${absPath}/bin/constants/errors.sh"


testErrorsMessages() {
    assertEquals "$ERR_INVALID_PARAM_NUM" "Invalid number of parameters!"
    assertEquals "$ERR_SALT_MISSING" "Salt token file is missing!"
    assertEquals "$ERR_PASS_MISSING" "Pass file is missing!"
    assertEquals "$ERR_SSL" "OpenSSL failed!"
    assertEquals "$ERR_TOKEN_MISSING" "Invalid Token parameter!"
    assertEquals "$ERR_SSH_DIR" "Invalid SSH directory!"
    assertEquals "$ERR_INVALID_GIT_CONFIG_LOCATION" "Invalid git configuration location!"
    assertEquals "$ERR_EMAIL" "Invalid email!"
    assertEquals "$ERR_STATE_FILE_MISSING" "State file doesn't exist!"
    assertEquals "$ERR_INVALID_STATE_TRANSITION" "Invalid State transition!" 
}

. "${absPath}/lib/shunit2/shunit2"

