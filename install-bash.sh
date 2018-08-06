#!/usr/bin/env bash

#################
# .install-bash.sh
# This script creates symlinks for .bashrc config file
#################

### Variables
DOTFILES_ROOT=$(pwd -P)


#  If sourcing to .bashrc customized files already done on this machine, do not do this again, else add line in .bashrc to source custom .bashrc files
# if [[ 'grep -Fxq ". $(pwd -P)/source_all.bashrc" ~/.bashrc' ]]
# then
# 	#statements
# 	echo ". $(pwd -P)/source_all.bashrc" >> ~/.bashrc
# fi

BASHRC_COMMAND=". $(pwd -P)/.bashrc.d/source_all.bashrc"

if [[ -f ~/.bash_profile ]]
then
	if grep -Fxq "$BASHRC_COMMAND" ~/.bashrc
	then
	    # code if found
	    :
	else
	    echo $BASHRC_COMMAND >> ~/.bashrc
	fi
fi

# Link .bashrc and .bash_profile
# If file already exists, then just source .bashrc, else symlink to custom bash_profile in this git repo

BASH_PROFILE_COMMAND="if [ -f ~/.bashrc ]; then source ~/.bashrc; fi"

if [[ -f ~/.bash_profile ]]
then
	if grep -Fxq "$BASH_PROFILE_COMMAND" ~/.bash_profile
	then
	    # code if found
	    :
	else
	    echo $BASH_PROFILE_COMMAND >> ~/.bash_profile
	fi
else
    ln -s $DOTFILES_ROOT/.bashrc.d/.bash_profile ~/.bash_profile
fi
