 see getting-started and managing your dotfiles at [awesome-dotfiles](https://github.com/webpro/awesome-dotfiles)

For sublime-text, one needs first to :
  - install package control via sublime-text's console
  - symlink packagecontrol.sublime-settings from Packages/Users ( to find it go to Preferences - Browse Packages)
  - Close and reopen sublime text. As packagecontrol.sublime-settings contains the list of packages, package controls will reinstall the packages
  - Then symlink Preference.sublime-settings
  - if you want, symlink the settings of al the packages, if you are not using the default ones. ( for the moment i've put them as i don't know if i have changed them or not)

Nota : some say to (symlink the whole directory Packages/User)[https://chrisarcand.com/sublime-text-settings-and-dotfiles/], some (only the two files)[https://opensourcehacker.com/2013/05/09/exporting-and-sharing-sublime-text-configuration/] PackageControl.sublime-settings and Preferences.sublime-settings. @TODO Check it out

