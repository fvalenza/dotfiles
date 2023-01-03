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



#------------------------------------------#
# Desktop environment Configuration - sddm #
#------------------------------------------#


#---------------------------------------------------#
# Desktop environment Configuration - Install fonts #
#---------------------------------------------------#


# Install fonts
nala install -y fonts-roboto
nala install fonts-font-awesome -y




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



#---------------------------------------------------#
# Desktop environment Configuration - Install Icons #
#---------------------------------------------------#

# Get Tela Icons
run_as_user "mkdir -p $rootftdir/images/artwork/icons";
cd $rootftdir/images/artwork/icons
run_as_user "git clone https://github.com/vinceliuice/Tela-circle-icon-theme.git";
cd Tela-circle-icon-theme
run_as_user "/bin/bash ./install.sh \"green\"";



#----------------------------------------------------#
# Desktop environment Configuration - Install Cursor #
#----------------------------------------------------#

# # Get Nordic cursor // to change ?
# run_as_user "mkdir -p /home/$username/.icons";
# tar -xvf $dotfilesdir/ubuntu-flw/assets/cursors/Nordic-cursors.tar.xz --directory $dotfilesdir/ubuntu-flw/assets/cursors
# run_as_user "cp -R $dotfilesdir/ubuntu-flw/assets/cursors/Nordic-cursors /home/$username/.icons";



#-------------------------------------------------------#
# Desktop environment Configuration - Install Wallpaper #
#-------------------------------------------------------#

# Get Wallpaper
# Find other Wallpapers for everforest rice at https://unsplash.com/fr/s/visuel/aa7ece37-3aaf-4a70-ab56-2c8421c94cfa
cp $dotfilesdir/ubuntu-flw/assets/images/wallhaven-l3v7ky_1920x1080.png $rootftdir/images/artwork/wallpaper
chown -R "$username:$username" "$rootftdir/images"


