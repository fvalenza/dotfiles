set nocompatible
set number "Thirs turns on line numbering
set norelativenumber "This turns off relative numbering
 

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'croaker/mustang-vim'
Plug 'chriskempson/base16-vim'

Plug 'scrooloose/nerdtree'
" Add plugins to &runtimepath
call plug#end()

set t_Co=256 " Force vim to display 256 colors. See http://vim.wikia.com/wiki/256_colors_in_vim for something more robust ?
colorscheme mustang


set ruler "Show the current row and line at the bottom right of the screen
set laststatus=2

set hlsearch
set incsearch

set wildmenu

set colorcolumn=80,100

" Hides buffer instead of closing them when opening new files
set hidden
set history=100

filetype on
filetype plugin on
filetype indent on
" Turns on syntax highlighting
syntax on

" Don't update the display while executing a macro
set nolazyredraw

