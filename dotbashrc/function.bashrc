#!/bin/bash

function hg() {
    history | grep "$1";
}

function find_largest_files() {
    du -h -x -s -- * | sort -r -h | head -20;
}


vv() {
  while true; do
    echo "Select configuration:"
    select config in lazyvim kickstart nvchad astrovim lunarvim; do
      case $config in
        lazyvim | kickstart | nvchad | astrovim | lunarvim )
          NVIM_APPNAME=nvim-$config nvim
          break 2
          ;;
        "" | " " )
          # Default behavior when user enters nothing or just spaces
          NVIM_APPNAME=default-nvim nvim
          break 2
          ;;
        * )
          echo "Invalid option. Please choose a valid configuration."
          ;;
      esac
    done
  done
}


# vv() {
#   select config in lazyvim kickstart nvchad astrovim lunarvim
#   do NVIM_APPNAME=nvim-$config nvim; break; done
# }


# Custom `select` implementation with support for a default choice
# that the user can make by pressing just ENTER.
# Pass the choices as individual arguments; e.g. `selectWithDefault Yes No``
# The first choice is the default choice, unless you designate
# one of the choices as the default with a leading '!', e.g.
# `selectWithDefault Yes !No`
# The default choice is printed with a trailing ' [default]'
# Output is the 1-based *index* of the selected choice, as shown
# in the UI.
# Example:
#    choice=$(selectWithDefault 'Yes|No|!Abort' )
selectWithDefault() {

  local item i=0 numItems=$# defaultIndex=0

  # Print numbered menu items, based on the arguments passed.
  for item; do         # Short for: for item in "$@"; do
    [[ "$item" == !* ]] && defaultIndex=$(( $i + 1)) && item="${item:1} [default]"
    printf '%s\n' "$((++i))) $item"
  done >&2 # Print to stderr, as `select` does.

  # Prompt the user for the index of the desired item.
  while :; do
    printf %s "${PS3-#? }" >&2 # Print the prompt string to stderr, as `select` does.
    read -r index
    # Make sure that the input is either empty or that a valid index was entered.
    [[ -z $index ]] && index=$defaultIndex && break  # empty input == default choice
    (( index >= 1 && index <= numItems )) 2>/dev/null || { echo "Invalid selection. Please try again." >&2; continue; }
    break
  done

  # Output the selected *index* (1-based).
  printf $index

}

nv(){
    echo "Select nvim configuration:"
    ndx=$(selectWithDefault 'EditorOnly' '!Coding' 'Note Taking' 'Testing' 'Bare Neovim')

    case $ndx in
        1) NVIM_APPNAME=nvim-editor nvim;; # Only editing capabilities
        2) NVIM_APPNAME=nvim-code nvim;; # Coding capabilities
        3) NVIM_APPNAME=nvim-notes nvim;; # Note-taking capabilities
        4) NVIM_APPNAME=nvim-test nvim;; # To test a plugin or conf
        5) nvim;; # Bare Neovim

    esac
}
