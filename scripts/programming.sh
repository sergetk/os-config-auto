#!/usr/bin/env bash

absPath="${PWD%%os-config-auto*}os-config-auto"
# shellcheck source=/dev/null
. "$HOME/.nvm/nvm.sh"

templates="$absPath/scripts/templates"

createProjectJson() #@ USAGE: create package.json
{
  yes $'\n' | npm init 1> /dev/null
}

setupEslint() {
  # exit if package.json doesn't exist
  [ -e "package.json" ] || return 1

  #install libs
  npm i --save-dev eslint 1> /dev/null
  npm i --save-dev @eslint/js 1> /dev/null
  npm i --save-dev globals 1> /dev/null

  #create config file
  cp "$templates/eslint/js.config.mjs" eslint.config.mjs

}

setupJest() {
  # exit if package.json doesn't exist
  [ -e "package.json" ] || return 1
  
  npm i --save-dev jest 1> /dev/null
  npm i --save-dev @jest/globals 1> /dev/null
  npm i --save-dev @types/jest 1> /dev/null

  cp "$templates/jest/js.config.js" jest.config.js

  #sedTarget='  "scripts": {\n    "test": "echo \\"Error: no test specified\\" && exit 1"\n  },'
  sed -i ':a;N;$!ba;s/  "scripts": {\n    "test": "echo \\"Error: no test specified\\" && exit 1"\n  },/  "type": "module",\n  "typeAcquisition": {\n    "include": [\n      "jest"\n    ]\n  },\n  "directories": {\n    "test": "jest"\n  },\n  "scripts": {\n    "test": "node --experimental-vm-modules node_modules\/.bin\/jest"\n  },/g' package.json

}
