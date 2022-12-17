#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
# builddir=$(pwd)
userhome=/home/$username
rootftdir=$userhome/root-filetree
develdir=$rootftdir/devel
dotfilesdir=$develdir/src/dotfiles
tmpinstalldir=$userhome/tmp/ubuntu-install
logfile=$tmpinstalldir/post-install.log

run_as_user() {
  sudo -u $username bash -c "$1";
}



# Install fonts
nala install -y fonts-roboto

# Get Nord theme
run_as_user "mkdir -p /home/$username/.themes";
cd /home/$username/.themes

wget https://github.com/EliverLara/Nordic/releases/download/v2.2.0/Nordic-bluish-accent-standard-buttons-v40.tar.xz
tar -xvf Nordic-bluish-accent-standard-buttons-v40.tar.xz
# rm -rf Nordic-bluish-accent-standard-buttons-v40.tar.xz

# Get Tela Icons
# TODO: Mv Icons from repo to /home/$username/.icons

run_as_user "mkdir -p /home/$username/root-filetree/images/artwork/icons";
cd $rootftdir/images/artwork/icons
run_as_user "git clone https://github.com/vinceliuice/Tela-circle-icon-theme.git";
cd Tela-circle-icon-theme
run_as_user "/bin/bash ./install.sh \"orange\"";

# Get Nordic cursor
run_as_user "mkdir -p /home/$username/.icons";
tar -xvf $dotfilesdir/ubuntu-flw/assets/cursors/Nordic-cursors.tar.xz --directory $dotfilesdir/ubuntu-flw/assets/cursors
run_as_user "cp -R $dotfilesdir/ubuntu-flw/assets/cursors/Nordic-cursors /home/$username/.icons";

# Get Wallpaper Cyber city
run_as_user "cp $dotfilesdir/ubuntu-flw/assets/images/aciwnsk876t91.jpg $rootftdir/images/artwork/wallpaper";



# Set fonts
gsettings set org.gnome.desktop.interface document-font-name 'Roboto 11'
gsettings set org.gnome.desktop.interface font-name 'Roboto 11'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Roboto Bold 11'


# Set Desktop Nord theme
gsettings set org.gnome.desktop.interface gtk-theme Nordic-bluish-accent-standard-buttons-v40
gsettings set org.gnome.desktop.wm.preferences theme Nordic-bluish-accent-standard-buttons-v40


# Set Tela icons
gsettings set org.gnome.desktop.interface icon-theme Tela-circle-orange

# Change mouse cursor ?
# TODO: Mv Cursor from repo to /home/$username/.icons
gsettings set org.gnome.desktop.interface cursor-theme Nordic-cursors


# Set Wallpaper
gsettings set org.gnome.desktop.background picture-uri file://$rootftdir/images/artwork/wallpaper/aciwnsk876t91.jpg

