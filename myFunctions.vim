" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

let g:ArrowKeys=0

function! ToggleArrowKeys()
    echo "hi"
    if(ArrowKeys == 0)
        map <up> <k>            " disable arrow keys
        map <down> <j>          " disable arrow keys
        map <left> <h>          " disable arrow keys
        map <right> <l>         " disable arrow keys
        imap <up> <k>           " disable arrow keys
        imap <down> <j>         " disable arrow keys
        imap <left> <h>         " disable arrow keys
        imap <right> <l>        " disable arrow keys
        let g:ArrowKeys=1
        echo "hello world!"
    else
        map <up> <nop>            " disable arrow keys
        map <down> <nop>          " disable arrow keys
        map <left> <nop>          " disable arrow keys
        map <right> <nop>         " disable arrow keys
        imap <up> <nop>           " disable arrow keys
        imap <down> <nop>         " disable arrow keys
        imap <left> <nop>         " disable arrow keys
        imap <right> <nop>        " disable arrow keys
        let g:ArrowKeys=0
    endif
endfunction
