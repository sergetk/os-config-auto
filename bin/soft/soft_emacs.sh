#!/bin/bash
##
absPath="${PWD%%os-config-auto*}os-config-auto"
. "${absPath}/bin/utils/util_functions.sh"

installEmacs() {
    #installing emacs
    y_install emacs

    #append shortcuts and daemon starup command to i3/config
    append_to_i3 "# short-cut to start emacsclient " "bindsym \$mod+Ctrl+Return exec --no-startup-id emacsclient -c"
    append_to_i3 "# short-cut to end emacsclient " "bindsym \$mod+Ctrl+Escape exec --no-startup-id emacsclient -e '(kill-emacs)'"
    append_to_i3 "# start emacs as daemon " "exec_always --no-startup-id emacs --daemon "

}
