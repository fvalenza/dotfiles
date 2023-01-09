#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

#-------------------#
# Preparatory setup #
#-------------------#

username=$(id -u -n 1000)
userhome=/home/$username
rootftdir=$userhome/root-filetree
develdir=$rootftdir/devel
dotfilesdir=$develdir/src/dotfiles
postinstallscriptsdir=$dotfilesdir/ubuntu-flw/post-installation-scripts

#--------------------#
#  Utility functions #
#--------------------#

run_as_user() {
  sudo -u $username bash -c "$1";
}


#-----------------------#
# Install utilities CLI #
#-----------------------#

# Brave browser
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
# Beyond compare
wget https://www.scootersoftware.com/bcompare-4.4.4.27058_amd64.deb

nala update

nala install -y brave-browser htop bashtop neofetch tldr autojump unzip make python3-pip gpaste tree ncal
nala install -y ./bcompare-4.4.4.27058_amd64.deb

rm ./bcompare-4.4.4.27058_amd64.deb
# # qwerty-fr keyboard layout
# wget -O qwerty-fr.deb https://github.com/qwerty-fr/qwerty-fr/releases/download/v0.7.2/qwerty-fr_0.7.2_linux.deb
# nala install -y ./qwerty-fr.deb
# rm ./qwerty-fr.deb

#-----------------------------------#
# Packages & Programs Configuration #
#-----------------------------------#

run_as_user "git config --global user.email \"florian.valenza@gmail.com\"";
run_as_user "git config --global user.name \"Florian Valenza\"";
run_as_user "git config --global credential.helper cache";
echo " Do not forget to run \"git config --global credential.helper store\" if you want to remember token after first usage. Warning : plan-text file used for storage. Better to use ssh. Caching enabled "
# https://stackoverflow.com/questions/35942754/how-can-i-save-username-and-password-in-git   or use cache  https://stackoverflow.com/a/51327559

run_as_user "tldr -u"; # updqte tldr database




