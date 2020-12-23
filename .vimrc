so ~/.vim/plugins.vim

set nocompatible              " be iMproved, required

autocmd BufRead,BufNewFile *.fish set ft=fish
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile Podfile,*.podspec,Vagrantfile set filetype=ruby
autocmd FileType gitcommit setlocal spell

" Automatically create parent dirs when writing a file
autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')

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
" colorscheme slate
colorscheme gruvbox
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
