local g = vim.g
g.vimwiki_markdown_link_ext = 1

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
]])
