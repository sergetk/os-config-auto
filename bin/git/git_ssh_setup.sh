#!/bin/bash
## 
absPath="${PWD%%os-config-auto*}/os-config-auto"

. "${absPath}/bin/constants/errors.sh"

#@ run : creates local ssh keys, uploads ssh public key to github
## creates git email username global configuration  
## $1  - salt encoded token locaiton (required)
## $2  - pass location (required)
## $3  - decoded tokenlocation  (required)
## $4  - ssh pub-key location (required)

createGitToken() {

    [ $# -lt 4 ] && {
        echo "$ERR_INVALID_PARAM_NUM"
        exit 1
    }
    
    [ -e "$1" ] || {
      echo "$ERR_SALT_MISSING" 
      exit 1
    } 
     
    [ -e "$2" ] || {
      echo "$ERR_PASS_MISSING"
      exit 1
    }

    [ -z "$3" ] && {
       echo "$ERR_TOKEN_MISSING"
       exit 1
    }

    [ -e "$4" ] || {
       echo "$ERR_SSH_DIR"
       exit 1
    }

    openssl enc -d -aes-256-cbc -in "$1" -out "$3" -pass file:"$2" -iter 1000 || 
    {
        echo "$ERR_SSL"
        exit 1
    }

    set -e
    TOKEN=$(< "$3") 
    PUBKEY=$(< "$4")
        
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
