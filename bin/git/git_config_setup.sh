#!/bin/bash

absPath="${PWD%%os-config-auto*}os-config-auto"

. "${absPath}/bin/constants/errors.sh"
. "${absPath}/bin/constants/regex_patterns.sh"

createGitConfig() {

    [ $# -eq 0 ] && {
        echo "$ERR_INVALID_PARAM_NUM"
        exit 1
    }

    [ -e "$1" ] || {
       echo "$ERR_INVALID_GIT_CONFIG_LOCATION"
       exit 1
    } 
    
    email=$(<"$1")

    [[ $email =~ $EMAIL_PATTERN ]] || {
        echo "$ERR_EMAIL"
        exit 1
    }
    
    git config --global user.name "$USER"
    git config --global user.email "$email" 
}
