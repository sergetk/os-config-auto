#!/usr/bin/env bash
absPath="${PWD%%os-config-auto*}os-config-auto"

. "${absPath}/bin/constants/errors.sh"

# generate users ssh folder and public private keys
# $1 - file where generated ssh key will be saved 

createSshKey() {

  [ $# -lt 1 ] && {
    printf "%s\n" "$ERR_INVALID_PARAM_NUM"
    exit 1
  }

  [ -e "$1" ] || {
    ssh-keygen -b 4096 -t rsa -N "" -f "$1"
    eval "$(ssh-agent -s)"
    ssh-add "$1"
  }
}
