#!/usr/bin/env bash

absPath="${PWD%%os-config-auto*}os-config-auto"
. "${absPath}/bin/constants/defaults.sh"

export DONE_STATE="DONE"
export OS_UPDATE_STATE="OS_UPDATE"
export OS_FIXES_STATE="OS_FIXES"
export OS_SSH_STATE="OS_SSH"
export GIT_SSH_STATE="GIT_SSH"
export GIT_REPOS_STATE="GIT_REPOS"
export GIT_CONFIG_STATE="GIT_CONFIG"
export SOFT_MISC_STATE="SOFT_MISC"
export SOFT_EMACS_STATE="SOFT_EMACS"
export SOFT_DEV_STATE="SOFT_DEV"
export UTIL_CLEAN_STATE="UTIL_CLEAN"

export OS_UPDATE_FUNC="updateOS"
export OS_FIXES_FUNC="applyOsFixes"
export OS_SSH_FUNC="createSshKey"
export GIT_SSH_FUNC="createGitToken"
export GIT_CONFIG_FUNC="createGitConfig"
export GIT_REPOS_FUNC="cloneGitRepos"
export SOFT_MISC_FUNC="installMisc"
export SOFT_EMACS_FUNC="installEmacs"
export SOFT_DEV_FUNC="installDev"
export UTIL_CLEAN_FUNC="cleanUp"

#salt pass token ssh_pub
export -A stateFuncParams=()
stateFuncParams["$OS_UPDATE_FUNC"]=''
stateFuncParams["$OS_FIXES_FUNC"]=''
stateFuncParams["$OS_SSH_FUNC"]="$DEFAULT_SSH_LOCATION"
stateFuncParams["$GIT_SSH_FUNC"]="$DEFAULT_SALT_LOCATION $DEFAULT_PASS_LOCATION $DEFAULT_TOKEN_LOCATION $DEFAULT_PUB_SSH_LOCATION"
stateFuncParams["$GIT_CONFIG_FUNC"]="$DEFAULT_EMAIL_LOCATION"
stateFuncParams["$GIT_REPOS_FUNC"]="$DEFAULT_HOSTS_SSH_LOCATION"
stateFuncParams["$SOFT_MISC_FUNC"]=''
stateFuncParams["$SOFT_EMACS_FUNC"]=''
stateFuncParams["$SOFT_DEV_FUNC"]=''
stateFuncParams["$UTIL_CLEAN_FUNC"]=''

export -A stateTransitions=()
stateTransitions["$OS_UPDATE_STATE"]="$OS_UPDATE_FUNC $OS_FIXES_STATE"
stateTransitions["$OS_FIXES_STATE"]="$OS_FIXES_FUNC $OS_SSH_STATE"
stateTransitions["$OS_SSH_STATE"]="$OS_SSH_FUNC $GIT_SSH_STATE"
stateTransitions["$GIT_SSH_STATE"]="$GIT_SSH_FUNC $GIT_CONFIG_STATE"
stateTransitions["$GIT_CONFIG_STATE"]="$GIT_CONFIG_FUNC $GIT_REPOS_STATE"
stateTransitions["$GIT_REPOS_STATE"]="$GIT_REPOS_FUNC $SOFT_MISC_STATE"
stateTransitions["$SOFT_MISC_STATE"]="$SOFT_MISC_FUNC $SOFT_EMACS_STATE"
stateTransitions["$SOFT_EMACS_STATE"]="$SOFT_EMACS_FUNC $SOFT_DEV_STATE"
stateTransitions["$SOFT_DEV_STATE"]="$SOFT_DEV_FUNC $UTIL_CLEAN_STATE"
stateTransitions["$UTIL_CLEAN_STATE"]="$UTIL_CLEAN_FUNC $DONE_STATE"
