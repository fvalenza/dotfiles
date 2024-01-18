#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

# Check for --all argument
if [ "$1" == "-a" ] || [ "$1" == "--all" ]; then
  AUTO_INSTALL=true
else
  AUTO_INSTALL=false
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

#-------------------------#
# Install Brave Browser   #
#-------------------------#

install_brave_browser() {
  if [ "$AUTO_INSTALL" == "true" ] || (read -p "Do you want to install Brave Browser? (y/n): " install_brave && [ "$install_brave" == "y" ]); then
    echo "Installing Brave Browser"
    curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    nala update
    nala install -y brave-browser
  fi
}

#-------------------------#
# Install Beyond Compare   #
#-------------------------#

install_beyond_compare() {
  if [ "$AUTO_INSTALL" == "true" ] || (read -p "Do you want to install Beyond Compare? (y/n): " install_bc && [ "$install_bc" == "y" ]); then
    echo "Installing Beyond Compare"
    wget https://www.scootersoftware.com/bcompare-4.4.4.27058_amd64.deb
    nala install -y ./bcompare-4.4.4.27058_amd64.deb
    rm ./bcompare-4.4.4.27058_amd64.deb
  fi
}

#-------------------------#
# Install Other Utilities #
#-------------------------#

install_utilities() {
  if [ "$AUTO_INSTALL" == "true" ] || (read -p "Do you want to install Other Utilities? (y/n): " install_utils && [ "$install_utils" == "y" ]); then
    echo "Installing Other Utilities"
    nala install -y zoxide ripgrep nodejs npm htop bashtop neofetch tldr autojump unzip make python3-pip gpaste tree ncal fzf tmux doxygen
    npm install -g tree-sitter tree-sitter-cli
  fi
}

install_nvim() {
    if [ "$AUTO_INSTALL" == "true" ] || (read -p "Do you want to install Neovim from apt 5may be an old versionm prefer from sources or softzare catalog perhaps) ? (y/n): " install_nv && [ "$install_nv" == "y" ]); then
    echo "Installing Neovim from apt"
    nala install -y neovim
  fi
}
#-------------------------#
# Main Script              #
#-------------------------#

install_brave_browser
install_beyond_compare
install_utilities
install_nvim

#-----------------------------------#
# Packages & Programs Configuration #
#-----------------------------------#

run_as_user "git config --global user.email \"florian.valenza@gmail.com\"";
run_as_user "git config --global user.name \"Florian Valenza\"";
run_as_user "git config --global credential.helper cache";
echo " Do not forget to run \"git config --global credential.helper store\" if you want to remember token after first usage. Warning: plain-text file used for storage. Better to use ssh. Caching enabled "
# https://stackoverflow.com/questions/35942754/how-can-i-save-username-and-password-in-git   or use cache  https://stackoverflow.com/a/51327559

run_as_user "tldr -u"; # update tldr database
