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

#-----------------------------------------------#
# Install packages that requires EULA agreement #
#-----------------------------------------------#

# dependency for ubuntu-restricted-extra
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
nala install -y  ttf-mscorefonts-installer


#-------------------------------#
# Install media utilities/tools #
#-------------------------------#
nala install -y ubuntu-restricted-extras vlc pulseaudio pavucontrol
