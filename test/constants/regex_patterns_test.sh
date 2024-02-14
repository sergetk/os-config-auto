#!/usr/bin/env bash

absPath="${PWD%%os-config-auto*}os-config-auto"

# shellcheck source=../../bin/constants/regex_patterns.sh
. "${absPath}/bin/constants/regex_patterns.sh"

testRegextPatterns() {
  assertEquals "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$" "$EMAIL_PATTERN"
}

. "${absPath}/lib/shunit2/shunit2"
