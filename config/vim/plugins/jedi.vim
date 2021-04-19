" JEDI-VIM
let g:jedi#popup_select_first = 0

" let g:jedi#completions_command = "<C-h>"
let g:jedi#usages_command = "<leader>z"

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
