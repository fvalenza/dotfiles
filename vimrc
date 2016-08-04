set number "Thirs turns on line numbering
set norelativenumber "This turns on relative numbering
set hlsearch 

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'chriskempson/base16-vim'
" Add plugins to &runtimepath
call plug#end()

colorscheme base16-default-dark
