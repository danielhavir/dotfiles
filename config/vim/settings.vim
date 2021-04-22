" SETTINGS
" General
set nocompatible
filetype plugin indent on
syntax on

" Prevent delay
set ttimeout
set ttimeoutlen=3

" Line number
set number

" command height
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" TextEdit might fail if hidden is not set.
set hidden

" Editing
" highlight the line with the cursor
set cursorline
" show the co-ordinates of the cursor
set ruler
" the number of screen lines to keep above and below the cursor
set scrolloff=5

set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc,tmp,*.scssc,*.pyc,*.pickle,*.npy,*.zip,*.npy,*/venv/*
set wildmenu

set splitbelow
set splitright

" Other settings
set encoding=utf-8
set laststatus=2
" Omni completion provides smart autocompletion for programs
set omnifunc=syntaxcomplete#Complete
" don't redraw screen when executing macros or scripts
set lazyredraw
" show the last command entered
set showcmd
" Allow backspace to delete indentation and inserted text
" i.e. how it works in most programs
set backspace=indent,eol,start
set history=1000

set laststatus=2
set showmatch
set autoread
set binary
set secure
set dictionary=/usr/share/dict/words
set list
set autowrite

" Spellcheck
set spell
hi clear SpellBad
hi clear SpellCap
hi clear SpellRare
hi SpellBad cterm=underline

" Use ag instead of grep
set grepprg=ag\ --nogroup\ --nocolor

" Use sh for vim-tmux-navigator for fast switch out
set shell=/bin/sh

" Invisible character
set listchars=tab:»·,trail:·,nbsp:·

if has('persistent_undo')
    " undo files
    set undodir=~/.vim/tmp/undo/
    set undofile
    set undolevels=3000
    set undoreload=10000
endif

" backups
set backupdir=~/.vim/tmp/backup/
" swap files
set directory=~/.vim/tmp/swap/
set backup
set noswapfile

" Tab spaces
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

"folding settings
set foldmethod=syntax
set foldlevelstart=10
set foldnestmax=10
set foldenable
set foldlevel=1

"" Whitespace
set nowrap

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
" Replace all occurrences by default
set gdefault

" vim focus
let g:diminactive_enable_focus = 0
let g:TerminusFocusReporting=0
let python_highlight_all = 1

