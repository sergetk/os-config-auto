#!/bin/bash

#read the state file
#if doesn't exist create new with initial state and assign it to state variable
# open until loop which uses state variable as flag
# use case for each state

state='os_setup' 

if test -e "state.txt"
then
    state=$(cat state.txt)
else
  printf 'os_setup' > state.txt
fi 

until [ "$state" == 'done' ] 
do
    case $state in
        'os_setup')
            sh "./os_setup.sh"
            printf 'software_setup' > state.txt ;;
        'software_setup')
            sh -c "./software_setup.sh"
            printf 'token_decode' > state.txt ;;
        'token_decode')
            sh -c "./token_decoder.sh"
            printf 'git_ssh_setup' > state.txt ;;
        'git_ssh_setup')
            sh -c "./git_ssh_setup.sh"
            printf 'emacs_setup' > state.txt ;;
        'emacs_setup')
            sh -c "./emacs_setup.sh"
            printf 'repos_setup' > state.txt ;;
        'repos_setup')
            sh -c "./repos_setup.sh"
            printf 'done' > state.txt ;;
    esac
    state=$(cat state.txt)
done
