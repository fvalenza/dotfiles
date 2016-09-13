#!/bin/bash

#################
# .install-bash.sh
# This script creates symlinks for .bashrc config file
#################

### Variables

rm ~/.bashrc
ln -s ~/dotfiles/.bashrc ~/.bashrc

