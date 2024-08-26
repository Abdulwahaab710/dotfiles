local g = vim.g
g.vimwiki_markdown_link_ext = 1

g.vimwiki_table_mappings = 0

vim.cmd([[
function! VimwikiLinkHandler(link)
    let link = a:link
    let islink = 0
    if link =~ '^local:.*'
        let islink = 1
        let local_dir = matchstr(link, '^local:\zs.*')
        let abs_dir = expand('%:p:h').'/'.local_dir
        " open dolphin in the desired directory. Sorry, I don't know how to open Windows explorer
        " call system("cmd " . shellescape(abs_dir) . " &")
        " exe "!explorer '" . substitute(abs_dir,"/","\\\\",'g') . "'"
        " return 1
    elseif link =~ '^file:.*'
        let islink = 1
        let abs_dir = matchstr(link, '^file:\zs.*')
        " open the directory with netrw
        " call system("cmd " . substitute(dir,"/","\\",'g'))
        " return 1
    endif
    if islink == 1
        exe "tabedit " . abs_dir
        return 1
    else
        return 0
    endif
endfunction

" disable table mappings
let g:vimwiki_key_mappings = {
            \ 'all_maps': 1,
            \ 'global': 1,
            \ 'headers': 1,
            \ 'text_objs': 1,
            \ 'table_format': 1,
            \ 'table_mappings': 0,
            \ 'lists': 1,
            \ 'links': 1,
            \ 'html': 1,
            \ 'mouse': 0,
            \ }

augroup VimwikiRemaps
    autocmd!
    " unmap tab in insert mode
    autocmd Filetype vimwiki silent! iunmap <buffer> <Tab>
    " remap table tab mappings to M-n M-p
    autocmd Filetype vimwiki inoremap <silent><expr><buffer> <M-n> vimwiki#tbl#kbd_tab()
    autocmd Filetype vimwiki inoremap <silent><expr><buffer> <M-p> vimwiki#tbl#kbd_shift_tab()
    " on enter if completion is open, complete first element otherwise use
    " default vimwiki mapping
    " autocmd Filetype vimwiki inoremap <silent><expr><buffer> <cr> pumvisible() ? coc#_select_confirm()
    "                           \: "<C-]><Esc>:VimwikiReturn 1 5<CR>"
augroup end
]])
