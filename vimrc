au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set textwidth=79
au BufNewFile,BufRead *.py set expandtab
au BufNewFile,BufRead *.py set autoindent
au BufNewFile,BufRead *.py set fileformat=unix

highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/

set number
filetype indent on
set encoding=utf-8

au BufNewFile,BufRead *.js, *.html, *.css set tabstop=2
au BufNewFile,BufRead *.js, *.html, *.css set softtabstop=2
au BufNewFile,BufRead *.js, *.html, *.css set shiftwidth=2

let python_highlight_all = 1
syntax on

filetype plugin on
set omnifunc=syntaxcomplete#Complete

set nocompatible              " be iMproved, required
filetype off                  " required

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
" Plugin 'file:///home/gmarik/path/to/plugin'
Plugin 'scrooloose/nerdtree'

" Indentation
Plugin 'vim-scripts/indentpython.vim'

" Auto-Complete
Bundle 'Valloric/YouCompleteMe'

" TMUX
Plugin 'christoomey/vim-tmux-navigator'

" Syntax Checking/Highlighting
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'

" Color Scheme
" Plugin 'jnurmine/Zenburn'
Plugin 'whatyouhide/vim-gotham'

" Status bar
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Docker
Plugin 'ekalinin/Dockerfile.vim'

" Fish
Plugin 'dag/vim-fish'

" Rust
Plugin 'rust-lang/rust.vim'

" Go
Plugin 'fatih/vim-go'

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_server_python_interpreter='/home/daniel/anaconda3/bin/python'
let g:ycm_python_interpreter_path='/home/daniel/anaconda3/bin/python'
let g:ycm_extra_conf_vim_data=['g:ycm_python_interpreter_path']
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Map W to :w and Q to :q
nnoremap W :w<CR>
nnoremap Q :q<CR>

colorscheme gotham256
