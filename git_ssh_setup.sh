#!/bin/bash
##

set -e
TOKEN=$(<token.txt) 

if ! { test -e ~/.ssh/ && test -e ~/.ssh/id_rsa ; }
then
    ssh-keygen -b 4096 -t rsa -N "" -f ~/.ssh/id_rsa

    PUBKEY=$(cat ~/.ssh/id_rsa.pub)
    ## echo $PUBKEY

    echo "---before curl ---"
    RESPONSE=$(curl -L -X POST -H "Accept: application/vnd.github+json" \
        -H "Authorization: Bearer $TOKEN" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        https://api.github.com/user/keys \
        -d "{\"title\": \"ssh-desktop-test\",\"key\":\"$PUBKEY\"}")

    echo "--- after curl ---"
    echo "$RESPONSE"

    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa

    echo "Added SSH key to the ssh-agent"
fi
