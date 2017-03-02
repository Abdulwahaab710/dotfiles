filetype plugin indent on " load filetype-specific indent files
syntax enable " enable syntax processing
set nocompatible
set ai " Auto indent
set background=dark
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
set t_Co=256
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
let mapleader=";"  "Leader Key
noremap <leader>w :w<CR>
noremap <leader>ml :!mac lock<CR>

map <up> <nop>            " disable arrow keys
map <down> <nop>          " disable arrow keys
map <left> <nop>          " disable arrow keys
map <right> <nop>         " disable arrow keys
imap <up> <nop>           " disable arrow keys
imap <down> <nop>         " disable arrow keys
imap <left> <nop>         " disable arrow keys
imap <right> <nop>        " disable arrow keys

map <C-c> "*y
" map <C-V> "*p
map <C-x> "*d

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

hi MatchParen cterm=bold ctermbg=blue ctermfg=black     "Matching paren hightlight color change
hi LineNr ctermfg=darkGrey                              "Lighter line numbers from OneDark theme
hi CursorLineNr ctermfg=blue                            "Make current line number blue
set cursorline                                          "Shows a visual cursor line
hi CursorLine term=bold cterm=bold guibg=Grey40         "Light grey colour for cursorline
"Load config based on filetype
autocmd BufNewFile,BufRead *.cpp so ~/.vimrc_c++
" autocmd BufNewFile,BufRead *.java so ~/.vimrc_java
autocmd BufNewFile,BufRead *.py so ~/.vimrc_python
autocmd BufNewFile,BufRead *.use so ~/.vimrc_use

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
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
                \:call <SID>StripTrailingWhitespaces()<cr>
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    " autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:$
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s

    autocmd FileType javascript setlocal tabstop=2
    autocmd FileType javascript setlocal shiftwidth=2
    autocmd FileType javascript setlocal softtabstop=2

    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END

let g:plug_url_format = 'https://git:@github.com/%s.git'

"YCM
let g:ycm_autoclose_preview_window_after_completion = 1
"autocomplete for ruby\rails config
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1
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

" =============================
" Plugins
" =============================
call plug#begin('~/.config/nvim/plugged')
Plug 'w0ng/vim-hybrid'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'Valloric/YouCompleteMe', {'do' : './install.py --clang-completer', 'for' : ['c', 'cpp', 'haskell', 'javascript', 'java', 'html','twig','css','js','php', 'rb', 'ruby']}
Plug 'airblade/vim-gitgutter'
Plug 'beyondwords/vim-twig', {'for': 'twig'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs' "MANY features, but mostly closes ([{' etc
Plug 'scrooloose/syntastic' "Run linters and display errors etc
Plug 'tpope/vim-surround' "easily surround things...just read docs for info
Plug 'tomtom/tcomment_vim' "Comment easily with gcc
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-fugitive'
Plug 'rust-lang/rust.vim'
Plug 'SirVer/ultisnips'
" Currently, es6 version of snippets is available in es6 branch only
Plug 'letientai299/vim-react-snippets', { 'branch': 'es6' }
Plug 'honza/vim-snippets' "optional
call plug#end()


" ==============================
" Plugins configs
" ==============================
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme='hybrid'

" Hybird
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
colorscheme hybrid
let g:airline_theme = 'hybridline'
