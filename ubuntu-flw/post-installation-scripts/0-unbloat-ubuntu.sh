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


#----------------------#
# Remove snap "bloats" #
#----------------------#

# Remove firefox, thunderbird, gnome-games, snap

snap remove firefox
nala purge -y thunderbird* gnome-games gnome-{mahjongg,mines,sudoku} apport-gtk
nala autoremove -y

#todo remove snap ?

echo "Unbloating Ubuntu finished. Rebooting in 10 seconds"
sleep 10
reboot
