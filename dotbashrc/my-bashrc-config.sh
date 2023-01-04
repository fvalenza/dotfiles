#!/bin/bash

# https://leogtzr.medium.com/how-to-organize-your-bashrc-e755590f431b
# https://www.freecodecamp.org/news/bashrc-customization-guide/
# https://medium.com/@tzhenghao/a-guide-to-building-a-great-bashrc-23c52e466b1c

# https://askubuntu.com/questions/404424/how-do-i-restore-bashrc-to-its-default   # Default basrc can be found in ubuntu in /etc/skel

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


#===============================#
#         Config                #
#===============================#
. $userhome/dotbashrc/config.bashrc
