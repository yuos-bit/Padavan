" Enable line numbers
set number

" Enable syntax highlighting (required for basic syntax support)
syntax enable

" Enable auto-indentation
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" Set default encoding to UTF-8
set encoding=utf-8
set fileencodings=utf-8,latin1

" Set terminal type for compatibility
set term=linux

" Set background to dark for better contrast
set background=dark

" Prevent swap files from being created
set noswapfile

" Disable line wrapping for simplicity
set nowrap

" Enable search highlighting
set hlsearch

" Basic clipboard support (adjust as needed, may be disabled in your setup)
set clipboard=unnamedplus

" Check for a vimrc and source it if available
if filereadable(expand("~/.vimrc"))
    source ~/.vimrc
endif

" Set default terminal for ncurses
set terminfo=/usr/share/terminfo

" End of defaults.vim
