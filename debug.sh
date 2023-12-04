#!/bin/bash
## file for debuggig specific part of the script

source "functions_util.sh"

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
