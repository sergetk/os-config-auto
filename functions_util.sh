#!/bin/bash
#: Titile  : functions_util.sh 
#: Author  : stk
#: Description : collection of reusable functions 
#: Version : 0.1
#: Options : none

sudo_cmd() #@ USAGE: sudocmd $2 -sudo password file (default pass.txt); $1 - command to run; 
{
   cat "${2:-pass.txt}" | sudo -S sh -c "$1" 
}

## function which installs software package with root previledges
## and automatically yes from prompt with yes | no options 
y_install() #@ USAGE: aconfinst $2 -sudo password file (default pass.txt); $1 - package name;
{
   sudo_cmd "yes | pacman -S $1" "${2:-pass.txt}"
}

append_to() #@ $1 - command, $2 - target
{
  echo $1 >> $2
}
