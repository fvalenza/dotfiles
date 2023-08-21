#!/bin/bash


#=============#
#     Git     #
#=============#

alias g=’git’
alias gs='git status' # View Git status.
alias ga='git add' # Add a file to Git.
alias gaa='git add --all' # Add all files to Git.
alias gcom='git commit -m' # Commit changes to the code.
alias gl='git log --oneline' # View the Git log.
alias gb='git checkout -b' # Create a new Git branch and move to the new branch at the same time.
alias gd='git diff' # View the difference.
alias gclone='git clone'
alias gstash='git stash'


#==============#
#   filetree   #
#==============#
alias home='cd ~'
alias root='cd /'
alias desktop='cd ~/Desktop'
alias dotbashrc='cd ~/dotbashrc'
alias rootf='cd $MY_ROOT_FILETREE'
alias audio='cd $MY_ROOT_FILETREE/audio'
alias devel='cd $DEVEL_DIR'
alias src='cd $MY_ROOT_FILETREE/devel/src'
alias install='cd $MY_ROOT_FILETREE/devel/install'
alias documents='cd $MY_ROOT_FILETREE/documents'
alias images='cd $MY_ROOT_FILETREE/images'
alias litterature='cd $MY_ROOT_FILETREE/litterature'
alias videos='cd $MY_ROOT_FILETREE/videos'
alias work='cd $MY_ROOT_FILETREE/work'
alias ..='cd ..;'
alias .2='cd ../..;'
alias .3='cd ../../..;'
alias .4='cd ../../../..;'
alias cdd='cd $DEVEL_DIR' # to remove if i get confortqble with 'devel'



# Common project directories ## TODO
# alias projectscpp='cd ~/Dropbox/Projects/C++Projects'
# alias projectsc='cd ~/Dropbox/Projects/CProjects'
# alias projectspython='cd ~/Dropbox/Projects/PythonProjects'
# alias projectsgo='cd ~/Dropbox/Projects/GoProjects'
# alias projectsrust='cd ~/Dropbox/Projects/RustProjects'

#=======================#
#   utility shortcuts   #
#=======================#

alias c='clear'
alias e='subl'
alias h='history'
alias o=xdg-open # on Ubuntu only
alias q=’exit’
alias bashrc='source ~/.bashrc'
alias mkdir='mkdir -p -v' # Make a directory and all parent directories with verbosity.
# alias tree='tree --dirsfirst -F' # Display the directory structure better.
alias v=vim
alias nv=nvim

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias top='bashtop'

#=================#
#     Calendar    #
#=================#
alias jan='cal -m 01'
alias feb='cal -m 02'
alias mar='cal -m 03'
alias apr='cal -m 04'
alias may='cal -m 05'
alias jun='cal -m 06'
alias jul='cal -m 07'
alias aug='cal -m 08'
alias sep='cal -m 09'
alias oct='cal -m 10'
alias nov='cal -m 11'
alias dec='cal -m 12'
