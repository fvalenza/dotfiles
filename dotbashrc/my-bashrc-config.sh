#!/bin/bash

#-------------------#
# Preparatory setup #
#-------------------#

username=$(id -u -n 1000)
userhome=/home/$username

#===============================#
#   Environment Variables       #
#===============================#
. $userhome/dotbashrc/env.bashrc

#===============================#
#         Functions             #
#===============================#
. $userhome/dotbashrc/function.bashrc

#===============================#
#         Aliases               #
#===============================#
. $userhome/dotbashrc/aliases.bashrc

#===============================#
#         Prompt                #
#===============================#
. $userhome/dotbashrc/prompt.bashrc
