#!/bin/bash

username=$(id -u -n 1000)
userhome=/home/$username
rootftdir=$userhome/root-filetree
develdir=$rootftdir/devel
dotfilesdir=$develdir/src/dotfiles
postinstallscriptsdir=$dotfilesdir/ubuntu-flw/post-installation-scripts

export DEVEL_DIR='$develdir'

export GIT_EDITOR=vim

export PATH=$PATH:$DEVEL_DIR/src/dotfiles/bin:$DEVEL_DIR/install/sbin:$DEVEL_DIR/install/bin
