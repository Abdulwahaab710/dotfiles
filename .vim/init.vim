set modelines=0        " CVE-2007-2438
filetype plugin indent on " load filetype-specific indent files
syntax enable " enable syntax processing
set nocompatible
set ai " Auto indent
set backspace=2
set encoding=utf8
set lazyredraw " redraw only when we need to.
set list
set mouse=a
if !has('nvim')
  set ttymouse=xterm2
endif
set nowrap
set number " show line numbers"
set re=1
set relativenumber
set ruler
set showcmd " show command in bottom bar
set showmatch " highlight matching [{()}]
set hlsearch " highlight matches
set incsearch " search as characters are entered
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set splitbelow
set splitright
set wildmenu " visual autocomplete for command menu
set wildmode=longest:full,full
set wildignore=*.o,*.class,*.pyc,*.git
set path+=**
set ttyfast
set tabstop=4 shiftwidth=4 " number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing
set expandtab " tabs are spaces"
set cursorline " highlight current line
set listchars=eol:$,tab:␉·,trail:␠,nbsp:⎵
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set laststatus=2
set ttimeoutlen=10

" =========================================
" Undo persistent
" =========================================
set   undofile
set   undodir=~/.vim/undofiles

" =========================================
" backup
" =========================================
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" =========================================
" TMUX
" =========================================
" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

if $TMUX == ''
    set clipboard+=unnamed
endif

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
map ;; $a;<esc>:w<CR>

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" ================
" Better grepping
" ================
nnoremap \ :Ag<SPACE>

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
" Makefile
" ===============
autocmd BufRead,BufNewFile *.c setlocal nmap <F5> :make run

" ==========
" latex
" ==========
let g:polyglot_disabled = ['latex']

" ===============
" Rails
" ===============
set omnifunc=rubycomplete#Complete
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global=1
let g:rubycomplete_rails = 1

"Load config based on filetype

function! HandleURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
  echo s:uri
  if s:uri != ""
    silent exec "!open '".s:uri."'"
  else
    echo "No URI found in line."
  endif
endfunction
map <leader>u :call HandleURL()<cr>

augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    " autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
    "             \:call <SID>striptrailingwhitespaces()<cr>
    " autocmd FileType java setlocal noexpandtab
    " autocmd FileType java setlocal list
    " autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    " autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:$
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    " autocmd FileType ruby match OverLength /\%>121v.\+/
    autocmd FileType ruby setlocal colorcolumn=120
    autocmd FileType eruby setlocal colorcolumn=120
    autocmd FileType eruby setlocal tabstop=2
    autocmd FileType eruby setlocal shiftwidth=2
    autocmd FileType eruby setlocal softtabstop=2
    autocmd FileType javascript setlocal tabstop=2
    autocmd FileType javascript setlocal shiftwidth=2
    autocmd FileType javascript setlocal softtabstop=2
    autocmd FileType go setlocal tabstop=4
    autocmd FileType go setlocal shiftwidth=4
    autocmd FileType go setlocal softtabstop=4
    autocmd FileType python setlocal colorcolumn=120

    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.ejson setlocal syntax=json
    autocmd FileType markdown setlocal spell
    autocmd BufEnter *.md setlocal spell

    autocmd FileType html setlocal spell
    autocmd BufEnter *.html setlocal spell

    autocmd BufEnter *.tex setlocal spell
    autocmd BufRead *.tex let g:tex_conceal = ""
augroup END

" let g:plug_url_format = 'https://git:@github.com:%s.git'

" let g:syntastic_ruby_checkers=['rubocop']
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger='<c-s>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-s>'

