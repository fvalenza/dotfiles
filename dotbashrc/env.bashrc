#!/bin/bash

username=$(id -u -n 1000)
userhome=/home/$username
rootftdir=$userhome/root-filetree
develdir=$rootftdir/devel
dotfilesdir=$develdir/src/dotfiles
postinstallscriptsdir=$dotfilesdir/ubuntu-flw/post-installation-scripts


export MY_ROOT_FILETREE=$rootftdir
export DEVEL_DIR=$develdir

export GIT_EDITOR=vim

export PATH=$PATH:$DEVEL_DIR/install/bin
export PATH=$PATH:$userhome/.cargo/bin
export PATH=$PATH:$userhome/Applications
