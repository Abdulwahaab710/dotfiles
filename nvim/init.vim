" System Settings  ----------------------------------------------------------{{{
filetype plugin on
filetype plugin indent on                   " load filetype-specific indent files

set ai                                      " Auto indent
set backspace=2
set cursorline                              " highlight current line
set encoding=utf8
set expandtab                               " tabs are spaces"
set foldenable                              " enable folding
set foldlevelstart=10                       " open most folds by default
set foldnestmax=10                          " 10 nested fold max
set hlsearch                                " highlight matches
set incsearch                               " search as characters are entered
set laststatus=2
set lazyredraw                              " redraw only when we need to.
set list
set listchars=eol:$,tab:␉·,trail:␠,nbsp:⎵   " show $ in the end of line
set modelines=0                             " CVE-2007-2438
set mouse=a
set nocompatible
set nowrap
set number                                  " show line numbers"
set path+=**                                " let find search in sub folders
set re=1
set relativenumber
set ruler
set showcmd                                 " show command in bottom bar
set showmatch                               " highlight matching [{()}]
set softtabstop=2                           " number of spaces in tab when editing
set splitbelow                              " open horizontal splits to the botton
set splitright                              " open vertical splits to the right
set tabstop=2 shiftwidth=2                  " number of visual spaces per TAB
set ttimeoutlen=10
set timeoutlen=10
set ttyfast
if !has('nvim')
  set ttymouse=xterm2
endif
set wildignore=*.o,*.class,*.pyc,*.git
set wildmenu                                " visual autocomplete for command menu
if has('wildoptions') && has('pumblend')
  set wildoptions=pum
  set pumblend=20
else
  set wildmode=longest:full,full
endif
set dictionary='/usr/share/dict/words'      " Set the path to the dictionary
set viewoptions=cursor,slash,unix
set shell=$SHELL                            " Change vim's shell to use $SHELL

let g:python3_host_prog = '/Users/abdulwahaabahmed/.pyenv/versions/neovim3/bin/python'

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

" }}}

" Command -------------------------------------------------------------------{{{
command! Q q " Bind :Q to :q
command! Qall qall
command! QA qall
command! E e
command! W w
command! Wq wq
command! X x
command! MakeTags
\ Dispatch !ctags --extra=+f --exclude=.git --exclude=log -R *
command! Config tabedit ~/.config/nvim/init.vim
command! Todo tabedit ~/todo.txt
" }}}

" Keyboard config  ----------------------------------------------------------{{{

let g:mapleader=';'  " Leader Key

noremap <leader>t :TestNearest<CR>
noremap <leader>T :TestFile<CR>

map <leader>vt :Vterm<CR>
map <leader>st :Sterm<CR>

noremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>ot :tabe
nnoremap <leader>os :sp
nnoremap <leader>ov :vsp
" nnoremap <leader>n :nohl<CR>

nmap <leader>gb :GBrowse<CR>
vmap <leader>gb :GBrowse<CR>

nmap <leader>gB :GBlame<CR>

nmap k gk
nmap j gj

" disabling arrow keys
map <up>     <nop>
map <down>   <nop>
map <left>   <nop>
map <right>  <nop>
imap <up>    <nop>
imap <down>  <nop>
imap <left>  <nop>
imap <right> <nop>
nnoremap Q  <nop>

" Open the definition in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" Open the definition in a vertical split Option+Shift+]
nmap ‘ :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Mapping jj to <esc>
" imap jj <esc>
" tnoremap jj <C-\><C-n>

" ================
" Better grepping
" ================
nnoremap \ :FzfRg<CR>
" nnoremap <silent> <C-p> :call Fzf_dev()<CR>
nnoremap <silent> <leader>p :FZF<CR>

nnoremap <silent> <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
" nnoremap \ <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

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
nmap <F8> :Vista!!<CR>
imap <F8> <esc>:Vista!!<CR>i

