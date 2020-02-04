#!/usr/bin/env bash


# CURRENT_DIR=$(pwd)
# SCRIPT=$(readlink -f $0)
# SCRIPTPATH=`dirname $SCRIPT`
ABSOLUTE_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
CURRENT_DIR=$ABSOLUTE_PATH

#===============================#
#            BASHRC             #
#===============================#
. $CURRENT_DIR/.bashrc


#===============================#
#   Environment Variables       #
#===============================#
. $CURRENT_DIR/env.bashrc

#===============================#
#         Functions             #
#===============================#
. $CURRENT_DIR/function.bashrc

#===============================#
#         Aliases               #
#===============================#
. $CURRENT_DIR/aliases.bashrc

#===============================#
#         Prompt                #
#===============================#
. $CURRENT_DIR/prompt.bashrc
