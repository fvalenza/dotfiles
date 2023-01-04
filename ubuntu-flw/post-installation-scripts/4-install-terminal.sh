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
# Bash Configuration #
#--------------------#

# copy .bashrc files into ~/dotbashrc
mkdir -p $userhome/dotbashrc
cp -R dotfilesdir=$develdir/src/dotfiles/dotbashrc/. $userhome/dotbashrc

chown -R "$username:$username" "$userhome/dotbashrc"

# add to ~/.bashrc to source my personal configurations

MYBASHRC_CONFIG=$userhome/dotbashrc/my-bashrc-config.sh
SOURCE_MYBASHRC_CONFIG_CMD="if [ -f $MYBASHRC_CONFIG ]; then source $MYBASHRC_CONFIG; fi"

if [[ -f ~/.bashrc ]]
then
  if grep -Fxq "$SOURCE_MYBASHRC_CONFIG_CMD" ~/.bashrc
  then
      # bashrc already setup
      :
  else
      echo $SOURCE_MYBASHRC_CONFIG_CMD >> $userhome/.bashrc
  fi
else
  cp my-default-bashrc $userhome
  mv $userhome/my-default-bashrc $userhome/.bashrc
  chown "$username:$username" "$userhome/.bashrc"
fi


#------------------------#
# Alacritty Installation #
#------------------------#
add-apt-repository -y ppa:aslatter/ppa
nala update
nala install -y alacritty


#-------------------------#
# Alacritty Configuration #
#-------------------------#

cp -R $dotfilesdir/ubuntu-flw/dotconfig/alacritty $userhome/.config

chown -R "$username:$username" "$userhome/.config/alacritty"
