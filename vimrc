"========"
" VUNDLE "
"========"
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" my plugins 
Plugin 'kien/ctrlp.vim' " fuzzy file search
Plugin 'bling/vim-airline' " nice status bar
Plugin 'vim-airline/vim-airline-themes' " status bar themes
Plugin 'klen/python-mode' " python autocompletion and linter
Plugin 'brendonrapp/smyck-vim' " color scheme

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"=================="
" GENERAL SETTINGS "
"=================="
syntax on
set so=10 " show 10 lines of context above and below current line

set smartindent
set softtabstop=4
set shiftwidth=4
set expandtab

set showcmd
set number

set bs=start,eol,indent
set virtualedit=block

if version >= 730
	set relativenumber
endif

"==================="
" STATUS LINE SETUP "
"==================="
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

"=========="
" COMMANDS "
"=========="
" save current file with admin rights
cmap w!! w !sudo tee > /dev/null % 

"========"
" COLORS "
"========"
set t_Co=256
colorscheme smyck

"==============="
" AIRLINE SETUP "
"==============="
let g:airline_powerline_fonts = 1
