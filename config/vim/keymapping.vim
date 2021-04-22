" KEY MAPPING
let mapleader = ","

" Map W to :w
nnoremap W :w<CR>
" Q to :q
nnoremap Q :q<CR>
" ! to :q!
nnoremap ! :q!<CR>
" <space> to -- VISUAL --
nnoremap <space>v viw
" remap original H and L
noremap <space>h H
noremap <space>l L
noremap <space>m M
" better use of H and L
noremap H ^
nnoremap L $
vnoremap L $<left>
nnoremap cl c$

" delete without putting to buffer
vnoremap d "_d

" replace word under cursor in normal mode
nnoremap <leader>r :%s/<C-r><C-w>//c<left><left>
nnoremap <leader><leader>r :%s/\<<C-r><C-w>\>//c<left><left>
" replace selected text in visual mode
vnoremap <C-r> "hy:%s/<C-r>h//c<left><left>
vnoremap <leader>r "hy:%s/<C-r>h//c<left<left>
vnoremap <leader><leader>r "hy:%s/\<<C-r>h\>//c<left><left>

" visual box
nnoremap <leader>v <C-v>
" similar to tmux
nnoremap <C-v> <C-w>v<C-w>l
nnoremap <C-s> <C-w>s<C-w>j

" Mapping for frequent fzf commands
nnoremap <silent> <leader>ag :Ag <C-R><C-W><CR>
nnoremap <silent> <leader>h :History<CR>
" nnoremap <silent> <C-B> :Buffers<CR>

" Typos
iabbrev teh the
iabbrev adn and
iabbrev funciton function
iabbrev functoin function
iabbrev fucntion function

" Toggle numbering by executing Ctrl-N twice
noremap <C-N><C-N> :set invnumber<CR>

" clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<CR>

"NERD Tree
map <space><space> :NERDTreeToggle <CR>
map <space><space>f :NERDTreeFind <CR>

" BufExplorer mapping
nnoremap <leader><leader>be :BufExplorer <CR>
nnoremap <leader><leader>bs :BufExplorerHorizontalSplit <CR>
nnoremap <leader><leader>bv :BufExplorerVerticalSplit <CR>

"leader mappings
nnoremap <tab> %
vnoremap <tab> %
map <leader>w <C-w>w

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

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<CR>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<CR>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<CR>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<CR>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif

autocmd FileType python map <buffer> <leader><leader>f :call flake8#Flake8()<CR>

" JSON formatter
function! Jsonify()
    :%!python -m json.tool
endfunction

autocmd BufRead,BufNewFile *.json map <buffer> <leader><leader>f :call Jsonify()<CR>
