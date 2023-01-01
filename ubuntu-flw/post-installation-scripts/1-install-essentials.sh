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
nala install -y kitty htop bashtop neofetch tldr autojump


# Brave browser
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
nala update


#-----------------------------------#
# Packages & Programs Configuration #
#-----------------------------------#

git config --global user.email "florian.valenza@gmail.com"
git config --global user.name "Florian Valenza"
# git config --global credential.helper store
echo " Do not forget to run \"git config --global credential.helper store\" to setup Token "

run_as_user "tldr -u"; # updqte tldr database


# # qwerty-fr keyboard layout
# wget -O qwerty-fr.deb https://github.com/qwerty-fr/qwerty-fr/releases/download/v0.7.2/qwerty-fr_0.7.2_linux.deb


# nala install -y ./qwerty-fr.deb
