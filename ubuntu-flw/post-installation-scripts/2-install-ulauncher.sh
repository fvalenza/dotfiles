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

#-------------------------#
# Install Ulauncher        #
#-------------------------#

install_ulauncher() {
  echo "Installing Ulauncher"
  add-apt-repository -y ppa:agornostal/ulauncher
  nala update
  nala install -y ulauncher
}

#-------------------------#
# Install Dependencies     #
#-------------------------#

install_dependencies() {
  echo "Installing Dependencies for ulauncher extensions"
  nala install -y gpaste # For clipboard extension

  cd $develdir/external-src

  run_as_user "git clone https://github.com/soimort/translate-shell"; # For translate extension
  cd translate-shell
  run_as_user "make";
  run_as_user "make install";
}

#-------------------------#
# Copy Configuration       #
#-------------------------#

copy_configuration() {
  echo "Copying Configuration Files"
  cp -R $dotfilesdir/ubuntu-flw/dotconfig/ulauncher $userhome/.config
  cd /usr/share/applications/
  cp ulauncher.desktop $userhome/.config/autostart/
  chown -R "$username:$username" "$userhome/.config/ulauncher"
  chown -R "$username:$username" "$userhome/.config/autostart"
}

#-------------------------#
# Fix Hotkey Issue         #
#-------------------------#

fix_hotkey_issue() {
  echo "Fixing Hotkey Issue"
  nala install -y wmctrl
  echo "Do not forget to start Ulauncher after 9-gsettings script, so that ctrl-space keybind can work"
}

#-------------------------#
# Main Script              #
#-------------------------#

install_ulauncher
install_dependencies
copy_configuration
fix_hotkey_issue
