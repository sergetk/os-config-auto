#!/usr/bin/env bash

absPath="${PWD%%os-config-auto*}os-config-auto"
# shellcheck source=../../bin/constants/defaults.sh
. "${absPath}/bin/constants/defaults.sh"

testDefaults() {
  assertEquals "${absPath}/email.txt" "$DEFAULT_EMAIL_LOCATION"
  assertEquals "$HOME/.ssh/id_rsa" "$DEFAULT_SSH_LOCATION"
  assertEquals "$HOME/.ssh/id_rsa.pub" "$DEFAULT_PUB_SSH_LOCATION"
  assertEquals "${absPath}/gt.enc" "$DEFAULT_SALT_LOCATION"
  assertEquals "${absPath}/pass.txt" "$DEFAULT_PASS_LOCATION"
  assertEquals "${absPath}/token.txt" "$DEFAULT_TOKEN_LOCATION"
  assertEquals "${absPath}/state.txt" "$DEFAULT_STATE_LOCATION"
}

. "${absPath}/lib/shunit2/shunit2"
