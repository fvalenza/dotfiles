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


add-apt-repository -y ppa:agornostal/ulauncher
nala update
nala install -y ulauncher


# Install dependencies for my extension list

# For clipboard extension
nala install -y  gpaste

# For github extension
pip install pygithub~=1.55.0 requests
pip3 install github --user

# For translate-shell
cd $develdir/external-src
git clone https://github.com/soimort/translate-shell
cd translate-shell
make
make install
# wget git.io/trans -P $userhome/root-filetree/devel/install/bin
# chmod +x $userhome/root-filetree/devel/install/bin/trans
# chown -R "$username:$username" "$userhome/root-filetree/devel/install/bin/"


# copy configuration files
cp -R $dotfilesdir/ubuntu-flw/dotconfig/ulauncher $userhome/.config

# Run Ulauncher on startup
systemctl --user enable --now ulauncher

# Fix hotkey issue in wayland  https://github.com/Ulauncher/Ulauncher/wiki/Hotkey-In-Wayland
nala install -y wmctrl
# ulauncher hotkey in ulauncher settings is already set to something i don't use in the settings.json
# Add keybind in settings.. (not the ulauncher ones)


chown -R "$username:$username" "$userhome/.config/ulauncher"

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'ulauncher-toggle'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'ulauncher-toggle'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Primary>space'

