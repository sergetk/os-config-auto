#!/usr/bin/env bash

#: Titile  : util_functions.sh
#: Author  : stk
#: Description : collection of reusable functions
#: Version : 0.1
#: Options : none

absPath="${PWD%%os-config-auto*}os-config-auto"
passLoc="${absPath}/pass.txt"

#@ USAGE: sudocmd $2 -sudo password file (default pass.txt); $1 - command to run;
sudo_cmd() {
  pass="${2:-$passLoc}"
  (cat "$pass") | sudo -S sh -c "$1"
}

## function remove db.lck if exists
remove_dblock() {
  [ -e "/var/lib/pacman/db.lck" ] && {
    sudo_cmd "rm /var/lib/pacman/db.lck"
  }
}

## function which installs software package with root previledges
## and automatically yes from prompt with yes | no options
##@ USAGE: aconfinst $2 -sudo password file (default pass.txt); $1 - package name;
y_install() {
  remove_dblock
  sudo_cmd "yes | pacman -S $1" "${2:-$passLoc}"
}

## function which installs software package with root previledges from local source
## and automatically yes from prompt with yes | no options
#@ USAGE: aconfinst $2 -sudo password file (default pass.txt); $1 - package name;
y_install_local() {
  remove_dblock
  sudo_cmd "yes | pacman -U $1" "${2:-$passLoc}"
}

#@ $1 - command/text, $2 - target, $3 - test mode (optional)
append_to() {
  # printf is hard to overwrite from tests,use test flag ($3) instead, default 1 (false)
  testMode="${3-:1}"
  if [ "$testMode" = "0" ]; then
    printf "%b\n" "$*"
  else
    printf "%b\n" "$1" >>"$2" 2>&1
  fi
}

#@ append_to_i3  $1 - comment , $2 - command; $3 - test mode (optional)
append_to_i3() {
  testMode="${3-:1}"
  i3_target="$HOME/.i3/config"
  append_to "$1" "$i3_target" "$testMode"
  append_to "$2" "$i3_target" "$testMode"
}

#@ $1 - command/text, $2 - target, $3 - test mode (optional)
write_to() {
  # printf is hard to overwrite from tests,use test flag ($3) instead, default 1 (false)
  testMode="${3-:1}"
  if [ "$testMode" = "0" ]; then
    printf "%b\n" "$*"
  else
    printf "%b\n" "$1" >"$2"
  fi
}

#@ USAGE: gclone $1 - git url; $2 - new name of cloned repository (optional);
gclone() {
  repo_name="${2:-$(basename "${1%.git}")}"
  if ! test -d "$HOME/$repo_name"; then
    echo "Started cloning git repository $repo_name"
    git clone "$1" "$repo_name"
    echo "Finished cloning git repository $repo_name"
  fi
}

gclone_p() { #@ USAGE: gclone_p $1 - name of personal repository; $2 - alternative name for directory (optional);
  gclone "git@github.com:sergetk/$1.git" "${2:-$1}"
}

isValidPathFormat() { #@ USAGE: isVliadPathFormat $1 - path;
  if [[ "$1" =~ ^[.~]?(\/[a-zA-Z0-9_-]+)+[\/]?$ ]]; then
    return 0
  fi
  return 1
}

createDir() { #@ USAGE: createDir $1 - path;
  isValidPathFormat $1

  if [ $? -eq 0 ]; then
    mkdir -p $1
    if [ -d $1 ]; then
      printf "Directory created at %s" $1
      return 0
    fi
    printf "error: calling mkdir -p $1"
    return 1
  fi
  printf "invalid path = %s" $1
  return 1
}

pathExists() { #@ USAGE: check if path is directory
  [ -z "$1" ] && return 1 || [ -e "$1" ] && return 0 || return 1
}

containsText() { #@ USAGE: containsText $1 - text; $2 - path;
  [ -z "$1" ] && return 1
  pathExists "$2"

  if [ $? -eq 0 ]; then
    grep -q "$1" "$2"
    return $?
  else
    return 1
  fi

  return 1
}
