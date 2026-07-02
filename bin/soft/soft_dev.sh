#!/usr/bin/env bash
##

absPath="${PWD%%os-config-auto*}os-config-auto"
# shellcheck source="../utils/util_functions.sh"
. "${absPath}"/bin/utils/util_functions.sh

installDev() {
  # shellcheck source=/dev/null
  . "$HOME/.nvm/nvm.sh"

  npm install -g bash-language-server
  y_install shellcheck
  npm install -g prettier

  y_install dart
  #shellcheck disable=SC2016
  append_to 'export PATH="$PATH:/usr/lib/dart/bin"' "$HOME/.profile"

  #JAVA17 (needed for react native)
  y_install jdk17-openjdk
  sudo_cmd "archlinux-java set java-17-openjdk"

  #zsh as main shell as it requires confirmation
  sudo_cmd "yes | chsh -s $(which zsh) $USER"
}
