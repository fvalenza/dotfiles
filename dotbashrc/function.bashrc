#!/bin/bash

function hg() {
    history | grep "$1";
}

function find_largest_files() {
    du -h -x -s -- * | sort -r -h | head -20;
}
