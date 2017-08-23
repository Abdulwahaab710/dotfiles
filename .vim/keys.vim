" =========================================
" Keyboard config
" =========================================
let g:mapleader=';'  "Leader Key
noremap <leader>w :w<CR>
noremap <leader>ml :!mac lock<CR>

map <up> <nop>            " disable arrow keys
map <down> <nop>          " disable arrow keys
map <left> <nop>          " disable arrow keys
map <right> <nop>         " disable arrow keys
imap <up> <esc>:!say 'You are lazy'<CR>           " disable arrow keys
imap <down> <esc>:!say 'You are lazy'<CR>         " disable arrow keys
imap <left> <esc>:!say 'You are lazy'<CR>         " disable arrow keys
imap <right> <esc>:!say 'You are lazy'<CR>        " disable arrow keys

nmap <F2> :NERDTreeToggle<CR>
imap <F2> <esc>:NERDTreeToggle<CR>

" <C-\> - Open the definition in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR> " Open the definition in a new tab
map ‘ :vsp <CR>:exec("tag ".expand("<cword>"))<CR> " Open the definition in a vertical split

" Mapping jj to <esc>
imap jj <esc>

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" ===========
" resizing
" ===========
nnoremap <C-w>> 20<C-w>>
nnoremap <C-w>< 20<C-w><
nnoremap <C-w>+ 20<C-w>+
nnoremap <C-w>- 20<C-w>

" ===========
" Git
" ===========
nnoremap <C-g>c :Gcommit<CR>
nnoremap <C-g>p :Gpull<CR>
nnoremap <C-g>P :Gpush<CR>

" ===========
" Tagbar
" ===========
nmap <F8> :TagbarToggle<CR>

" ===============
" Silver Searcher
" ===============
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" ===============
" UltiSnips
" ===============
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger='<c-s>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-s>'


