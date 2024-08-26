#!/usr/bin/env bash

create-es6() { #@ USAGE: create-es6 $1 - path;
  createDir "$1"

  if [ -d "$1" ]; then
    
  fi
  printf "failed to create project direcotry %s" "$1"
}
