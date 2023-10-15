#!/bin/bash
#: Title	: install_soft
#: Author	: stk
#: Description	: install software 
#: Version 	: 0.1
#: Options 	: none
#

#installing brave browser
#sudo sed -Ei '/EnableAUR/s/^#//' /etc/pamac.conf
##cat pass.txt | sudo -S sh -c "sed -Ei 'EnableAUR/s/^#//' /etc/pamac.conf"
##cat pass.txt | sudo -S sh -c "yes | pacman -S brave-browser"
##sed -i 's/palemoon/brave/' ~/.i3/config

#installing emacs
##cat pass.txt | sudo -S sh -c "yes | pacman -S emacs"
##(echo "# short-cut to start emacs " ; echo bindsym \$mod+Ctrl+Return exec --no-startup-id emacsclient -c ; echo "")>> $HOME/.i3/config
##(echo "# short-cut to kill emacs daemon" ; echo bindsym \$mod+Ctrl+Escape exec --no-startup-id emacsclient -e '(kill-emacs)' ; echo "")>> $HOME/.i3/c
##(echo "# start emacs as daemon " ; echo exec_always --no-startup-id emacs --daemon ; echo "")>> $HOME/.i3/config

#installing zsh
##cat pass.txt | sudo -S sh -c "yes | pacman -S zsh"
##chsh -s $(which zsh)
##sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#installing node version manager
##cat pass.txt | sudo -S sh -c "yes | pacman -S nvm"
#echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.zshrc
#cat pass.txt | sudo -S reboot

##cat pass.txt | sudo -S sh -c "yes | pacman -S feh"
##cat pass.txt | sudo -S sh -c "yes | pacman -S keepass"
##sed -i 's/bottom/top/g' ~/.i3/config 
