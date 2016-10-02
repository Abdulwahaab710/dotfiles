syntax on

set nocompatible
" set ai "Auto indent
set background=dark
set backspace=2
set encoding=utf8
" set lazyredraw 
set list
set mouse=a
set nowrap
set number
set re=1
set relativenumber
" set ruler
set showcmd
" set showmatch
set hlsearch
" set si "Smart indent
" set smartcase
set splitbelow
set splitright
set t_Co=256

filetype plugin indent on
set tabstop=4 shiftwidth=4 softtabstop=4
set expandtab

set listchars=eol:$,tab:␉·,trail:␠,nbsp:⎵
" set wildmenu                    " make tab completion for files/buffers act
" set wildmode=list:full          " show a list when pressing tab and complete
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set laststatus=2
" syntax sync minlines=256

" set synmaxcol=300
" set nocursorcolumn
" set nocursorline
autocmd VimEnter * if !argc() | NERDTree | endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"indentline guide
let g:indentLine_faster = 1

"Airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='hybrid'

"phpcomplete
let g:phpcomplete_relax_static_constraint = 1
let g:phpcomplete_complete_for_unknown_classes = 1
let g:phpcomplete_search_tags_for_variables = 1
call plug#begin('~/.vim/plugged')

Plug 'Shougo/deoplete.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
" Plug 'benekastah/neomake' "Async Jobs (can use it instead of syntastic, but hard to setup)
Plug 'beyondwords/vim-twig'
" Plug 'christoomey/vim-run-interactive'
" Plug 'christoomey/vim-sort-motion'
" Plug 'christoomey/vim-tmux-navigator'
" Plug 'christoomey/vim-tmux-runner'
" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'duff/vim-scratch' "Open a throwaway scratch buffer
" Plug 'editorconfig/editorconfig-vim'
" Plug 'endel/vim-github-colorscheme'
" Plug 'jimmyhchan/dustjs.vim' "Highlighting for Dust
" Plug 'junegunn/vim-easy-align'
" Plug 'kien/ctrlp.vim'
" Plug 'lfilho/cosco.vim'
" Plug 'm2mdas/phpcomplete-extended'
" Plug 'majutsushi/tagbar'
" Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'
" Plug 'mmozuras/vim-github-comment'
" Plug 'Glench/Vim-Jinja2-Syntax'
" Plug 'pangloss/vim-javascript' | Plug 'mxw/vim-jsx'
" Plug 'shawncplus/phpcomplete.vim'
" Plug 'sjl/gundo.vim'
" Plug 'ternjs/tern_for_vim', {'do': 'npm install'}
" Plug 'terryma/vim-multiple-cursors'
" Plug 'thinca/vim-ref'
" Plug 'tpope/vim-commentary'
" Plug 'vim-scripts/ReplaceWithRegister'
Plug 'vim-scripts/matchit.zip' " % also matches HTML tags / words / etc
" Plug 'vim-scripts/taglist.vim'
" Plug 'vimwiki/vimwiki'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'SirVer/ultisnips' | Plug 'justinj/vim-react-snippets' | Plug 'colbycheeze/vim-snippets'
Plug 'Valloric/YouCompleteMe', {'do' : './install.py --clang-completer', 'for' : ['c', 'cpp', 'haskell', 'javascript', 'java', 'python','html','twig','css','js','php']}
Plug 'Yggdroot/indentLine'
Plug 'ap/vim-css-color', {'for': 'css'}
Plug 'docunext/closetag.vim'
Plug 'ervandew/supertab'
Plug 'gregsexton/matchtag'
Plug 'jiangmiao/auto-pairs' "MANY features, but mostly closes ([{' etc
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'mattn/emmet-vim'
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/syntastic' "Run linters and display errors etc
Plug 'suan/vim-instant-markdown', {'do': 'npm install -g instant-markdown-d', 'for': 'md'}
" Plug 'tpope/vim-fugitive' | Plug 'bling/vim-airline'
Plug 'tpope/vim-repeat' "allow plugins to utilize . command
Plug 'tpope/vim-surround' "easily surround things...just read docs for info
Plug 'vim-scripts/HTML-AutoCloseTag' "close tags after >
Plug 'vim-scripts/tComment' "Comment easily with gcc
Plug 'klen/python-mode'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'shawncplus/phpcomplete.vim'
call plug#end()
colorscheme hybrid_material
color hybrid_material
"Load config based on filetype
autocmd BufNewFile,BufRead *.cpp so ~/.vimrc_c++
" autocmd BufNewFile,BufRead *.java so ~/.vimrc_java
autocmd BufNewFile,BufRead *.py so ~/.vimrc_python
