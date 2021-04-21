function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

call SourceIfExists('~/.config/vim/bundles.vim')

source ~/.config/vim/autocmd.vim
source ~/.config/vim/settings.vim

" Plugin specific settings
call SourceIfExists('~/.config/vim/plugins/ctrlp.vim')
call SourceIfExists('~/.config/vim/plugins/flake.vim')
call SourceIfExists('~/.config/vim/plugins/jedi.vim')
call SourceIfExists('~/.config/vim/plugins/nerdcomment.vim')
call SourceIfExists('~/.config/vim/plugins/nerdtree.vim')
call SourceIfExists('~/.config/vim/plugins/vim-go.vim')

source ~/.config/vim/keymapping.vim
source ~/.config/vim/color.vim

" Local config
call SourceIfExists('~/.vimrc.local')

