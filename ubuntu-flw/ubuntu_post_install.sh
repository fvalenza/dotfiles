#!/bin/bash


########################################################################################################################
#  Preparatory setup
########################################################################################################################

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


########################################################################################################################
#  Utility functions
########################################################################################################################

run_as_user() {
  sudo -u $username bash -c "$1";
}

print_char_n_times ()
{
  str=$1
  num=$2
  printf "%0.s$1" $(seq 1 $num)
  echo
}

log_step ()
{
  local input=$*
  nbchar=${#input}
  print_char_n_times "#" $(($nbchar+4))
  echo "# $* #"
  print_char_n_times "#" $(($nbchar+4))
}


log_install_step ()
{
  log_step $* | tee $logfile
}

########################################################################################################################
# Root-filetree creation
########################################################################################################################

# TODO. + set DEVEL_DIR, cdd alias, INSTALL_DIR
cd $userhome
run_as_user "mkdir -p root-filetree";
cd root-filetree
run_as_user "mkdir -p archives audio devel documents Games images litterature softwares videos";
cd audio
run_as_user "mkdir -p music podcast";
cd ../devel
run_as_user "mkdir -p book external-src install notes src";
cd ../images
run_as_user "mkdir -p artwork charts photos screenshots";
cd artwork
run_as_user "mkdir -p wallpaper";
cd ../../litterature
run_as_user "mkdir -p book partitions user-manuals";

########################################################################################################################
# Beginning of Installation
########################################################################################################################

mkdir -p $tmpinstalldir && cd $tmpinstalldir

#----------------------------------------#
# Update packages list and update system #
#----------------------------------------#
apt update
apt upgrade -y

#-------------------------------------------------------------------------#
# Install utilities to facilitate installation ( they are useful anyway ) #
#-------------------------------------------------------------------------#
log_install_step "Install wget curl  and nala "

apt install -y wget apt-transport-https curl
wget -qO- https://deb.volian.org/volian/scar.key | gpg --dearmor | dd of=/usr/share/keyrings/volian-archive-scar.gpg  # (sudo wget... if manual)
echo "deb [signed-by=/usr/share/keyrings/volian-archive-scar.gpg arch=amd64] https://deb.volian.org/volian/ scar main" > /etc/apt/sources.list.d/volian-archive-scar.list
apt update
apt install -y nala


#----------------------#
# Remove snap "bloats" #
#----------------------#
log_install_step "Remove firefox and thunderbird"

snap remove firefox
apt purge -y thunderbird*
apt purge -y gnome-games gnome-{mahjongg,mines,sudoku}
apt autoremove -y

#-----------------------------------------------#
# Install packages that requires EULA agreement #
#-----------------------------------------------#
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
apt-get install -y  ttf-mscorefonts-installer


#-----------------------------------------#
# Install packages from ubuntu repository #
#-----------------------------------------#
log_install_step "Nala Install of: utilities (CLI) / media / tools / dev tools / desktop environment"

# Install utiliies CLI
nala install -y terminator htop bashtop neofetch tldr autojump
# and utilities media
nala install -y ubuntu-restricted-extras vlc pulseaudio pavucontrol
# and tools
nala install -y keepassxc gpaint gthumb
# and gaming
nala install -y steam
# and developer tools
nala install -y build-essential cmake git neovim rust-all texlive-latex-extra
# and desktop environment
nala install -y gnome-tweaks gnome-shell-extension-manager gnome-shell-extensions
  # gnome-themes-extra


#---------------#
# Extra Install #
#---------------#
log_install_step " Extra Installs "

# Sublime text 4 + sublime merge
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# Obsidian Markdown Editor
wget -O obsidian.deb https://github.com/obsidianmd/obsidian-releases/releases/download/v1.0.3/obsidian_1.0.3_amd64.deb

# Brave browser
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# Discord
wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"

# lutris ?

# qwerty-fr keyboard layout
wget -O qwerty-fr.deb https://github.com/qwerty-fr/qwerty-fr/releases/download/v0.7.2/qwerty-fr_0.7.2_linux.deb

nala update
nala install -y sublime-text sublime-merge brave-browser
nala install -y ./obsidian.deb
nala install -y ./discord.deb
nala install -y ./qwerty-fr.deb

# # Install itch.io
# Aller dans ~/Download
# wget -O itch-setup "https://itch.io/app/download?platform=linux"
# chmod +x itch-setup && ./itch-setup # attention sudo ou pas...

#------------------------------#
# Get the dotfiles from github #
#------------------------------#
cd $develdir/src

run_as_user "git clone --recursive https://github.com/fvalenza/dotfiles";

#-----------------------------------#
# Desktop environment Configuration #
#-----------------------------------#

cd $dotfilesdir
source $dotfilesdir/ubuntu-flw/gnome-config-nordic.sh


#-----------------------------------#
# Packages & Programs Configuration #
#-----------------------------------#

# TODO. put it in qnother script ?
git config --global user.email "florian.valenza@gmail.com"
git config --global user.name "Florian Valenza"
# git config --global credential.helper store
echo " Do not forget to run \"git config --global credential.helper store\" to setup Token "

run_as_user "tldr -u"; # updqte tldr database


#----------------------#
# Clean before leaving #
#----------------------#
rm -rf $tmpinstalldir



