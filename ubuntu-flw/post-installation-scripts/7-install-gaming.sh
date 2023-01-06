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


nala install -y steam

wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
nala install -y ./discord.deb

rm ./discord.deb

# # Install itch.io
# Aller dans ~/Download
# wget -O itch-setup "https://itch.io/app/download?platform=linux"
# chmod +x itch-setup && ./itch-setup # attention sudo ou pas...


# lutris ?
