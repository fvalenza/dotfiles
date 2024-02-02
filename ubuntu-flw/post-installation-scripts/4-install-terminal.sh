#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

#-------------------#
# Preparatory setup #
#-------------------#

username=$(id -u -n 1000)
userhome=/home/$username
rootftdir=$userhome/root-filetree
develdir=$rootftdir/devel
dotfilesdir=$develdir/src/dotfiles
postinstallscriptsdir=$dotfilesdir/ubuntu-flw/post-installation-scripts

#--------------------#
#  Utility functions #
#--------------------#

run_as_user() {
  sudo -u $username bash -c "$1";
}

#------------------------#
# Alacritty Installation #
#------------------------#

install_alacritty() {
  echo "Installing Alacritty"
  add-apt-repository -y ppa:aslatter/ppa
  nala update
  nala install -y alacritty
  echo "Configuring Alacritty"
  cp -R $dotfilesdir/ubuntu-flw/dotconfig/alacritty $userhome/.config
  chown -R "$username:$username" "$userhome/.config/alacritty"
}

install_guake() {
  echo "Installing Guake"
  nala install -y guake
  guake --restore-preferences $dotfilesdir/ubuntu-flw/dotguake/fva-guake-preferences

}



#-------------------------#
# Bash Configuration      #
#-------------------------#

# The idea is that i have a master personal .bashrc file (my-bashrc-config.sh) that should be sourced at the end of ~/.bashrc
# All other custom .bashrc infos are splitted in the dotbashrc folder and sourced in my-bashrc-config if necessary
configure_bash() {
  echo "Configuring Bash"
  # copy .bashrc files into ~/dotbashrc
  mkdir -p $userhome/dotbashrc
  cp -R $dotfilesdir/dotbashrc/. $userhome/dotbashrc
  chown -R "$username:$username" "$userhome/dotbashrc"

  # add to ~/.bashrc to source my personal configurations
  MYBASHRC_CONFIG=$userhome/dotbashrc/my-bashrc-config.sh
  SOURCE_MYBASHRC_CONFIG_CMD="if [ -f $MYBASHRC_CONFIG ]; then source $MYBASHRC_CONFIG; fi"

  if [[ -f ~/.bashrc ]]; then
    if grep -Fxq "$SOURCE_MYBASHRC_CONFIG_CMD" ~/.bashrc; then
      # bashrc already setup
      :
    else
      echo $SOURCE_MYBASHRC_CONFIG_CMD >> $userhome/.bashrc
    fi
  else
    cp my-default-bashrc $userhome
    mv $userhome/my-default-bashrc $userhome/.bashrc
    chown "$username:$username" "$userhome/.bashrc"
  fi
}

# see https://www.baeldung.com/linux/shell-add-syntax-highlighting-other-features for more details
install_blesh(){
  echo "Installing Ble.sh"
  nala install -y git make gawk
  cd $develdir/external-src
  run_as_user "git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git";
  run_as_user "make -C ble.sh install PREFIX=~/.local";
  run_as_user "echo 'source ~/.local/share/blesh/ble.sh' >> ~/.bashrc";
}

#-------------------------#
# Main Script             #
#-------------------------#

install_alacritty
install_guake
configure_bash
install_blesh
