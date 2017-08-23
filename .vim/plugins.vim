" =============================
" Plugins
" =============================
call plug#begin('~/.config/nvim/plugged')
Plug 'w0ng/vim-hybrid'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'Valloric/YouCompleteMe', {'do' : './install.py --clang-completer --gocode-completer', 'for' : ['c', 'cpp', 'haskell', 'javascript', 'java', 'html','twig','css','js','php', 'rb', 'ruby']}
Plug 'airblade/vim-gitgutter'
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
call plug#end()
