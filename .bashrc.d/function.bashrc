#!/bin/bash

## useful functions that are toobig for aliases and do not worth full scripts
## highly inspried by mathisasbynens dotfiles

# Create a new directory and enter it
function mk() {
  mkdir -p "$@" && cd "$@"
}

# Open man page as PDF
function manpdf() {
 man -t "${1}" | open -f -a /Applications/Preview.app/
}

# Extra many types of compressed packages
# Credit: http://nparikh.org/notes/zshrc.txt
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)  tar -jxvf "$1"                        ;;
      *.tar.gz)   tar -zxvf "$1"                        ;;
      *.bz2)      bunzip2 "$1"                          ;;
      *.dmg)      hdiutil mount "$1"                    ;;
      *.gz)       gunzip "$1"                           ;;
      *.tar)      tar -xvf "$1"                         ;;
      *.tbz2)     tar -jxvf "$1"                        ;;
      *.tgz)      tar -zxvf "$1"                        ;;
      *.zip)      unzip "$1"                            ;;
      *.ZIP)      unzip "$1"                            ;;
      *.pax)      cat "$1" | pax -r                     ;;
      *.pax.Z)    uncompress "$1" --stdout | pax -r     ;;
      *.Z)        uncompress "$1"                       ;;
      *) echo "'$1' cannot be extracted/mounted via extract()" ;;
    esac
  else
     echo "'$1' is not a valid file to extract"
  fi
}

# `s` with no arguments opens the current directory in Sublime Text, otherwise
# opens the given location
function s() {
	if [ $# -eq 0 ]; then
		subl .;
	else
		subl "$@";
	fi;
}

# `sn` with no arguments opens the current directory in Sublime Text in a new windows, otherwise
# opens the given location
function sn() {
	if [ $# -eq 0 ]; then
		subl -n .;
	else
		subl -n "$@";
	fi;
}

function istoolchainsourced() {
	if [[ -v NM ]]; then
		echo "TRUE";
	else
		echo "FALSE";
	fi;
}

function sync_project_to_windows() {
	result=${PWD##*/}
	from_linux=$PROJ_DIR_LINUX/$result/
	to_windows=$PROJ_DIR_WINDOWS/$result
	echo $from_linux
	echo $to_windows
	if [ ! -d "$to_windows" ]; then
  		echo "${to_windows} does not exist. Abort rsync"
	else
		rsync -avu --delete "${from_linux}" "${to_windows}"
		echo "rsync to windows finished"
	fi
}
alias syncwindowsfromlinux=sync_project_to_windows


function sync_project_to_linux() {
	result=${PWD##*/}
	from_windows=$PROJ_DIR_WINDOWS/$result/
	to_linux=$PROJ_DIR_LINUX/$result
	echo $from_windows
	echo $to_linux
	if [ ! -d "$from_windows" ]; then
  		echo "${from_windows} does not exist. Abort rsync"
	else
		rsync -avu --delete "${from_windows}" "${to_linux}"
		echo "rsync to linux finished"
	fi
}
alias synclinuxfromwindows=sync_project_to_linux
