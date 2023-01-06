#!/bin/bash

# https://askubuntu.com/questions/971067/how-can-i-script-the-settings-made-by-gnome-tweak-tool


# Check if Script is not Run as Root
if [[ $EUID -eq 0 ]]; then
  echo "You must NOT be a root user to run this script, please run ./9-gsettings.sh" 2>&1
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



#----------------------------#
# 2-app-launcher | ulauncher #
#----------------------------#

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'ulauncher-toggle'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'ulauncher-toggle'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Primary>space'


#--------------------------------------------#
# 3-desktop-customization | gnome-extensions #
#--------------------------------------------#

# aylur /  conky / another window session manager ?

## TOFIX
# gnome-extensions enable blur-my-shell@aunetx
# gnome-extensions enable forge@jmmaranan.com
# gnome-extensions enable horizontal-workspace-indicator@tty2.io
# gnome-extensions enable just-perfection-desktop@just-perfection
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable ubuntu-appindicators@ubuntu.com


gnome-extensions disable apps-menu@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable auto-move-windows@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable drive-menu@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable launch-new-instance@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable native-window-placement@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable places-menu@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable ding@rastersoft.com
gnome-extensions disable ubuntu-dock@ubuntu.com
gnome-extensions disable window-list@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable windowsNavigator@gnome-shell-extensions.gcampax.github.com
gnome-extensions disable workspace-indicator@gnome-shell-extensions.gcampax.github.com

#-----------------------------------------#
# 3-desktop-customization | gnome theming #
#-----------------------------------------#

# Setup 4 virtual workspaces
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 4

# Set fonts
gsettings set org.gnome.desktop.interface document-font-name 'Roboto 11'
gsettings set org.gnome.desktop.interface font-name 'Roboto 11'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Roboto Bold 11'

# Set Desktop Everforest theme
gsettings set org.gnome.desktop.interface gtk-theme everforest-gtk
gsettings set org.gnome.shell.extensions.user-theme name Forest

# Set Tela icons green
gsettings set org.gnome.desktop.interface icon-theme Tela-circle-green

# # Change mouse cursor ?
# gsettings set org.gnome.desktop.interface cursor-theme Nordic-cursors

# Set Wallpaper
gsettings set org.gnome.desktop.background picture-uri file://$rootftdir/images/artwork/wallpaper/wallhaven-l3v7ky_1920x1080.png



gsettings set org.gnome.nautilus.preferences  recursive-search 'never'
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button  true

## General keybind
#gsettings set org.gnome.mutter overlay-key '' # Can be a good idea to keep the overlay on Super_L to use it as an alt-tab persistent without holding alt key

