#!/bin/bash

function hg() {
    history | grep "$1";
}

function find_largest_files() {
    du -h -x -s -- * | sort -r -h | head -20;
}


# From computer local dir to my dotfiles dir
function sync_up_sublime_text() {
    echo "Uploading to dotfiles dir local sublime configuration"
    #TODO
}

# From my dotfiles dir  to computer local dir
function sync_down_sublime_text() {
    echo "Downloading from dotfiles dir to local sublime configuration"
    #TODO
}
