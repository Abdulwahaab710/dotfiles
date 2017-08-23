function! HandleURL()
  let s:uri = matchstr(getline('.'), '[a-z]*:\/\/[^ >,;]*')
  echo s:uri
  if s:uri != ""
    silent exec "!open '".s:uri."'"
  else
    echo 'No URI found in line.'
  endif
endfunction
map <leader>u :call HandleURL()<cr>

function! s:DebugStatement()
  echom '1)Success'
  echom '2)Failure' 
  echom '3)Warning'
  let l:choice = input('>>')

  let l:debugMsg = ''
  if l:choice == 1
      let l:debugMsg = 'puts "\e[42m#{}\e[0m"'
  elseif l:choice == 2
      let l:debugMsg = 'puts "\e[41m#{}\e[0m"'
  elseif  l:choice == 3
      let l:debugMsg = 'puts "\e[43m#{}\e[0m"'
  endif
  if l:debugMsg != ''
      call append(line('.'), l:debugMsg)
  endif
endfunction
com! DebugStatement call s:DebugStatement()

" DiffWithSaved with allow you to see a diff between the currently edited file,
" and it's unmodified version
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" DiffWithGITCheckedOut will allow you to diff between the currently edited file,
" and git
function! s:DiffWithGITCheckedOut()
  let filetype=&ft
  diffthis
  vnew | exe "%!git diff " . expand("#:p:h") . "| patch -p 1 -Rs -o /dev/stdout"
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
  diffthis
endfunction
com! DiffGIT call s:DiffWithGITCheckedOut()

function! s:OpenPR()
  !dev open pr
endfunction
com! OpenPR call s:OpenPR()

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