" ===============
" Silver Searcher
" ===============
" bind K to grep word under cursor
nnoremap <leader>k :FzfRg <C-R><C-W><CR>

nnoremap <Space> za

" autocmd FileType magit nmap gp :!git push<CR>
autocmd FileType go nmap <leader>gr :GoRun %<CR>

nmap s cl
nmap S cc
vmap s c
vmap S c

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit! " save file when you get E45: 'readonly' option is set (add ! to override)

" Copy current file path to the unamed register
nmap cp :let @" = expand("%")<cr>

iabbrev <buffer> shrug; ¯\_(ツ)_/¯

nmap <leader>bn :bnext<CR>
nmap <leader>bp :bprevious<CR>
nmap <leader>bf :FzfBuffers<CR>

nmap <leader>tt :FloatermToggle<CR>
" -- lsp provider to find the cursor word definition and reference
nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>

" -- code action
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>

" -- Show hover doc
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>

" -- scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" -- scroll up hover doc
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
" -- show signature help
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>

 " click enter on [[my_link]] or [[[my_link]]] to enter it
" nnoremap <buffer> <CR> <cmd>lua require'neuron'.enter_link()<CR>

" " create a new note
" nnoremap <buffer> gzn <cmd>lua require'neuron/cmd'.new_edit(require'neuron/config'.neuron_dir)<CR>

" " find your notes, click enter to create the note if there are not notes that match
" nnoremap <buffer> gzz <cmd>lua require'neuron/telescope'.find_zettels()<CR>
" " insert the id of the note that is found
" nnoremap <buffer> gzZ <cmd>lua require'neuron/telescope'.find_zettels {insert = true}<CR>

" " find the backlinks of the current note all the note that link this note
" nnoremap <buffer> gzb <cmd>lua require'neuron/telescope'.find_backlinks()<CR>
" " same as above but insert the found id
" nnoremap <buffer> gzB <cmd>lua require'neuron/telescope'.find_backlinks {insert = true}<CR>

" " find all tags and insert
" nnoremap <buffer> gzt <cmd>lua require'neuron/telescope'.find_tags()<CR>

" " start the neuron server and render markdown, auto reload on save
" nnoremap <buffer> gzs <cmd>lua require'neuron'.rib {address = "127.0.0.1:8200", verbose = true}<CR>

" " go to next [[my_link]] or [[[my_link]]]
" nnoremap <buffer> gz] <cmd>lua require'neuron'.goto_next_extmark()<CR>
" " go to previous
" nnoremap <buffer> gz[ <cmd>lua require'neuron'.goto_prev_extmark()<CR>]]

" }}}