" =============================
" Plugins
" =============================
call plug#begin('~/.config/nvim/plugged')
Plug 'w0ng/vim-hybrid'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'Valloric/YouCompleteMe', {'do' : './install.py --clang-completer --gocode-completer', 'for' : ['c', 'cpp', 'haskell', 'javascript', 'java', 'html','twig','css','js','php', 'rb', 'ruby']}
" Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs' "MANY features, but mostly closes ([{' etc
Plug 'tpope/vim-surround' "easily surround things...just read docs for info
" Plug 'tomtom/tcomment_vim' "Comment easily with gcc
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-fugitive'
Plug 'rust-lang/rust.vim'
Plug 'SirVer/ultisnips'
" Currently, es6 version of snippets is available in es6 branch only
Plug 'letientai299/vim-react-snippets', { 'branch': 'es6' }
Plug 'honza/vim-snippets' "optional
Plug 'sheerun/vim-polyglot'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'mattn/emmet-vim'
Plug 'Yggdroot/indentLine'
Plug 'fatih/vim-go'
Plug 'wojtekmach/vim-rename'
Plug 'joshdick/onedark.vim'
Plug 'chriskempson/base16-vim'
Plug 'scrooloose/nerdtree'
" Plug '~/dev/vim/vim-rails/'
Plug 'w0rp/ale'
Plug 'tpope/vim-endwise'
Plug 'vim-scripts/SyntaxRange'
Plug 'mbbill/undotree'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'liuchengxu/space-vim-dark'
Plug 'bronson/vim-crosshairs'
Plug 'kopischke/vim-stay'
Plug 'lervag/vimtex'
Plug 'mbbill/undotree'
Plug 'xolox/vim-notes'
Plug 'vimwiki/vimwiki'
call plug#end()

" =========================================
" Colorscheme
" =========================================
let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " True gui colors in terminal
set background=dark
set t_Co=256
let g:impact_transbg=1
" colorscheme hybrid
" color base16-tomorrow-night
color hybrid
set termguicolors

" ==============================
" Plugins configs
" ==============================
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline_symbols.space = "\ua0"
let g:airline_powerline_fonts = 1
let g:airline_theme='hybrid'
" let g:airline_theme='base16_tomorrow'

set nocursorline    " enable the horizontal line
set nocursorcolumn  " enable the vertical line
" highlight CursorLine   cterm=NONE ctermbg=black ctermfg=NONE guibg=black guifg=NON 
" highlight CursorColumn cterm=NONE ctermbg=black ctermfg=NONE guibg=black guifg=NONE

" ============================
" Vim-stay
" ============================
set viewoptions=cursor,folds,slash,unix

" ============================
" NERDtree
" ============================
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTree like setup
let g:netrw_banner = 1
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 10
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit='vertical'

"YCM
let g:ycm_autoclose_preview_window_after_completion = 1
"autocomplete for ruby\rails config

let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \             're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }

function! s:DebugStatement()
    echom "1)Success"
    echom "2)Failure" 
    echom "3)Warning"
    let choice = input(">>")

    let debugMsg = ''
    if choice == 1
        let debugMsg = 'puts "\e[42m#{}\e[0m"'
    elseif choice == 2
        let debugMsg = 'puts "\e[41m#{}\e[0m"'
    elseif  choice == 3
        let debugMsg = 'puts "\e[43m#{}\e[0m"'
    endif
    if debugMsg != ''
        call append(line('.'), debugMsg)
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
  !/opt/dev/bin/dev open pr
endfunction
com! OpenPR call s:OpenPR()

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <C-Z> :ZoomToggle<cr>

function! GrepToWindow()
  let l:word = expand("<cword>")
  execute "silent grep! " . l:word
  redraw!
  cw
endfunc
command! -nargs=0 Gw call GrepToWindow()
nnoremap <leader>g :call GrepToWindow()<cr>

function! s:OpenInChrome()
    let l:url = expand('%:p')
    execute "! /usr/bin/open" . l:url
endfunction
command! OpenInChrome call s:OpenInChrome()

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


highlight MatchParen cterm=bold ctermbg=blue ctermfg=black     " Matching paren hightlight color change
highlight LineNr ctermfg=darkGrey                              " Lighter line numbers from OneDark theme
highlight CursorLineNr ctermfg=blue                            " Make current line number blue
highlight Comment cterm=italic                                 " enable italicised comments in vim
highlight CursorLine term=bold cterm=bold guibg=Grey40         " Light grey colour for cursorline
" highlight OverLength ctermbg=gray
" match OverLength /\%>121v.\+/
highlight ColorColumn ctermbg=red

command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
