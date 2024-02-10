#!/bin/bash

absPath="${PWD%%os-config-auto*}os-config-auto"

cleanUp() {
 rm "${absPath}/install_ohmyzsh.sh"
 rm "${absPath}/pass.txt"
 rm "${absPath}/email.txt" 
}
