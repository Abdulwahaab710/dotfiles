
"  █████╗ ██████╗ ██████╗ ██╗   ██╗██╗     ██╗    ██╗ █████╗ ██╗  ██╗ █████╗  █████╗ ██████╗ ███████╗    ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
" ██╔══██╗██╔══██╗██╔══██╗██║   ██║██║     ██║    ██║██╔══██╗██║  ██║██╔══██╗██╔══██╗██╔══██╗██╔════╝    ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
" ███████║██████╔╝██║  ██║██║   ██║██║     ██║ █╗ ██║███████║███████║███████║███████║██████╔╝███████╗    ██║   ██║██║██╔████╔██║██████╔╝██║
" ██╔══██║██╔══██╗██║  ██║██║   ██║██║     ██║███╗██║██╔══██║██╔══██║██╔══██║██╔══██║██╔══██╗╚════██║    ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
" ██║  ██║██████╔╝██████╔╝╚██████╔╝███████╗╚███╔███╔╝██║  ██║██║  ██║██║  ██║██║  ██║██████╔╝███████║     ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
" ╚═╝  ╚═╝╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝ ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝      ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝

" System Settings  ----------------------------------------------------------{{{

filetype plugin indent on " load filetype-specific indent files
syntax enable " enable syntax processing

set ai " Auto indent
set backspace=2
set cursorline " highlight current line
set encoding=utf8
set expandtab " tabs are spaces"
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set hlsearch " highlight matches
set incsearch " search as characters are entered
set laststatus=2
set lazyredraw " redraw only when we need to.
set list
set listchars=eol:$,tab:␉·,trail:␠,nbsp:⎵
set modelines=0        " CVE-2007-2438
set mouse=a
set nocompatible
set nowrap
set number " show line numbers"
set path+=**
set re=1
set relativenumber
set ruler
set showcmd " show command in bottom bar
set showmatch " highlight matching [{()}]
set softtabstop=2 " number of spaces in tab when editing
set splitbelow
set splitright
set statusline+=%#warningmsg#
set statusline+=%*
set tabstop=2 shiftwidth=2 " number of visual spaces per TAB
set ttimeoutlen=10
set ttyfast
if !has('nvim')
  set ttymouse=xterm2
endif
set wildignore=*.o,*.class,*.pyc,*.git
set wildmenu " visual autocomplete for command menu
set wildmode=longest:full,full
set viewoptions=cursor,slash,unix

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

" }}}}

" Keyboard config  ----------------------------------------------------------{{{{
" =========================================
" Keyboard config
" =========================================
let g:mapleader=';'  "Leader Key
noremap <leader>w :w<CR>
noremap <leader>ml :!mac lock<CR>
noremap <leader>t :TestNearest<CR>
noremap <leader>T :TestFile<CR>
map <leader>vt :Vterm<CR>
map <leader>st :Sterm<CR>

" disabling arrow keys
map <up>     <nop>
map <down>   <nop>
map <left>   <nop>
map <right>  <nop>
imap <up>    <nop>
imap <down>  <nop>
imap <left>  <nop>
imap <right> <nop>

nmap <F2> :NERDTreeToggle<CR>
imap <F2> <esc>:NERDTreeToggle<CR>

" <C-\> - Open the definition in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR> " Open the definition in a new tab
map ‘ :vsp <CR>:exec("tag ".expand("<cword>"))<CR> " Open the definition in a vertical split

" Mapping jj to <esc>
imap jj <esc>
tnoremap jj <C-\><C-n>

" ================
" Better grepping
" ================
nnoremap \ :FzfAg<CR>
nnoremap <C-p> :FZF<CR>

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
nnoremap K :FzfAg <C-R><C-W><CR>

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" }}}}

" autocmd ---------------------------------------------------------------{{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
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
    autocmd FileType ruby setlocal foldmethod=syntax
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

autocmd BufRead,BufNewFile *.c setlocal nmap <F5> :make run
" }}}

" Plugins ---------------------------------------------------------------{{{

call plug#begin('~/.config/nvim/plugged')