" autocmd -------------------------------------------------------------------{{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    " autocmd FileType php setlocal expandtab
    " autocmd FileType php setlocal list
    " autocmd FileType php setlocal listchars=tab:+\ ,eol:$
    " autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    " autocmd FileType ruby match OverLength /\%>121v.\+/
    autocmd FileType ruby setlocal colorcolumn=120
    autocmd FileType ruby setlocal foldmethod=syntax
    autocmd FileType ruby
          \ iabbrev <buffer> rw; attr_accessor|
          \ iabbrev <buffer> rr; attr_reader|
          \ iabbrev <buffer> ww; attr_writer|
          \ iabbrev <buffer> hmd; has_many :<++>, dependent: :destroy|
          \ iabbrev <buffer> validp; validates :<++>, presence: true
    autocmd FileType ruby,eruby setlocal spell
    autocmd FileType eruby
          \ iabbrev <buffer> link_to; <%= link_to 'text', 'path' %>
          \ iabbrev <buffer> if; <%= if some_condition %>
          \ <CR>do something here
          \ <CR><% end %>
    autocmd FileType javascript,html
          \ iabbrev <buffer> domloaded; document.addEventListener('DOMContentLoaded', () => {
          \ <CR><CR> })
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
    autocmd FileType vimwiki setlocal spell
    autocmd FileType vimwiki setlocal wrap
    autocmd BufNewFile,BufRead *.todo.txt setlocal filetype=todo
    autocmd BufNewFile,BufRead *.todo.txt setlocal spell
    autocmd BufNewFile,BufRead *.todo.txt setlocal wrap
    autocmd BufNewFile ~/vimwiki/HackeroneReportInvestigations/*.wiki :silent 0r !chruby 2.7.1 && ~/.config/nvim/bin/generate-report-investigation '%'
    autocmd BufNewFile ~/vimwiki/diary/*.wiki :silent 0r !~/.config/nvim/bin/generate-diary-template '%'
    autocmd BufNewFile,BufRead ~/vimwiki/diary/diary.wiki :VimwikiDiaryGenerateLinks
  augroup end

" autocmd BufRead,BufNewFile *.c setlocal nmap <F5> :make run
au BufWritePost <buffer> lua require('lint').try_lint()

" }}}

" omnifuncs -----------------------------------------------------------------{{{

augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
augroup end

set omnifunc=syntaxcomplete#Complete
" }}}

" Fold ----------------------------------------------------------------------{{{

function! CustomFold()
  return printf('   %2d%s', v:foldend - v:foldstart + 1, getline(v:foldstart))
endfunction

set foldtext=CustomFold()


autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

set foldlevel=99
" Space to toggle folds.
autocmd FileType vim setlocal fdc=1
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType vim setlocal foldlevel=0

autocmd FileType zsh setlocal fdc=1
autocmd FileType zsh setlocal foldmethod=marker
autocmd FileType zsh setlocal foldlevel=0

" au FileType html nnoremap <buffer> <leader>F zfat
let ruby_fold = 1
set foldlevelstart=1
" }}}

" Colorscheme ---------------------------------------------------------------{{{
" Load the colorscheme
colorscheme tokyonight

if (has("termguicolors"))
  set termguicolors
endif
let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " True gui colors in terminal
set background=dark
set t_Co=256
let g:impact_transbg=1
au VimLeave * set guicursor=a:block-blinkon0

let g:tokyonight_style = "night"
let g:tokyonight_italic_functions = 1
let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]

hi Comment gui=italic cterm=italic
hi htmlArg gui=italic cterm=italic

hi Normal ctermbg=NONE guibg=NONE

highlight MatchParen cterm=bold ctermbg=blue ctermfg=black     " Matching paren hightlight color change
" highlight LineNr ctermfg=darkGrey                              " Lighter line numbers from OneDark theme
highlight CursorLineNr guifg=#0099ff                           " Make current line number blue
highlight Comment cterm=italic                                 " enable italicised comments in vim
" highlight CursorLine term=bold cterm=bold guibg=Grey40         " Light grey colour for cursorline
highlight CursorLine term=bold cterm=bold ctermbg=18 guibg=#292b2e
" autocmd FileType ruby highlight OverLength guibg=#a06e3b ctermbg=3
" autocmd FileType ruby match OverLength /\%>121v.\+/
highlight ColorColumn ctermbg=red guibg=#a06e3b ctermbg=3
highlight Search ctermfg=8 ctermbg=3 guifg=#b3b3b3 guibg=#a06e3b
highlight illuminatedWord cterm=underline gui=underline

" let g:ale_sign_error = " ✘ "
" let g:ale_sign_warning = " ⚠ "
" let g:ale_sign_info = "  "
" let g:ale_sign_highlight_linenrs = 1

" highlight link ALEWarningSign Todo
" highlight link ALEErrorSign WarningMsg
" highlight link ALEVirtualTextWarning Todo
" highlight link ALEVirtualTextInfo Todo
" highlight link ALEVirtualTextError WarningMsg

" syntax match todoCheckbox '\v.*\[\ \]'hs=e-2 conceal cchar=
" syntax match todoCheckbox '\v.*\[X\]'hs=e-2 conceal cchar=
setlocal conceallevel=2
hi Conceal guibg=NONE
" hi clear Conceal

highlight ALEErrorSign cterm=bold ctermfg=160 ctermbg=NONE gui=bold guifg=#e0211d guibg=NONE " Overriding the color for error sign
" }}}

set fillchars=vert:\│,eob:\  " replaces ~ with space for endofbuffer

" Plugins configs -----------------------------------------------------------{{{
lua require('plugin_configs')
lua require('plugins')
" Search NOTES -------------------------- {{{
" lua << EOF
" function _G.search_notes()
"   require("telescope.builtin").live_grep({
"     prompt_title = \"< Notes >", cwd = \"~/vimwiki/",
"     })
" end
" EOF

function! SearchWiki()
  lua require("telescope.builtin").live_grep({ prompt_title = "< Notes >", cwd = "~/vimwiki/",  })
endfunction
command! SearchWiki call SearchWiki()

" }}}
" Plugin: Galaxyline -------------------------- {{{

function! ConfigStatusLine()
  lua require('plugins.status-line')
endfunction

augroup status_line_init
  autocmd!
  autocmd VimEnter * call ConfigStatusLine()
augroup END

" }}}

" vim-notes --{{{
let g:notes_tab_indents = 0
let g:notes_unicode_enabled = 0
let g:notes_directories = ['~/Documents/Notes']
let g:notes_word_boundaries = 1
let g:notes_conceal_code = 0

if !exists('g:notes_directories')
  let g:notes_directories = ['']
  function! FzfNote()
    execute 'FzfFiles' fnameescape(g:notes_directories[0])
  endfunction
  command! FzfNote call FzfNote()
endif
" }}}

" Limelight --{{{
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" }}}


" Goyo -------{{{

function! s:goyo_enter()
  Limelight
  TableModeEnable
  if has('gui_running')
    set fullscreen
    set linespace=7
  elseif exists('$TMUX')
    silent !tmux set status off
  endif

  set nolist
endfunction

function! s:goyo_leave()
  Limelight!
  TableModeDisable
  if has('gui_running')
    set nofullscreen
    set linespace=0
  elseif exists('$TMUX')
    silent !tmux set status on
  endif

  set listchars=eol:$,tab:␉·,trail:␠,nbsp:⎵   " show $ in the end of line
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" }}}

" WIKI -------{{{
let g:vimwiki_listsyms = '✗○◐●✓'
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
" }}}


let g:fzf_command_prefix = 'Fzf'

" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline_symbols.space = "\ua0"
" let g:airline_powerline_fonts = 1
" let g:airline_theme='violet'

let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'file':    'dispatch',
  \ 'suite':   'basic',
  \}

let g:ale_fixers = {
  \'python': ['pylint', 'flake8'],
  \'ts': ['prettier'],
  \'tsx': ['prettier'],
  \'ruby': ['rubocop'],
  \'javascript': ['eslint'],
  \'typescript': ['prettier'],
  \'scss': ['prettier'],
  \'html': ['prettier']
  \}
let g:ale_linters = {
  \'python': ['pylint', 'flake8'],
  \'ruby': ['rubocop', 'rails_best_practices', 'srb'],
  \'javascript': ['eslint'],
  \'typescript': ['tsserver', 'tslint'],
  \'typescript.tsx': ['tsserver', 'tslint'],
  \}
let g:ale_fix_on_save = 1
let g:ale_ruby_rubocop_executable = 'bundle exec rubocop'
let g:ale_sign_column_always = 1
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = ' ▶ '


" let g:UltiSnipsExpandTrigger='<c-s>'
" let g:UltiSnipsListSnippets='<leader>ss'
" let g:UltiSnipsJumpForwardTrigger='<c-b>'
" let g:UltiSnipsJumpBackwardTrigger='<c-S>'
" let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']

function! GalaxyUrl(opts, ...) abort
  if a:0 || type(a:opts) != type({})
    return ''
  endif

  let remote = matchlist(a:opts.remote, '\v^https:\/\/git-mirror.shopifycloud.com\/(.{-1,})(\.git)?$')
  let remote_galaxy = matchlist(a:opts.remote, '\v^galaxy::(.{-1,})(\.git)?$')

  if empty(remote) && empty(remote_galaxy)
    return ''
  end

  let opts = copy(a:opts)
  let opts.remote = "https://github.com/" . remote[1] . ".git"
  return call("rhubarb#FugitiveUrl", [opts])
endfunction

if !exists('g:fugitive_browse_handlers')
  let g:fugitive_browse_handlers = []
endif

if index(g:fugitive_browse_handlers, function('GalaxyUrl')) < 0
  call insert(g:fugitive_browse_handlers, function('GalaxyUrl'))
endif

" let g:dashboard_custom_shortcut={
"   \ 'last_session'       : 'SPC s l',
"   \ 'find_history'       : 'SPC f h',
"   \ 'find_file'          : 'SPC f f',
"   \ 'new_file'           : 'SPC c n',
"   \ 'change_colorscheme' : 'SPC t c',
"   \ 'find_word'          : 'SPC f a',
"   \ 'book_marks'         : 'SPC f b',
"   \ }

" let g:dashboard_default_header = 'transformer'
" let g:dashboard_preview_command="cat"
" let g:dashboard_preview_file="~/.config/nvim/sunjon.cat"
" let g:dashboard_preview_pipeline="lolcat"
let g:dashboard_preview_file_width=70
let g:dashboard_preview_file_height=10

let g:indentLine_fileTypeExclude = ['dashboard']

let g:dashboard_custom_section={
\ 'last_session': {
  \ 'description': ['  Recently laset session                  SPC s l'],
  \ 'command': 'SessionLoad',
  \ },
\ 'find_history': {
  \ 'description': ['  Recently opened files                   SPC f h'],
  \ 'command': 'DashboardFindHistory',
  \ },
\ 'find_file': {
  \ 'description': ['  Find  File                              SPC f f'],
  \ 'command': 'Telescope find_files find_command=rg,--hidden,--files',
  \ },
\ 'new_file': {
  \ 'description': ['  File Browser                            SPC f b'],
  \ 'command': 'Telescope file_browser',
  \ },
\ 'find_word': {
  \ 'description': ['  Find  word                              SPC f w'],
  \ 'command': 'DashboardFindWord',
  \ },
\ 'notes': {
  \ 'description': ['  Notes                                   SPC n i'],
  \ 'command': 'VimwikiIndex',
  \ },
\ 'diary': {
  \ 'description': ['  Diary                                   SPC d i'],
  \ 'command': 'VimwikiDiaryIndex',
  \ },
\ 'today_diary': {
  \ 'description': ['  Today Diary                             SPC d t'],
  \ 'command': 'VimwikiMakeDiaryNote',
  \ },
\ }

" }}}

" Vista.vim ---------------------------------------{{{
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

let g:vista#renderer#enable_icon = 1

set statusline+=%{NearestMethodOrFunction()}
set statusline+=%#warningmsg#
set statusline+=%{get(b:,'gitsigns_status','')}
set statusline+=%*
" }}}

" NERDtree ----------------------------------------{{{

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
" }}}

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

command! Sorc source ~/.config/nvim/init.vim
command! Vterm vsp | term
command! Sterm sp | term
" }}}

" FZF -----------------------------------------------------------------------{{{
" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

" Files + devicons
function! Fzf_dev()
  let l:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {2..-1} | head -'.&lines.'"'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m --reverse ' . l:fzf_files_options,
        \ 'window': 'call CreateCenteredFloatingWindow()',
        \ 'down':    '40%' })
endfunction

function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'

" set foldmethod=syntax
" }}}
source ~/.config/nvim/markdown.vim
source ~/.config/nvim/projectionist.vim
