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

#----------------------------------------#
# Update packages list and update system #
#----------------------------------------#
apt update
apt upgrade -y


#------------------------#
# Root-filetree creation #
#------------------------#

# TODO. + set DEVEL_DIR, cdd alias, INSTALL_DIR
cd $userhome
run_as_user "mkdir -p root-filetree";
cd root-filetree
run_as_user "mkdir -p archives audio devel documents Games images litterature softwares videos";
cd audio
run_as_user "mkdir -p music podcast";
cd ../devel
run_as_user "mkdir -p book external-src install notes src";
cd ../images
run_as_user "mkdir -p artwork charts photos screenshots";
cd artwork
run_as_user "mkdir -p wallpaper";
cd ../../litterature
run_as_user "mkdir -p book partitions user-manuals";

#------------------------------#
# Get the dotfiles from github #
#------------------------------#
cd $develdir/src

run_as_user "git clone --recursive https://github.com/fvalenza/dotfiles";


#--------------------#
# Install components #
#--------------------#

cd $postinstallscriptsdir

# https://stackoverflow.com/a/8352939
# /bin/bash 0-unbloat-ubuntu.sh
# /bin/bash 1-install-essentials.sh
# /bin/bash 2-install-app-launcher.sh
# /bin/bash 3-install-desktop-customization.sh
# /bin/bash 4-install-terminal.sh
# /bin/bash 5-install-development-tools.sh
# /bin/bash 6-install-media.sh
# /bin/bash 7-install-gaming.sh
# /bin/bash 8-install-tools.sh
