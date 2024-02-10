#!/bin/bash

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


export oSUpdateTransition="updateOS $OS_FIXES_STATE"
export osFixesTransition="applyOsFixes $OS_SSH_STATE"
export osSshTransition="createSshKey $GIT_SSH_STATE"
export gitSshTransition="createGitToken $GIT_CONFIG_STATE"
export gitConfigTransition="createGitConfig $GIT_REPOS_STATE"
export gitReposTransition="cloneGitRepos $SOFT_MISC_STATE"
export softMiscTransition="installMisc $SOFT_EMACS_STATE"
export emacsTransition="installEmacs $SOFT_DEV_STATE"
export devTransition="installDev $UTIL_CLEAN_STATE"
export cleanTransition="cleanUp $DONE_STATE"

export -A stateTransitions=()

stateTransitions["$OS_UPDATE_STATE"]="updateOS $OS_FIXES_STATE"
stateTransitions["$OS_FIXES_STATE"]="applyOsFixes $OS_SSH_STATE"
stateTransitions["$OS_SSH_STATE"]="createSshKey $GIT_SSH_STATE"
stateTransitions["$GIT_SSH_STATE"]="createGitToken $GIT_CONFIG_STATE"
stateTransitions["$GIT_CONFIG_STATE"]="createGitConfig $GIT_REPOS_STATE"
stateTransitions["$GIT_REPOS_STATE"]="cloneGitRepos $SOFT_MISC_STATE"
stateTransitions["$SOFT_MISC_STATE"]="installMisc $SOFT_EMACS_STATE"
stateTransitions["$SOFT_EMACS_STATE"]="installEmacs $SOFT_DEV_STATE"
stateTransitions["$SOFT_DEV_STATE"]="installDev $UTIL_CLEAN_STATE"
stateTransitions["$UTIL_CLEAN_STATE"]="cleanUp $DONE_STATE"
