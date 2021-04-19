" AUTOCMD
highlight BadWhitespace ctermbg=red guibg=red
autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
autocmd BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" thanks to https://github.com/henrik/dotfiles
autocmd BufRead,BufNewFile * highlight nbsp ctermbg=Red
autocmd BufRead,BufNewFile * match nbsp "[\xc2\xa0]"
autocmd BufRead,BufNewFile * highlight trailing_spaces ctermbg=Red
autocmd BufRead,BufNewFile * match trailing_spaces /\s\+$/
" Remove trailing whitespace for all python files when saving
autocmd BufWritePre * %s/\s\+$//e

"file-specific indentation settings
autocmd BufRead,BufNewFile *.py setlocal tabstop=4 shiftwidth=4 smarttab expandtab softtabstop=4 autoindent
autocmd BufRead,BufNewFile *.py setlocal filetype=python fileformat=unix
autocmd BufRead,BufNewFile *.yaml setlocal tabstop=2 shiftwidth=2 smarttab expandtab softtabstop=2 autoindent
autocmd BufRead,BufNewFile *.json setlocal tabstop=2 shiftwidth=2 smarttab expandtab softtabstop=2 autoindent
autocmd BufRead,BufNewFile *.html setlocal smarttab expandtab autoindent
autocmd BufRead,BufNewFile *.js, *.html, *.css set tabstop=2 softtabstop=2 shiftwidth=2
autocmd BufRead,BufNewFile *.go setlocal tabstop=4 shiftwidth=4 smarttab expandtab softtabstop=4 autoindent
autocmd BufRead,BufNewFile *.jsjs set filetype=scala
autocmd BufRead,BufNewFile *.cu set filetype=cpp

augroup group1
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType java setlocal listchars=tab:+\ ,eol:- formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufEnter *.markdown setlocal wrap linebreak
    autocmd BufEnter *.md setlocal wrap linebreak spell spelllang=en_us
    autocmd BufEnter *.c setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab cindent
augroup END

