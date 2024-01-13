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

#----------------------------------------#
# Update packages list and update system #
#----------------------------------------#
apt update
apt upgrade -y


#-------------------------------------------------------------------------#
# Install utilities to facilitate installation ( they are useful anyway ) #
#-------------------------------------------------------------------------#
apt install -y wget apt-transport-https curl git nala

#------------------------#
# Root-filetree creation #
#------------------------#

# TODO. + set DEVEL_DIR, cdd alias, INSTALL_DIR
mkdir -p $userhome/root-filetree
mkdir -p $userhome/root-filetree/archives
mkdir -p $userhome/root-filetree/audio
mkdir -p $userhome/root-filetree/audio/music
mkdir -p $userhome/root-filetree/audio/podcast
mkdir -p $userhome/root-filetree/devel
mkdir -p $userhome/root-filetree/devel/book
mkdir -p $userhome/root-filetree/devel/external-src
mkdir -p $userhome/root-filetree/devel/install
mkdir -p $userhome/root-filetree/devel/install/bin
mkdir -p $userhome/root-filetree/devel/notes
mkdir -p $userhome/root-filetree/devel/src
mkdir -p $userhome/root-filetree/documents
mkdir -p $userhome/root-filetree/games
mkdir -p $userhome/root-filetree/images
mkdir -p $userhome/root-filetree/images/artwork
mkdir -p $userhome/root-filetree/images/artwork/wallpaper
mkdir -p $userhome/root-filetree/images/charts
mkdir -p $userhome/root-filetree/images/photos
mkdir -p $userhome/root-filetree/images/screenshots
mkdir -p $userhome/root-filetree/litterature
mkdir -p $userhome/root-filetree/litterature/book
mkdir -p $userhome/root-filetree/litterature/partitions
mkdir -p $userhome/root-filetree/litterature/user-manuals
mkdir -p $userhome/root-filetree/music
mkdir -p $userhome/root-filetree/softwares
mkdir -p $userhome/root-filetree/videos
mkdir -p $userhome/root-filetree/work


chown -R "$username:$username" "$userhome"

#------------------------------#
# Get the dotfiles from github #
#------------------------------#
cd $develdir/src

run_as_user "git clone --recursive https://github.com/fvalenza/dotfiles";


ALIAS_CD_TO_INSTALL_DIR="alias cdpostinstall=cd  $postinstallscriptsdir"
run_as_user "echo $ALIAS_CD_TO_INSTALL_DIR >> ~/.bashrc";
#BUG. for the alias cdpostinstall, add '' in bashrc around the command to be aliased. Perhaps echo -ne here to fix it with \' in ALIAS_CD_TO_INSTALL_DIR ? 


#--------------------#
# Install components #
#--------------------#

cd $postinstallscriptsdir

# WARNING where to put the downloaded deb files
# https://stackoverflow.com/a/8352939

# /bin/bash 0-unbloat-ubuntu.sh
# /bin/bash 1-install-essentials.sh
# /bin/bash 2-install-ulauncher.sh
# /bin/bash 3-install-desktop-customization.sh
# /bin/bash 4-install-terminal.sh
# /bin/bash 5-install-development-tools.sh
# /bin/bash 6-install-media.sh
# /bin/bash 7-install-gaming.sh
# /bin/bash 8-install-tools.sh
# /bin/bash 9-gsettings.sh
