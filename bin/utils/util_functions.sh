#!/usr/bin/env bash

#: Titile  : util_functions.sh
#: Author  : stk
#: Description : collection of reusable functions 
#: Version : 0.1
#: Options : none

absPath="${PWD%%os-config-auto*}os-config-auto"
passLoc="${absPath}/pass.txt"

sudo_cmd() #@ USAGE: sudocmd $2 -sudo password file (default pass.txt); $1 - command to run; 
{
  pass="${2:-$passLoc}"
  (cat "$pass") | sudo -S sh -c "$1" 
}

## function which installs software package with root previledges
## and automatically yes from prompt with yes | no options 
y_install() #@ USAGE: aconfinst $2 -sudo password file (default pass.txt); $1 - package name;
{
  sudo_cmd "yes | pacman -S $1" "${2:-$passLoc}"
}

append_to() #@ $1 - command/text, $2 - target, $3 - test mode (optional)
{
  # printf is hard to overwrite from tests,use test flag ($3) instead, default 1 (false)
  testMode="${3-:1}"
  if [ "$testMode" = "0" ]
  then
    printf "%b\n" "$*"
  else
    printf "%b\n" "$1" >> "$2"
  fi
}

append_to_i3() #@ append_to_i3  $1 - comment , $2 - command;
{
  i3_target="$HOME/.i3/config"
  append_to "$1" "$i3_target"
  append_to "$2" "$i3_target"
}

write_to() #@ $1 - command/text, $2 - target, $3 - test mode (optional)
{
  # printf is hard to overwrite from tests,use test flag ($3) instead, default 1 (false)
  testMode="${3-:1}"
  if [ "$testMode" = "0" ]
  then
    printf "%b\n" "$*"
  else
    printf "%b\n" "$1" > "$2"
  fi
}

gclone() #@ USAGE: gclone $1 - git url; $2 - new name of cloned repository (optional);
{
  repo_name="${2:-$(basename "${1%.git}")}"
  if ! test -d "$HOME/$repo_name" 
  then
    echo "Started cloning git repository $repo_name"
    git clone "$1" "$repo_name" 
    echo "Finished cloning git repository $repo_name"
  fi
}

gclone_p() #@ USAGE: gclone_p $1 - name of personal repository; $2 - alternative name for directory (optional);
{
  gclone "git@github.com:sergetk/$1.git" "${2:-$1}"
}
