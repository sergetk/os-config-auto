#!/usr/bin/env bash

# step 1
# create directory structure if it doesn't exists
# create test and src directories

# step2
# create package.json with npn init

# step3
# install eslint

# step4 install testing framework

absPath="${PWD%%os-config-auto*}os-config-auto"
. "${absPath}/scripts/programming.sh"
. "${absPath}/bin/utils/util_functions.sh"

testCreatePackageJson(){
  file="package.json"
  createProjectJson
  exitCode=$?

  [ -e "$file" ] &&  assertTrue true || assertTrue 'no package.json created' false
  
  assertEquals 0 "$exitCode"
  rm "$file"
}

_validateMatch() {
  containsText "$1"  "$packageJson"
  assertTrue "package.json doesn't have text = $1" $?
}

testSetupEslint() {
  dir="$PWD/node_modules"
  packageJson="$PWD/package.json"
  eslintConfig="$PWD/eslint.config.mjs"
  
  createProjectJson
  setupEslint
  exitCode=$?
  
  [ -d $dir ] && assertTrue true || assertTrue 'no node_modules dir' false
  [ -e $eslintConfig ] && assertTrue true || assertTrue 'no eslint.config.mjs' false

  _validateMatch '"@eslint/js"'
  _validateMatch '"eslint"'
  _validateMatch '"globals"'
  
  assertEquals 0 "$exitCode"

  #clean up
  [ $exitCode -eq 0 ] && {
    rm -rf node_modules
    rm package-lock.json
    rm package.json
    rm eslint.config.mjs
  }
  
}

testSetupJest() {
  dir="$PWD/node_modules"
  packageJson="$PWD/package.json"
  jestConfig="$PWD/jest.config.js"
  
  createProjectJson
  setupJest
  exitCode=$?
  
  [ -d $dir ] && assertTrue true || assertTrue 'no node_modules dir' false
  [ -e $jestConfig ] && assertTrue true || assertTrue 'no jest.config.js' false

  _validateMatch '"@jest/globals"'
  _validateMatch '"jest"'
  _validateMatch '"@types/jest"'
  
  assertEquals 0 "$exitCode"

  #clean up
  [ $exitCode -eq 0 ] && {
    rm -rf node_modules
    rm package-lockb.json
    rm package.json
    rm jest.config.js
  }

}

# shellcheck source=../lib/shunit2/shunit2
. "${absPath}/lib/shunit2/shunit2"
