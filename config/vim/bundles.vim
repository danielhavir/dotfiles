" BUNDLES
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Autocomplete plugin
Plugin 'davidhalter/jedi-vim'

" Auto-Complete
" Plugin 'Valloric/YouCompleteMe'

" Fzf vim with fzf.vim
" https://github.com/junegunn/fzf.vim
" https://github.com/junegunn/fzf/blob/master/README-VIM.md
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'

" git plugin
Plugin 'tpope/vim-fugitive'

" Nerdtree
Plugin 'preservim/nerdtree'

" NERDCommenter plugin
Plugin 'preservim/nerdcommenter'

" Manage open buffers
Plugin 'vim-scripts/bufexplorer.zip'

" Self-explanatory name
Plugin 'amix/open_file_under_cursor.vim'

" Indentation
Plugin 'vim-scripts/indentpython.vim'

" TMUX
Plugin 'christoomey/vim-tmux-navigator'

" Syntax Checking/Highlighting
Plugin 'vim-syntastic/syntastic'

" PEP8
Plugin 'nvie/vim-flake8'

" CTRLP Plugin - fuzzy search
Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'wincent/command-t'

" Case-preserved substitute
Plugin 'tpope/vim-abolish.git'

" Status/tabline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Dim inactive windows
Plugin 'blueyed/vim-diminactive'

" Now make it work with tmux
Plugin 'tmux-plugins/vim-tmux-focus-events'

" Share vim and tmux clipboards
Plugin 'roxma/vim-tmux-clipboard'

" Color Scheme
" Plugin 'jnurmine/Zenburn'
" Plugin 'whatyouhide/vim-gotham'
Plugin 'doums/darcula'

" Docker
Plugin 'ekalinin/Dockerfile.vim'

" Fish
Plugin 'dag/vim-fish'

" Rust
Plugin 'rust-lang/rust.vim'

" Go
Plugin 'fatih/vim-go'

" All of your Plugins must be added before the following line
call vundle#end()            " required
