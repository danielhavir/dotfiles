" CTRLP
let g:clear_cache_on_exit = 0

" When starting up, CtrlP sets its local working directory according to this
" variable: >
"   let g:ctrlp_working_path_mode = 'ra'
" <
"   c - the directory of the current file.
"   a - the directory of the current file, unless it is a subdirectory of the cwd
"   r - the nearest ancestor of the current file that contains one of these
"       directories or files:
"       .git .hg .svn .bzr _darcs
"   w - modifier to "r": start search from the cwd instead of the current file's
"       directory
"   0 or <empty> - disable this feature.
" Note #1: if "a" or "c" is included with "r", use the behavior of "a" or "c" (as
" a fallback) when a root can't be found.
" Note #2: you can use a |b:var| to set this option on a per buffer basis.
let g:ctrlp_working_path_mode = 'ra'

" Use per-session caching
let g:ctrlp_use_caching = 1

" Prevent CtrlP from taking all the window
let g:ctrlp_max_height = 30

" Max number of files and tree depth
let g:ctrlp_max_files = 50000
" let g:ctrlp_max_depth = 80
let g:ctrlp_root_markers = ['.ctrlp']

" CtrlP ignore list
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](build|tmp|scratch|CMakeFiles)|(\.(build|git|hg|svn|cmake|tmp|rviz))$',
  \ 'file': '\v\.(cxx|exe|so|a|dll|txt|bag|mov|png|jpg|avi|cmake|make|tmp|zip|swp|orig)$',
  \ }

