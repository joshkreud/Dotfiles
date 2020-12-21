set nocompatible              " be iMproved, required
filetype off                  " required

" Highlighting
"highlight Normal ctermfg=grey ctermbg=black

" Indentation Options
set expandtab
filetype indent on
set autoindent
set shiftround
set shiftwidth=4
set smarttab
set tabstop=4

"Search Options
set hlsearch
set ignorecase
set incsearch
set smartcase

" Performance
set lazyredraw

"Text Rendering
set linebreak
set scrolloff=1
set sidescrolloff=5
syntax enable
set wrap

"UI Options
set laststatus=2
set ruler
set wildmenu
set tabpagemax=50
colorscheme slate
set cursorline
set number
set relativenumber
set noerrorbells
set visualbell
set mouse-=a
set title
set background=dark

"Code Folding
"set foldmethod=indent
"set foldnestmax=3

"Misc
set autoread
set history=1000
set wildignore+=.pyc,.swp


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}"
"
Plugin 'preservim/nerdcommenter'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"

Plugin 'stephpy/vim-yaml'

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line