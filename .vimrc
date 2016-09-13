filetype off
filetype indent on

syntax on

set ai "Auto indent
set background=dark
set backspace=2
set encoding=utf8
set lazyredraw 
set list
set listchars=eol:$,tab:␉·,trail:␠,nbsp:⎵
set mouse=a
set nocompatible
set nowrap
set number
set re=1
set relativenumber
set ruler
set showcmd
set showmatch
set si "Smart indent
set smartcase
set splitbelow
set splitright
set t_Co=256
set ts=4 sw=4
set wildmenu                    " make tab completion for files/buffers act
set wildmode=list:full          " show a list when pressing tab and complete

autocmd vimenter * if !argc() | NERDTree | endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:indentLine_faster = 1

call plug#begin('~/.config/nvim/plugged')
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'SirVer/ultisnips' | Plug 'justinj/vim-react-snippets' | Plug 'colbycheeze/vim-snippets'
Plug 'Valloric/YouCompleteMe', {'do' : './install.py --clang-completer', 'for' : ['c', 'cpp', 'haskell', 'javascript', 'java', 'python','html','twig','css','js','php']}
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'ap/vim-css-color'
Plug 'benekastah/neomake' "Async Jobs (can use it instead of syntastic, but hard to setup)
Plug 'beyondwords/vim-twig'
Plug 'bling/vim-airline'
Plug 'christoomey/vim-run-interactive'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'docunext/closetag.vim'
Plug 'duff/vim-scratch' "Open a throwaway scratch buffer
Plug 'editorconfig/editorconfig-vim'
Plug 'endel/vim-github-colorscheme'
Plug 'ervandew/supertab'
Plug 'gregsexton/matchtag'
Plug 'Shougo/deoplete.nvim'
Plug 'christoomey/vim-tmux-runner'
Plug 'jiangmiao/auto-pairs' "MANY features, but mostly closes ([{' etc
Plug 'jimmyhchan/dustjs.vim' "Highlighting for Dust
Plug 'junegunn/vim-easy-align'
Plug 'kien/ctrlp.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'lfilho/cosco.vim'
Plug 'm2mdas/phpcomplete-extended'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'
Plug 'mmozuras/vim-github-comment'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'pangloss/vim-javascript' | Plug 'mxw/vim-jsx'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/syntastic' "Run linters and display errors etc
Plug 'shawncplus/phpcomplete.vim'
Plug 'sjl/gundo.vim'
Plug 'suan/vim-instant-markdown', {'do': 'npm install -g instant-markdown-d'}
Plug 'ternjs/tern_for_vim', {'do': 'npm install'}
Plug 'terryma/vim-multiple-cursors'
Plug 'thinca/vim-ref'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive' | Plug 'bling/vim-airline'
Plug 'tpope/vim-repeat' "allow plugins to utilize . command
Plug 'tpope/vim-surround' "easily surround things...just read docs for info
Plug 'vim-scripts/HTML-AutoCloseTag' "close tags after >
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'vim-scripts/matchit.zip' " % also matches HTML tags / words / etc
Plug 'vim-scripts/tComment' "Comment easily with gcc
Plug 'vim-scripts/taglist.vim'
Plug 'vimwiki/vimwiki'
call plug#end()
colorscheme hybrid_material

"Load config based on filetype
autocmd BufNewFile,BufRead *.cpp so ~/.vimrc_c++
autocmd BufNewFile,BufRead *.cpp so ~/.vimrc_java
autocmd BufNewFile,BufRead *.py so ~/.vimrc_python
