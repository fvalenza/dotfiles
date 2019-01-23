Install customized bashrc files
---
I wanted it to be the less intrusive as possible as I may install it on computer with & without root access, at work or at home.  
Just run the `./install_sh` in the root of this directory and all the sourcing should be done.

```bash
cd */devel/dir*
git clone https://github.com/fvalenza/dotfiles
cd dotfiles
vim .bashrc.d/env.bashrc # modify DEVEL_DIR variable
./install_sh
```


Sublime text package syncing
---

. Install [package-control](https://packagecontrol.io/installation)  
. Put in `Packages/User` folder (to find it go to Preferences - Browse Packages), the files from this repo.  
. To go further, symlink this repository in Packages/User to ease git commit/related stuff

Predaw color modification
---

- linehighlitght have been changed from #232323 to #353535
- comment have been changed from #777777 to #a0a0a0

these changes can be found in Packages/predawn-flo.tmTheme

In sublime text:

    ctrl-shift-p
    open resource
    predawn.tmTheme

Doc
---
These are some of the links i read to achieve this repo. Great source of inspiration, thanks to all the contributors:

. [awesome-dotfiles](https://github.com/webpro/awesome-dotfiles)
. [sublime text package control tuto](https://packagecontrol.io/docs/syncing)
. [sublime text package syncing from chris arcand](https://chrisarcand.com/sublime-text-settings-and-dotfiles/)
. [other sublime text package syncing](https://opensourcehacker.com/2013/05/09/exporting-and-sharing-sublime-text-configuration/)

