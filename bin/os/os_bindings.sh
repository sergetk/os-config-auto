#!/usr/bin/env bash
absPath="${PWD%%os-config-auto*}os-config-auto"
. "${absPath}/bin/utils/util_functions.sh"  

setup_bindings() {
  updateI3Bindings "$1"
  installXorg
  #  rebindKeys
}

updateI3Bindings() {
  configFile=${1:-'~/.i3/config'}
  #disable prtsc key and its bindings
  sed -i 's/bindsym Print/#bindsym Print/' "$configFile"
  # shellcheck disable=SC2016
  sed -i 's/bindsym $mod+Print/#bindsym $mod+Print/' "$configFile"
  # shellcheck disable=SC2016
  sed -i 's/bindsym $mod+Shift+Print/bindsym $mod+Shift+p/' "$configFile" 
}

installXorg() {
  y_install xorg-xmodmap
  y_install xorg-xev
}

rebindKeys() {
  file=~/.Xmodmap
  xmodmap -pke > "$file"
  print_key="Print"
  super_key="Super_R"
  printKeyMatch=

  while IFS= read -r line; do
    if [[ $line == *"$print_key"* ]]; then
      printKeyMatch="$line"
      break; 
    fi
  done < "$file"

  [ -n "$printKeyMatch" ]  || {
    printf "%s\n" "No $print_key found!"
    exit 1;
  }

  printf "%s\n" "$printKeyMatch"

}
