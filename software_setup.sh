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
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#installing node version manager
cat pass.txt | sudo -S sh -c "yes | pacman -S nvm"
echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.zshrc
echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.bashrc
