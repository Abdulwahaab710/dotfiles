vim.g.mapleader = ";"

vim.cmd([[
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
]])

require('settings')
require('autocmd')
require('remap')
require('colors')
require('folding')
