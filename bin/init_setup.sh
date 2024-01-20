#!/bin/bash

# read the state file
# if doesn't exist create new with initial state and assign it to state variable
# open until loop which uses state variable as flag
# use case for each state

local state='os_setup' 
local stateLoc="$(dirname "$PWD")/state.txt}"

if test -e "$stateLoc"
then
    state=$(cat "$stateLoc")
else
  printf 'os_setup' > "$stateLoc" 
fi 

until [ "$state" == 'done' ] 
do
    case $state in
        'os_setup')
            sh "./os_setup.sh"
            printf 'os_fixes' > state.txt ;;
        'os_fixes')
            sh "./os_fixes.sh"
            printf 'git_ssh_setup' > state.txt ;;
        'git_ssh_setup')
            sh "./git_ssh_setup.sh"
            printf 'repos_setup' > state.txt ;;
        'repos_setup')
            sh "./repos_setup.sh"
            printf 'software_setup' > state.txt ;;
        'software_setup')
            sh "./software_setup.sh"
            printf 'emacs_setup' > state.txt ;;
        'emacs_setup')
            sh "./emacs_setup.sh"
            printf 'clean_up' > state.txt ;;
        'clean_up')
            sh "./clean_up.sh"
            printf 'done' > state.txt ;;
    esac
    state=$(cat state.txt)
done
