# dotfiles


## Ubuntu Post Installation

After fresh install of Ubuntu, run the following to create root-filetree and download installation scripts

```sh
wget https://raw.githubusercontent.com/fvalenza/dotfiles/main/ubuntu-flw/post-installation-scripts/post-install.sh && chmod +x post-install.sh && sudo ./post-install.sh
```

Then install the needed components

```sh
cd ~/root-filetree/src/dotfiles/ubuntu-flw/post-installation-scripts
./complete-install.sh
# or sudo ./<component>.sh etc until number 8
```

Nota: Try to create the script complete-install.sh with [this](https://stackoverflow.com/a/20414532)

Before executing 9-gsettings.sh, install through extension manager the extension [extension sync](https://extensions.gnome.org/extension/1486/extensions-sync/) with following settings and download extensions:

```
gist_id = 20ff5ba7a2fdd62bd1e295ef687c5a7b
token = ($secret) # To get from github
```

Then execute gsettings as user and NOT as root

```sh
./9-gsettings.sh
```
