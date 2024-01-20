#!/bin/bash
##
# shellcheck source=/dev/null
source "$HOME/.nvm/nvm.sh"
source "../lib/functions_util.sh"

#installing emacs
y_install emacs

#append shortcuts and daemon starup command to i3/config
append_to_i3 "# short-cut to start emacsclient " "bindsym \$mod+Ctrl+Return exec --no-startup-id emacsclient -c"
append_to_i3 "# short-cut to end emacsclient " "bindsym \$mod+Ctrl+Escape exec --no-startup-id emacsclient -e '(kill-emacs)'"
append_to_i3 "# start emacs as daemon " "exec_always --no-startup-id emacs --daemon "

npm install -g bash-language-server
y_install shellcheck

#zsh as main shell as it requires confirmation
sudo_cmd "yes | chsh -s $(which zsh)"
