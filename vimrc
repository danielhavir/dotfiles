let mapleader = ","


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

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
Plugin 'doum/darcula'

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
filetype plugin indent on    " required

highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/

au BufNewFile,BufRead *.js, *.html, *.css set tabstop=2
au BufNewFile,BufRead *.js, *.html, *.css set softtabstop=2
au BufNewFile,BufRead *.js, *.html, *.css set shiftwidth=2

"file-specific indentation settings
autocmd BufRead,BufNewFile *.py setlocal tabstop=4 shiftwidth=4 smarttab expandtab softtabstop=4 autoindent
autocmd BufRead,BufNewFile *.yaml setlocal tabstop=2 shiftwidth=2 smarttab expandtab softtabstop=2 autoindent
autocmd BufRead,BufNewFile *.json setlocal tabstop=2 shiftwidth=2 smarttab expandtab softtabstop=2 autoindent
autocmd BufRead,BufNewFile *.py set filetype=python
autocmd BufNewFile,BufRead *.py set fileformat=unix
autocmd BufRead,BufNewFile *.html setlocal tabstop=2 shiftwidth=2 smarttab expandtab softtabstop=2 autoindent
autocmd BufRead,BufNewFile *.go setlocal tabstop=4 shiftwidth=4 smarttab expandtab softtabstop=4 autoindent
autocmd BufRead,BufNewFile *.jsjs set filetype=scala

augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.markdown setlocal wrap
    autocmd BufEnter *.markdown setlocal linebreak
    autocmd BufEnter *.md setlocal wrap
    autocmd BufEnter *.md setlocal linebreak
    autocmd BufEnter *.md setlocal spell spelllang=en_us
    autocmd BufEnter *.c setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab cindent
augroup END


let python_highlight_all = 1
syntax on
set number
filetype indent on
filetype plugin indent on
set encoding=utf-8
set laststatus=2
filetype plugin on
set omnifunc=syntaxcomplete#Complete
set nocompatible
filetype off

" This tells Vim not to bother redrawing during these scenarios, leading to faster macros.
set lazyredraw

" show the last command entered
set showcmd

" Mapping for frequent fzf commands
nnoremap <silent> <leader>ag :Ag <C-R><C-W><CR>
nnoremap <silent> <leader>h :History<CR>
nnoremap <silent> <C-B> :Buffers<CR>

autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4
" ts - show existing tab with 4 spaces width
" sw - when indenting with '>', use 4 spaces width
" sts - control <tab> and <bs> keys to match tabstop

" Control all other files
set shiftwidth=4

" Allow backspace to delete indentation and inserted text
" i.e. how it works in most programs
set backspace=indent,eol,start

" NERDCommenter settings
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

iabbrev teh the
iabbrev adn and
iabbrev funciton function
iabbrev functoin function
iabbrev fucntion function

let g:ycm_show_diagnostics_ui = 1
let g:TerminusFocusReporting=0

"folding settings
set foldmethod=syntax
set foldlevelstart=10
set foldnestmax=10
set foldenable
set foldlevel=1

" For python
set foldmethod=indent
nnoremap <space> za
vnoremap <space> zf

"editing
set ruler                       " show the co-ordinates of the cursor
set cursorline                  " highlight the line with the cursor
set scrolloff=3                 " provide some context for editing
set number
" Toggle numbering by executing Ctrl-N twice
noremap <C-N><C-N> :set invnumber<CR>

"" Whitespace
set nowrap                      " dont wrap lines
set expandtab                   " spaces as tabs
set tabstop=4 shiftwidth=4      " a tab is two spaces (or set this to 4)
" set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " except when you tell vim
set gdefault                    " g flag is set on default

" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<cr>

"NERD Tree
let NERDTreeShowBookmarks  = 1
let NERDChristmasTree = 1
let NERDTreeWinPos = "left"
map <leader><leader>n :NERDTreeToggle <cr>
map <leader><leader>nf :NERDTreeFind <cr>

" BufExplorer mapping
nnoremap <leader>be :BufExplorer <cr>
nnoremap <leader>bs :BufExplorerHorizontalSplit <cr>
nnoremap <leader>bv :BufExplorerVerticalSplit <cr>

" highlight nbsp and trailing whitespace
" thanks to https://github.com/henrik/dotfiles
autocmd BufNewFile,BufRead * highlight nbsp ctermbg=Red
autocmd BufNewFile,BufRead * match nbsp "[\xc2\xa0]"
autocmd BufNewFile,BufRead * highlight trailing_spaces ctermbg=Red
autocmd BufNewFile,BufRead * match trailing_spaces /\s\+$/
" Remove trailing whitespace for all python files when saving
autocmd BufWritePre *.py %s/\s\+$//e

"leader mappings
nnoremap <tab> %
vnoremap <tab> %
map <Leader>w <C-w>w

"pressing Tab on the command line will show a menu to complete buffer and file names
set wildchar=<Tab> wildmenu wildmode=full

"press F10 to open the buffer menu.
set wildcharm=<C-Z>
nnoremap <F10> :b <C-Z>

""settings for ctrlp
"let g:ctrlp_cmd = 'CtrlPBuffer'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*/venv/*,
let g:clear_cache_on_exit = 0
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|_build'

" Settings for jedi-vim
let g:jedi#popup_select_first = 0

" let g:jedi#completions_command = "<C-h>"
let g:jedi#usages_command = "<leader>z"

let g:flake8_show_in_gutter=1  " show
autocmd FileType python map <buffer> <leader>f :call flake8#Flake8()<CR>

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
set omnifunc=jedi#completions
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

" Show syntax highlighting groups for word under cursor
nmap <C-S-T> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" JSON formatter
function! FormatJSON()
    :%!python -m json.tool
endfunction

" easier navigation between split windows
set splitbelow
set splitright

" vim focus
let g:diminactive_enable_focus = 0

" Plugin 'christoomey/vim-tmux-navigator'
" le g:tmux_navigator_disable_when_zoomed = 1
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" let g:ycm_autoclose_preview_window_after_completion=1
" let g:ycm_server_python_interpreter='/home/daniel/anaconda3/bin/python'
" let g:ycm_python_interpreter_path='/home/daniel/anaconda3/bin/python'
" let g:ycm_extra_conf_vim_data=['g:ycm_python_interpreter_path']
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" format with goimports instead of gofmt
let g:go_fmt_command = "goimports"

" Map W to :w
nnoremap W :w<CR>
" Q to :q
nnoremap Q :q<CR>
" <space> to -- VISUAL --
nnoremap <space> viw
" better use of H and L
nnoremap H ^
nnoremap L $

nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>j

colorscheme darcula
