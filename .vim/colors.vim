" =========================================
" Colorscheme
" =========================================
let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " True gui colors in terminal
set background=dark
set t_Co=256
let g:impact_transbg=1
colorscheme hybrid
color base16-tomorrow-night
set termguicolors

hi MatchParen cterm=bold ctermbg=blue ctermfg=black     " Matching paren hightlight color change
hi LineNr ctermfg=darkGrey                              " Lighter line numbers from OneDark theme
hi CursorLineNr ctermfg=blue                            " Make current line number blue
set cursorline                                          " Shows a visual cursor line
hi CursorLine term=bold cterm=bold guibg=Grey40         " Light grey colour for cursorline
