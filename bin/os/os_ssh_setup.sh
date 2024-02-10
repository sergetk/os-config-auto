#!/bin/bash
absPath="${PWD%%os-config-auto*}os-config-auto"

. "${absPath}/bin/constants/errors.sh"

createSshKey() {

    [ $# -lt 1 ] && {
        echo "$ERR_INVALID_PARAM_NUM"
        exit 1
    }

    [ -e "$1" ] || {
        ssh-keygen -b 4096 -t rsa -N "" -f "$1"
        eval "$(ssh-agent -s)"
        ssh-add "$1"
    }
}
