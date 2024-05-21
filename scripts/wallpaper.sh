#!/usr/bin/env bash

#$ [testMode]
setRandomWallpaper() {
  local testMode=${1:-1}
  local command="> /dev/null 2>&1"

  
  for x in {0..1}
  do
    if [ "$testMode" -eq 0 ]
    then
      nitrogen --set-zoom-fill --random "$HOME/.config/wallpapers" --head="$x" > /dev/null 2>&1
    else
      nitrogen --set-zoom-fill --random "$HOME/.config/wallpapers" --head="$x"
    fi
  done
}

setRandomWallpaper $@
