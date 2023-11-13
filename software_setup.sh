#!/bin/bash
#: Title	: software_setup 
#: Author	: stk
#: Description	: install software 
#: Version 	: 0.1
#: Options 	: none
#

source functions_util.sh

y_install feh
y_install keepass 

sed -i 's/bottom/top/g' ~/.i3/config 

#installing brave browser
#cat pass.txt | sudo -S sh -c "sed -Ei 'EnableAUR/s/^#//' /etc/pamac.conf"
sudo_cmd "sed -Ei 'EnableAUR/s/^#//' /etc/pamac.conf"


y_install brave-browser
sed -i 's/palemoon/brave/' ~/.i3/config

#installing zsh
#cat pass.txt | sudo -S sh -c "yes | pacman -S zsh"
y_install zsh

#installing node version manager
#cat pass.txt | sudo -S sh -c "yes | pacman -S nvm"
y_install zsh

nvmdir =
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "/usr/share/nvm/init-nvm.sh" ] && . "/usr/share/nvm/init-nvm.sh"' >> ~/.zshrc

echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "/usr/share/nvm/init-nvm.sh" ] && . "/usr/share/nvm/init-nvm.sh"' >> ~/.bashrc

export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/init-nvm.sh 

nvm install node
nvm use node
nvm alias default node

nvm -v
npm -v
node -v

cat pass.txt | sudo -S sh -c "yes | pacman -S dart"

echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> ~/.profile
