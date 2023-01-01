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



nala install -y gnome-tweaks gnome-shell-extension-manager gnome-shell-extensions

#-----------------------------------#
# Desktop environment Configuration #
#-----------------------------------#

# cd $dotfilesdir
# source $dotfilesdir/ubuntu-flw/gnome-config-nordic.sh