" Code Completion and snippets --------------------{{{

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'uplus/deoplete-solargraph'
Plug 'fishbullet/deoplete-ruby'
Plug 'zchee/deoplete-jedi'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets' "optional

" }}}


" git plugins -------------------------------------{{{

Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'
" Plug 'tpope/vim-fugitive'

" }}}

" Theme related plugins ---------------------------{{{

Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'chriskempson/base16-vim'
Plug 'Yggdroot/indentLine'

" }}}

" tpope plugins -----------------------------------{{{

Plug 'tpope/vim-surround' "easily surround things...just read docs for info
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-dadbod'

" }}}

" misc --------------------------------------------{{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'mattn/emmet-vim'
Plug 'wojtekmach/vim-rename'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'kopischke/vim-stay'
Plug 'mbbill/undotree'
Plug 'janko-m/vim-test'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs' "MANY features, but mostly closes ([{' etc
" }}}

" Syntax plugins ----------------------------------{{{

Plug 'vim-ruby/vim-ruby'
Plug 'rust-lang/rust.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'chrisbra/csv.vim'
Plug 'yaunj/vim-yara'
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go'
Plug 'suan/vim-instant-markdown'

" }}}

call plug#end()
" }}}

" Fold, gets it's own section  ----------------------------------------------{{{

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}

set foldtext=MyFoldText()

autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

autocmd FileType vim setlocal fdc=1
set foldlevel=99
" Space to toggle folds.
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType vim setlocal foldlevel=0

" au FileType html nnoremap <buffer> <leader>F zfat
let ruby_fold = 1
set foldlevelstart=1

" }}}

" Colorscheme -----------------------------------------------------------{{{

if (has("termguicolors"))
  set termguicolors
endif
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " True gui colors in terminal
set background=dark
set t_Co=256
let g:impact_transbg=1
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
au VimLeave * set guicursor=a:block-blinkon0

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

highlight MatchParen cterm=bold ctermbg=blue ctermfg=black     " Matching paren hightlight color change
highlight LineNr ctermfg=darkGrey                              " Lighter line numbers from OneDark theme
highlight CursorLineNr ctermfg=blue                            " Make current line number blue
highlight Comment cterm=italic                                 " enable italicised comments in vim
" highlight CursorLine term=bold cterm=bold guibg=Grey40         " Light grey colour for cursorline
highlight OverLength ctermbg=gray
match OverLength /\%>121v.\+/
highlight ColorColumn ctermbg=red

" }}}

" Plugins configs -------------------------------------------------------{{{

let g:fzf_command_prefix = 'Fzf'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline_symbols.space = "\ua0"
let g:airline_powerline_fonts = 1
" let g:airline_theme='base16_tomorrow'
let g:airline_theme='luna'

let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'file':    'dispatch',
  \ 'suite':   'basic',
  \}

let g:ale_fixers = {'ruby': 'rubocop'}
let g:ale_fix_on_save = 1
let g:ale_ruby_rubocop_executable = 'bin/rubocop'


" let g:plug_url_format = 'https://git:@github.com:%s.git'

let g:UltiSnipsExpandTrigger='<c-s>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-s>'


let g:session_autosave = 'no'

let g:deoplete#enable_at_startup = 1

let g:deoplete#keyword_patterns = {}
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" NERDTree ----------------------------------------{{{

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"}}}

" ============================
" NERDtree
" ============================

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

" Custom Functions ----------------------------------------------------------{{{

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

function! s:Jsonify()
    execute "%! python -m json.tool"
endfunction
command! Jsonify call s:Jsonify()

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

 function! s:ChangeClassName(from_name, to_name, args)
   " rg --files-with-matches 'from' . | xargs sed -i '' 's/from/to/g'
   let rg = "!rg --files-with-matches . " . from_name
   let xargs = "xargs sed -i '' 's/" . from_name . "/" . to_name . "/g'"
   execute rg . " | " . xargs
 endfunction

command! Sorc source ~/.config/nvim/init.vim
command! Vterm vsp | term
command! Sterm sp | term

" }}}}
