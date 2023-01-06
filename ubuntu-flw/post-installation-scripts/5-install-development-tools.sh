#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

run_as_user() {
  sudo -u $username bash -c "$1";
}


#-------------------#
# Preparatory setup #
#-------------------#

username=$(id -u -n 1000)
userhome=/home/$username
rootftdir=$userhome/root-filetree
develdir=$rootftdir/devel
dotfilesdir=$develdir/src/dotfiles
postinstallscriptsdir=$dotfilesdir/ubuntu-flw/post-installation-scripts


#-----------------------#
# Install xxx #
#-----------------------#

nala install -y build-essential cmake vim neovim rust-all texlive-latex-extra


# Sublime text 4 + sublime merge
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# Obsidian Markdown Editor
wget -O obsidian.deb https://github.com/obsidianmd/obsidian-releases/releases/download/v1.0.3/obsidian_1.0.3_amd64.deb

nala update
nala install -y sublime-text sublime-merge
nala install -y ./obsidian.deb
rm ./obsidian.deb


#----------------------------#
# Sublime-text configuration #
#----------------------------#

rm -rf $userhome/.config/sublime-text/Packages/User

mkdir -p $userhome/.config/sublime-text/Packages/User

cp -R $dotfilesdir/ubuntu-flw/dotconfig/sublime-text/Packages/User/. $userhome/.config/sublime-text/Packages/User

chown -R "$username:$username" "$userhome/.config/sublime-text"

run_as_user "cargo install rustfmt";

#------------------------#
# Obsidian configuration #
#------------------------#

mkdir -p $develdir/notes/.obsidian
cp -R $dotfilesdir/ubuntu-flw/dotobsidian/. $develdir/notes/.obsidian

chown -R "$username:$username" "$develdir/notes/.obsidian"
