#!/bin/bash

absPath="${PWD%%os-config-auto*}os-config-auto"

export DEFAULT_EMAIL_LOCATION="${absPath}/email.txt"
export DEFAULT_SSH_LOCATION="$HOME/.ssh/id_rsa"
export DEFAULT_PUB_SSH_LOCATION="${DEFAULT_SSH_LOCATION}.pub"
export DEFAULT_SALT_LOCATION="${absPath}/gt.enc"
export DEFAULT_PASS_LOCATION="${absPath}/pass.txt"
export DEFAULT_TOKEN_LOCATION="${absPath}/token.txt"
export DEFAULT_STATE_LOCATION="${absPath}/state.txt"
