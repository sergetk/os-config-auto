#!/bin/bash
#: Title	: software_setup 
#: Author	: stk
#: Description	: install software 
#: Version 	: 0.1
#: Options 	: none
#

cat pass.txt | sudo -S sh -c "yes | pacman -S feh"
cat pass.txt | sudo -S sh -c "yes | pacman -S keepass"
sed -i 's/bottom/top/g' ~/.i3/config 

#installing brave browser
#sudo sed -Ei '/EnableAUR/s/^#//' /etc/pamac.conf
cat pass.txt | sudo -S sh -c "sed -Ei 'EnableAUR/s/^#//' /etc/pamac.conf"
cat pass.txt | sudo -S sh -c "yes | pacman -S brave-browser"
sed -i 's/palemoon/brave/' ~/.i3/config

#installing zsh
cat pass.txt | sudo -S sh -c "yes | pacman -S zsh"

#installing node version manager
cat pass.txt | sudo -S sh -c "yes | pacman -S nvm"

echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "/usr/share/nvm/init-nvm.sh" ] && . "/usr/share/nvm/init-nvm.sh"' >> ~/.zshrc

echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "/usr/share/nvm/init-nvm.sh" ] && . "/usr/share/nvm/init-nvm.sh"' >> ~/.bashrc

export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/init-nvm.sh 

nvm install node
nvm use node
nvm -v
npm -v
node -v
