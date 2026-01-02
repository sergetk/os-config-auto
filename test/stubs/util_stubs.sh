#!/usr/bin/env bash

#: Titile  : stubs_util.sh
#: Author  : stk
#: Description : collection of function stubs
#: Version : 0.1
#: Options : none

stubSudo() {
  # shellcheck disable=SC2329
  sudo() {
    printf "%s\n" "$*"
    return 0
  }
}

stubSudoCMD() {
  # shellcheck disable=SC2329
  sudo_cmd() {
    printf "%s\n" "$*"
    return 0
  }
}

stubGit() {
  # shellcheck disable=SC2329
  git() {
    printf "%s\n" "$*"
    return 0
  }
}

stubCat() {
  # shellcheck disable=SC2329
  cat() {
    printf "%s\n" "$*"
    return 0
  }
}
