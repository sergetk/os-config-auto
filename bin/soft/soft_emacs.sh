#!/usr/bin/env bash
##
absPath="${PWD%%os-config-auto*}os-config-auto"
. "${absPath}/bin/utils/util_functions.sh"

installEmacs() {
  #installing emacs
  #y_install emacs (pre packaged)
  cd "$HOME/emacs-repo"
  y_install libgccjit
  y_install libotf
  y_install tree-sitter
  #use mirror emacs repo as savannah is too slow
  sed -i 's/git\.savannah\.gnu\.org\/git/github\.com\/emacs-mirror/' "$HOME/emacs-repo/.SRCINFO"
  yes | makepkg -C
  y_install_local "emacs-git-*-x86_64.pkg.tar.xz"

  #append shortcuts and daemon starup command to i3/config
  append_to_i3 "# short-cut to start emacsclient " "bindsym \$mod+Ctrl+Return exec --no-startup-id emacsclient -c"
  append_to_i3 "# short-cut to end emacsclient " "bindsym \$mod+Ctrl+Escape exec --no-startup-id emacsclient -e '(kill-emacs)'"
  append_to_i3 "# start emacs as daemon " "exec_always --no-startup-id emacs --daemon "

}
