#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
# builddir=$(pwd)
userhome=/home/$username
rootftdir=$userhome/root-filetree
develdir=$rootftdir/devel
dotfilesdir=$develdir/src/dotfiles
tmpinstalldir=$userhome/tmp/ubuntu-install
logfile=$tmpinstalldir/post-install.log

run_as_user() {
  sudo -u $username bash -c "$1";
}












