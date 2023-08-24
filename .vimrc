set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" UltiSnips for completion / templating
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. 
Plugin 'ervandew/supertab'

let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'

" All the plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" something messes up this setting in the plugins
set expandtab

set encoding=utf-8
set number relativenumber
noremap <silent> <F2> <Cmd>setlocal number! relativenumber! <CR>

set noswapfile

syntax on " Syntax highlighting
set ruler " Always shows location in file (line#)

set mouse=r

nmap <C-s> :w<CR>
nmap <C-q> :q!<CR>

let mapleader = " "
nmap <leader>d <C-d>
nmap <leader>u <C-u>
vmap <leader>d <C-d>
vmap <leader>u <C-u>

" move lines with Ctrl + (Shift) +J/K
nnoremap <C-j> :m +1<CR>
nnoremap <C-k> :m -2<CR>
inoremap <C-j> <Esc>:m +1<CR>gi
inoremap <C-k> <Esc>:m -2<CR>gi
vnoremap <C-j> :m '>+1<CR>gvgv
vnoremap <C-k> :m '<-2<CR>gvgv
