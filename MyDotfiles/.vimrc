" Enable syntax highlighting
syntax on

" Enable line numbers and relative numbers
set number
set relativenumber

" Smooth scrolling
set scrolloff=3

" Highlight current line
set cursorline

" Show matching brackets
set showmatch

" Enable true color (if your terminal supports it)
set termguicolors

" Install Plugins with Vim Plug
call plug#begin('~/.vim/plugged')

" Status bar plugin
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Dark color themes
Plug 'jnurmine/Zenburn'
Plug 'jacoborus/tender.vim'  " Twilight-like theme

call plug#end()

" Apply a dark theme (choose one)
colorscheme zenburn  " Zenburn
" colorscheme tender  " Twilight-like theme

" Set a darker background for Zenburn
highlight Normal ctermbg=NONE guibg=#111111

" Airline theme to match
let g:airline_theme='zenburn'
