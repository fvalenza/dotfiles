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
assetsdir=$dotfilesdir/ubuntu-flw/assets
postinstallscriptsdir=$dotfilesdir/ubuntu-flw/post-installation-scripts

run_as_user() {
  sudo -u $username bash -c "$1";
}




#-----------------------------------------------#
# Desktop environment Configuration - DE config #
#-----------------------------------------------#

nala install -y gnome-tweaks gnome-shell-extension-manager gnome-shell-extensions

mkdir -p /home/$username/.local/share/gnome-shell/extensions
cp -r $dotfilesdir/ubuntu-flw/dotlocal/share/gnome-shell/extensions/* /home/$username/.local/share/gnome-shell/extensions
chown -R "$username:$username" "$userhome/.local"

gnome-extensions enable blur-my-shell@aunetx
gnome-extensions enable forge@jmmaranan.com
gnome-extensions enable horizontal-workspace-indicator@tty2.io
gnome-extensions enable just-perfection-desktop@just-perfection
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

# aylur /  conky / another window session manager ?
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 4

#------------------------------------------#
# Desktop environment Configuration - sddm #
#------------------------------------------#


#---------------------------------------------------#
# Desktop environment Configuration - Install fonts #
#---------------------------------------------------#


# Install fonts
nala install -y fonts-roboto
nala install fonts-font-awesome -y

# Set fonts
gsettings set org.gnome.desktop.interface document-font-name 'Roboto 11'
gsettings set org.gnome.desktop.interface font-name 'Roboto 11'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Roboto Bold 11'


#---------------------------------------------------#
# Desktop environment Configuration - Install theme #
#---------------------------------------------------#

mkdir -p /home/$username/.themes
cd /home/$username/.themes

# Get Everforest theme
git clone https://github.com/theory-of-everything/everforest-gtk ~/.themes/everforest-gtk
# unzip $assetsdir/themes/everforest-gtk.zip -d "/home/$username/.themes"

# Get Griffith-Femto shell theme
git clone https://github.com/Griffith-Femto/forest-dots ~/.themes/forest-dots
# unzip $assetsdir/themes/forest-dots.zip -d "/home/$username/.themes"


chown -R "$username:$username" "$userhome/.themes"

# Set Desktop Everforest theme
gsettings set org.gnome.desktop.interface gtk-theme everforest-gtk
gsettings set org.gnome.shell.extensions.user-theme name Forest


#---------------------------------------------------#
# Desktop environment Configuration - Install Icons #
#---------------------------------------------------#

# Get Tela Icons
run_as_user "mkdir -p $rootftdir/images/artwork/icons";
cd $rootftdir/images/artwork/icons
run_as_user "git clone https://github.com/vinceliuice/Tela-circle-icon-theme.git";
cd Tela-circle-icon-theme
run_as_user "/bin/bash ./install.sh \"green\"";

# Set Tela icons green
gsettings set org.gnome.desktop.interface icon-theme Tela-circle-green


#----------------------------------------------------#
# Desktop environment Configuration - Install Cursor #
#----------------------------------------------------#

# # Get Nordic cursor // to change ?
# run_as_user "mkdir -p /home/$username/.icons";
# tar -xvf $dotfilesdir/ubuntu-flw/assets/cursors/Nordic-cursors.tar.xz --directory $dotfilesdir/ubuntu-flw/assets/cursors
# run_as_user "cp -R $dotfilesdir/ubuntu-flw/assets/cursors/Nordic-cursors /home/$username/.icons";

# # Change mouse cursor ?
# gsettings set org.gnome.desktop.interface cursor-theme Nordic-cursors


#-------------------------------------------------------#
# Desktop environment Configuration - Install Wallpaper #
#-------------------------------------------------------#

# Get Wallpaper
# Find other Wallpapers for everforest rice at https://unsplash.com/fr/s/visuel/aa7ece37-3aaf-4a70-ab56-2c8421c94cfa
cp $dotfilesdir/ubuntu-flw/assets/images/wallhaven-l3v7ky_1920x1080.png $rootftdir/images/artwork/wallpaper
chown -R "$username:$username" "$rootftdir/images"
# Set Wallpaper
gsettings set org.gnome.desktop.background picture-uri file://$rootftdir/images/artwork/wallpaper/wallhaven-l3v7ky_1920x1080.png

