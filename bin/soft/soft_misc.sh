#!/usr/bin/env bash
#
#: Title	: software_setup 
#: Author	: stk
#: Description	: install software 
#: Version 	: 0.1
#: Options 	: none
#

absPath="${PWD%%os-config-auto*}os-config-auto"
. "${absPath}/bin/utils/util_functions.sh"

append_nvm_to_shellrc() #@ append nvm path to shell rc file: $1 shell rc file path
{
  # shellcheck disable=SC2016
  append_to 'export NVM_DIR="$HOME/.nvm"' "$1"
  append_to '[ -s "/usr/share/nvm/init-nvm.sh" ] && . "/usr/share/nvm/init-nvm.sh"' "$1"
}

installMisc() {

  y_install feh
  y_install keepass 

  sed -i 's/bottom/top/g' ~/.i3/config 

  #installing brave browser
  sudo_cmd "sed -i 's/^#EnableAUR/EnableAUR/' /etc/pamac.conf"

  y_install brave-browser
  sed -i 's/palemoon/brave/' ~/.i3/config

  #installing zsh
  y_install zsh

  #installing node version manager
  y_install nvm 

  curl -fsSL -o install_ohmyzsh.sh https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
  sh install_ohmyzsh.sh --unattended

  append_nvm_to_shellrc "$HOME/.zshrc"
  append_nvm_to_shellrc "$HOME/.bashrc"

  export NVM_DIR="$HOME/.nvm"
  # shellcheck source=/dev/null
  source /usr/share/nvm/init-nvm.sh 

  nvm install node
  nvm use node
  nvm alias default node

  y_install dart
  #shellcheck disable=SC2016
  append_to 'export PATH="$PATH:/usr/lib/dart/bin"' "$HOME/.profile"
}
