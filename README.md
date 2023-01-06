# Dotfiles


## Ubuntu Post Installation

Before starting, reboot the PC.


After fresh install of Ubuntu, run the following to create root-filetree and download installation scripts / dotfiles

```sh
wget https://raw.githubusercontent.com/fvalenza/dotfiles/main/ubuntu-flw/post-installation-scripts/post-install.sh && chmod +x post-install.sh && sudo ./post-install.sh
```


Then install the needed components


## Components installation


```sh
cdpostinstall # or cd ~/root-filetree/devel/src/dotfiles/ubuntu-flw/post-installation-scripts
# foreach components:
sudo ./<component>.sh
```

Things to do / to note when installing each components: 

#### __Component 0__

At the end of component 0 installation, a reboot is automatically performed

#### __Component 1__

This component is mandatory for the others to work.

#### __Component 2__

After component 2 installation, start ulauncher from terminal and in the settingsm enable "Start at launch"
Nota: After component 2 installation, <ctrl>+space keybind will not work directly. Need to wait for gsettings component to be installed + system reboot

#### __Component 5__

After component 5 installation:
    - To finalize obsidian setup, open obsidian and select devel/notes with "open folder as vault"
    - To finalize sublime-text setup, start sublime, Install package control. The plugins shall be installed

#### __Component 9__

Before executing 9-gsettings.sh, install through extension manager the extension [extension sync](https://extensions.gnome.org/extension/1486/extensions-sync/) with following settings and download extensions:

```
# only sync extensions, Remove  keybinding or tweaks from settings
gist_id = 20ff5ba7a2fdd62bd1e295ef687c5a7b
token = ($secret) # To get from github
```

A shell reload is needed (log out and log in)

Then execute 9-gsettings.sh as user and NOT as root

```sh
./9-gsettings.sh
```
After component 9 installation, please reboot





Note : As stated [here](https://gist.github.com/magnetikonline/1e7e2dbd1b288fecf090f1ef12f0c80b) : if in Virtual box, do not forget to install addional guests as a first step  (-> VBoxLinuxAdditions.run + restart + unmount)

- Start VM, goto **Devices - Insert Guest Additions CD image** to mount the ISO image.
- From the terminal, run the following commands:

    ```sh
    $ sudo su
    $ apt install gcc make
    $ mkdir --parents /media/cdrom
    $ mount /dev/cdrom /media/cdrom
    $ /media/cdrom/VBoxLinuxAdditions.run
    $ reboot
    ```

- After reboot:

    ```sh
    $ modinfo vboxguest
    $ sudo usermod --append --groups vboxsf -- "$USER"
    $ cat /etc/group | grep "$USER"
    ```

- Host shares should now be mounted in Ubuntu guest under `/media` via the installed `VBoxService` service, set to start on system boot-up.
- All done.

**Note:** the above steps can be repeated on an existing VM image for guest addition upgrades, `VBoxLinuxAdditions.run` will handle the uninstall and reinstall process automatically.

