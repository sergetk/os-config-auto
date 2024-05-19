#!/usr/bin/env bash
wallpapers=("abstract_ball" "black_orange" "chess_art" "concrete_art" "desert_water" "exploring_worlds" "green_city" "hartbeat-uw" "ice_cubes" "moon_ny" "sad_mood" "science_fiction" "sf_art" "spacecat" "space_kitten" "spacemonkey" "tokyo")

#@ return exit code
#$ index
setWallpaperByIndex() {
  local default_wallpaper_path="$HOME/.config/wallpapers"
  local index=$1
  local wallpaperPath="$default_wallpaper_path/${wallpapers[index]}.jpg"
  
  feh --no-fehbg --bg-fill $wallpaperPath
}

setRandomWallpaper() {
  local index=$(( RANDOM % ${#wallpapers[@]} ))
  setWallpaperByIndex "$index"
}

setRandomWallpaper $@
