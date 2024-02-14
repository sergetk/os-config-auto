#!/usr/bin/env bash
## 
absPath="${PWD%%os-config-auto*}os-config-auto"
# shellcheck sourse= "../constants/errors.sh"
. "${absPath}/bin/constants/errors.sh"
# shellcheck sourse= "../constants/defaults.sh"
. "${absPath}/bin/constants/defaults.sh"

#@ run : creates local ssh keys, uploads ssh public key to github
## creates git email username global configuration  
## $1  - salt encoded token locaiton (test)
## $2  - pass location (test)
## $3  - decoded tokenlocation  (test)
## $4  - ssh pub-key location (test)

createGitToken() {
  # shellcheck sourse="../constants/errors.sh"
  . "${absPath}/bin/constants/errors.sh"
  # shellcheck sourse="../constants/defaults.sh"
  . "${absPath}/bin/constants/defaults.sh"

  SALT_FILE="${1:-$DEFAULT_SALT_LOCATION}"
  PASS_FILE="${2:-$DEFAULT_PASS_LOCATION}" 
  TOKEN_FILE="${3:-$DEFAULT_TOKEN_LOCATION}"
  SSH_FILE="${4:-$DEFAULT_PUB_SSH_LOCATION}"
  
  [ -e "$SALT_FILE" ] || {
    echo "$ERR_SALT_MISSING" 
    exit 1
  } 
  
  [ -e "$PASS_FILE" ] || {
    echo "$ERR_PASS_MISSING"
    exit 1
  }

  printf "%s" "" > "$TOKEN_FILE"
  [ $? = 0 ] || {
    echo "$ERR_TOKEN_MISSING"
    exit 1
  }

  [ -e "$SSH_FILE" ] || {
    echo "$ERR_SSH_DIR"
    exit 1
  }

  openssl enc -d -aes-256-cbc -in "$SALT_FILE" -out "$TOKEN_FILE" -pass file:"$PASS_FILE" -iter 1000 || 
    {
      echo "$ERR_SSL"
      exit 1
    }

  set -e
  TOKEN=$(< "$TOKEN_FILE") 
  PUBKEY=$(< "$SSH_FILE")
  
  curl -L -X POST -H "Accept: application/vnd.github+json" \
       -H "Authorization: Bearer $TOKEN" \
       -H "X-GitHub-Api-Version: 2022-11-28" \
       https://api.github.com/user/keys \
       -d "{\"title\": \"ssh-desktop-test\",\"key\":\"$PUBKEY\"}" ||
    {
      echo "Curl failed"
      exit 1
    } 
}
