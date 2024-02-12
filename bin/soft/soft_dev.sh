#!/bin/bash
##
absPath="${PWD%%os-config-auto*}os-config-auto"
. "${absPath}/bin/utils/util_functions.sh"

installDev(){
# shellcheck source=/dev/null
. "$HOME/.nvm/nvm.sh"

  npm install -g bash-language-server
  y_install shellcheck

  #zsh as main shell as it requires confirmation
  sudo_cmd "yes | chsh -s $(which zsh)"
}
