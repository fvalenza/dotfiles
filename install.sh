#!/bin/bash
#################
# .install.sh
# This script creates symlinks for .virmrc config file
#################

### Install vim-plug for Vim on Unix
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# If working with neovim, then use
#curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

### Variables

files="vimrc"

### Create symbolic links

for file in $files; do
	echo "Creating symlink of $file"
	ln -s ~/dotfiles/$file ~/.$file
done

