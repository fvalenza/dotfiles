#!/bin/bash

# Put here all environment variables
export DEVEL_DIR='/homelocal/fvalenza/devel'

export PATH=$PATH:$DEVEL_DIR/src/dotfiles/bin:$DEVEL_DIR/install/sbin:$DEVEL_DIR/install/bin:$DEVEL_DIR/install/root_local/usr/bin

export JAVA_HOME='/homelocal/fvalenza/devel/install/root_local/usr/java/jre1.8.0_181'

export MYSQL_HOME='/homelocal/fvalenza/devel/install/root_local/usr/mysql/mysql-5.7.23-linux-glibc2.12-x86_64'

export OPENSF_BIN=$DEVEL_DIR/install/openSF/openSF

export BEYOND_COMP_BIN='/home/fvalenza/bin'

export PATH=$PATH:$OPENSF_BIN:$BEYOND_COMP_BIN

# Seeps is ported to python3 but use on my pc 3.5.3 ( should be >= 3.6.0 even). 3.5.2 is installed atm and no sudo rights
export PYTHON_353_PATH=/homelocal/fvalenza/devel/install/bin
export PATH=$PYTHON_353_PATH:$PATH

# export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/local/fvalenza/devel/install/lib64/pkgconfig:/local/fvalenza/devel/install/lib/pkgconfig:/opt/ros/hydro/lib/pkgconfig:/opt/openrobots/lib/pkgconfig

# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/usr/local/lib64:/local/fvalenza/devel/install/lib64:/local/fvalenza/devel/install/lib:/opt/ros/hydro/lib:/opt/openrobots/lib

# export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages:/local/fvalenza/devel/install/lib64:/local/fvalenza/devel/install/lib/python2.7/site-packages:/opt/ros/hydro/lib/python2.7/dist-packages

# export RBDL_INCLUDE_DIR=/local/fvalenza/devel/install/include
# export RBDL_PATH=$RBDL_PATH:$DEVEL_DIR
# export RBDL_INCLUDE_PATH=$RBDL_INCLUDE_PATH:$DEVEL_DIR/install/include
# export RBDL_LIBRARY_PATH=$RBDL_LIBRARY_PATH:$DEVEL_DIR/install/lib

# export SUBLIME_CONFIG_DIR=/home/fvalenza/.config/sublime-text-3/Packages/User
