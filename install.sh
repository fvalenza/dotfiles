#!/bin/bash
#################
# .install.sh
# This script creates symlinks for .virmrc config file
#################

### Variables

files="vimrc"

### Create symbolic links

for file in $files; do
	echo "Creating symlink of $file"
	ln -s ~/dotfiles/$file ~/.$file
done

