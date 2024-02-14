#!/usr/bin/env bash

## file for debuggig specific part of the script
absPath="${PWD%%os-config-auto*}os-config-auto"

. "${absPath}/bin/utils/util_functions.sh"

#curl -fsSL -o install_ohmyzsh.sh https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
#sh install_ohmyzsh.sh --unattended


#echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
#echo '[ -s "/usr/share/nvm/init-nvm.sh" ] && . "/usr/share/nvm/init-nvm.sh"' >> ~/.zshrc


#gclone https://aur.archlinux.org/nordvpn-bin.git x2
#gclone_p notes .notes 

# Display the result
#echo $substring

# append to a file test
#append_to "\nhello world $PWD\n" "$PWD/todo.txt"

#(echo "# short-cut to start emacs " ; echo "bindsym \$mod+Ctrl+Return exec --no-startup-id emacsclient -c" ; echo "")>> $HOME/.i3/config

#append_to_i3 "# short-cut to start emacs" "bindsym \$mod+Ctrl+Return exec --no-startup-id emacsclient -c"
#append_to_i3 "# start emacs as daemon " "exec_always --no-startup-id emacs --daemon "

#
#sudo_cmd "yes | pacman -Syu glibc-locales --overwrite /usr/lib/locale/\*/\*"
#append_to 'export PATH="$PATH:/usr/lib/dart/bin"' "$PWD/todo.txt"

#append_to 'export NVM_DIR="$HOME/.nvm"' "$HOME/.zshrc"
#append_to '[ -s "/usr/share/nvm/init-nvm.sh" ] && . "/usr/share/nvm/init-nvm.sh"' "$HOME/.zshrc"
#append_to 'export NVM_DIR="$HOME/.nvm"' "$PWD/todo.txt"
#append_to '[ -s "/usr/share/nvm/init-nvm.sh" ] && . "/usr/share/nvm/init-nvm.sh"' "$PWD/todo.txt"
#y_install fd
#y_install rg

# email_location="$(dirname "$PWD")/email.txt"

# if test -e "$email_location"
# then
#     email=$(cat "$email_location")
#     printf "email = %s, user = %s\n" "$email" "$USER"
#     git config --global user.name "$USER"
#     git config --global user.email "$email" 

#     echo '-----------------------------'
#     git config --global user.name
#     git config --global user.email

# else
#     printf "no email loation specified"
# fi 

# Declare an indexed array of keys
# keys=("key1" "key2" "key3")

# # Declare an associative array to store arrays
# declare -A assoc_array

# # Assign arrays to associative array using keys
# assoc_array["key1"]=("apple" "orange" "banana")
# assoc_array["key2"]=("carrot" "broccoli" "spinach")
# assoc_array["key3"]=("dog" "cat" "bird")

# # Access and print arrays from the associative array
# for key in "${keys[@]}"; do
#   echo "$key: ${assoc_array[$key][@]}"
# done

function createAssArray(){

  declare -A myAssocArray

  array1=("apple" "banana" "cherry")

  local -n ref_array=$array1

  myAssocArray["key1"]=("${ref_array}")

  echo "Array 1:"
  for item in ${myAssocArray[key1]}; do
    echo "$item"
  done
}

createAssArray
