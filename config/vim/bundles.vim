" BUNDLES
" set the runtime path to include vim-plug and initialize
call plug#begin('~/.vim/plugs')

" Autocomplete plugin
" Plug 'davidhalter/jedi-vim'
" COC for the win!
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Auto-Complete
" Plug 'Valloric/YouCompleteMe'

" Fzf vim with fzf.vim
" https://github.com/junegunn/fzf.vim
" https://github.com/junegunn/fzf/blob/master/README-VIM.md
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" git plugin
Plug 'tpope/vim-fugitive'

" Surround text with parentheses, brackets, quotes etc.
Plug 'tpope/vim-surround'

" Nerdtree
Plug 'preservim/nerdtree'

" NERDCommenter plugin
Plug 'preservim/nerdcommenter'

" Manage open buffers
Plug 'vim-scripts/bufexplorer.zip'

" Self-explanatory name
Plug 'amix/open_file_under_cursor.vim'

" Indentation
Plug 'vim-scripts/indentpython.vim'

" Folding
Plug 'tmhedberg/SimpylFold'

" TMUX
Plug 'christoomey/vim-tmux-navigator'

" Syntax Checking/Highlighting
Plug 'vim-syntastic/syntastic'

" PEP8
Plug 'nvie/vim-flake8'

" CTRLP Plugin - fuzzy search
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'wincent/command-t'

" Case-preserved substitute
" Plug 'tpope/vim-abolish.git'

" Status/tabline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Dim inactive windows
Plug 'blueyed/vim-diminactive'

" Now make it work with tmux
Plug 'tmux-plugins/vim-tmux-focus-events'

" Share vim and tmux clipboards
Plug 'roxma/vim-tmux-clipboard'

" Color Scheme
" Plug 'jnurmine/Zenburn'
" Plug 'whatyouhide/vim-gotham'
Plug 'doums/darcula'

" Docker
Plug 'ekalinin/Dockerfile.vim'

" Fish
Plug 'dag/vim-fish'

" Rust
Plug 'rust-lang/rust.vim'

" Go
Plug 'fatih/vim-go'

" All of your Plugins must be added before the following line
call plug#end()
