Installation Procedure from Scratch
=======

1. Install curl
2. Install [vim-plug](https://github.com/junegunn/vim-plug)
3. Download dotfiles and create symlink to .vimrc
 ```bash
cd ~
git clone https://github.com/fvalenza/dotfiles
cd dotfiles
chmod +x install.sh
./install.sh
```
4. Run vim even if doesn't know `call#plug` command
5. Type `:PlugInstall`
