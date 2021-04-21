" COC
let g:coc_disable_startup_warning = 1

" see more at
" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions
let g:coc_global_extensions = [
            \'coc-json',
            \'coc-git',
            \'coc-python',
            \'coc-pyright',
            \'coc-clangd',
            \'coc-cmake',
            \'coc-go',
            \'coc-sql',
            \'coc-yaml',
            \]


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')


" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" GoTo code navigation.
nmap <leader>d <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
