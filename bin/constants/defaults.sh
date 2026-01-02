#!/usr/bin/env bash

absPath="${PWD%%os-config-auto*}os-config-auto"

export DEFAULT_DBLOCK_LOCATION="/var/lib/pacman/db.lck"
export DEFAULT_EMAIL_LOCATION="${absPath}/email.txt"
export DEFAULT_SSH_DIR="$HOME/.ssh"
export DEFAULT_HOSTS_SSH_LOCATION="${DEFAULT_SSH_DIR}/known_hosts"
export DEFAULT_SSH_LOCATION="${DEFAULT_SSH_DIR}/id_rsa"
export DEFAULT_PUB_SSH_LOCATION="${DEFAULT_SSH_LOCATION}.pub"
export DEFAULT_SALT_LOCATION="${absPath}/gt.enc"
export DEFAULT_PASS_LOCATION="${absPath}/pass.txt"
export DEFAULT_TOKEN_LOCATION="${absPath}/token.txt"
export DEFAULT_STATE_LOCATION="${absPath}/state.txt"
export GIT_SSH_HOSTS_ENTRY="github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl"
