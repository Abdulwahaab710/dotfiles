" Extracted from https://github.com/gabrielelana/vim-markdown"
function! s:LocateFencedCodeBlock(starting_from, upper_delimiter, lower_delimiter)
  " TODO: extract initialize_code_block
  let code_block = {'from': 0, 'to': 0, 'language': 'txt', 'indentation': '', 'surround': 0}
  let initial_position = getpos('.')
  let search_position = copy(initial_position)
  let search_position[1] = a:starting_from
  let search_position[2] = 0
  cal setpos('.', search_position)

  let start_code_block_backward = search(a:upper_delimiter, 'cbnW')
  let end_code_block_backward = search(a:lower_delimiter, 'cbnW')
  let end_code_block_forward = search(a:lower_delimiter, 'cnW')

  let found_code_block =
        \ start_code_block_backward > 0 &&
        \ end_code_block_forward > 0
  let between_two_code_blocks =
        \ start_code_block_backward < end_code_block_backward &&
        \ end_code_block_backward <= a:starting_from
  let starting_inside_code_block =
        \ found_code_block &&
        \ !between_two_code_blocks &&
        \ start_code_block_backward <= a:starting_from &&
        \ end_code_block_forward >= a:starting_from

  if starting_inside_code_block
    let code_block['language'] = s:ExtractLanguage(start_code_block_backward, a:upper_delimiter)
    let code_block['indentation'] = s:ExtractIndentation(start_code_block_backward)
    let code_block['back_to_position'] = initial_position
    let code_block['back_to_position'][1] = start_code_block_backward
    let code_block['back_to_position'][2] = 0
    let code_block['from'] = start_code_block_backward + 1
    let code_block['to'] = end_code_block_forward - 1
  endif
  return code_block
endfunction

function! s:ExtractLanguage(start_at, upper_delimiter)
  return substitute(getline(a:start_at), a:upper_delimiter, '\1', '')
endfunction

function! s:ExtractIndentation(start_at)
  return substitute(getline(a:start_at), '\(^\s*\).\+$', '\1', '')
endfunction

let s:known_file_extensions = {
  \ 'abap': '.abap',
  \ 'antlr': '.g4',
  \ 'asp': '.asp',
  \ 'ats': '.dats',
  \ 'actionscript': '.as',
  \ 'ada': '.adb',
  \ 'agda': '.agda',
  \ 'apacheconf': '.apacheconf',
  \ 'apex': '.cls',
  \ 'applescript': '.applescript',
  \ 'arc': '.arc',
  \ 'arduino': '.ino',
  \ 'asciidoc': '.asciidoc',
  \ 'assembly': '.asm',
  \ 'augeas': '.aug',
  \ 'autohotkey': '.ahk',
  \ 'autoit': '.au3',
  \ 'awk': '.awk',
  \ 'batchfile': '.bat',
  \ 'befunge': '.befunge',
  \ 'blitzbasic': '.bb',
  \ 'blitzmax': '.bmx',
  \ 'bluespec': '.bsv',
  \ 'boo': '.boo',
  \ 'brainfuck': '.b',
  \ 'brightscript': '.brs',
  \ 'bro': '.bro',
  \ 'c': '.c',
  \ 'c++': '.cpp',
  \ 'cpp': '.cpp',
  \ 'clips': '.clp',
  \ 'cmake': '.cmake',
  \ 'cobol': '.cob',
  \ 'css': '.css',
  \ 'ceylon': '.ceylon',
  \ 'chuck': '.ck',
  \ 'cirru': '.cirru',
  \ 'clean': '.icl',
  \ 'clojure': '.clj',
  \ 'coffeescript': '.coffee',
  \ 'coldfusion': '.cfm',
  \ 'coq': '.coq',
  \ 'creole': '.creole',
  \ 'crystal': '.cr',
  \ 'cucumber': '.feature',
  \ 'cuda': '.cu',
  \ 'cython': '.pyx',
  \ 'd': '.d',
  \ 'dm': '.dm',
  \ 'dot': '.dot',
  \ 'dart': '.dart',
  \ 'diff': '.diff',
  \ 'dylan': '.dylan',
  \ 'ecl': '.ecl',
  \ 'eiffel': '.e',
  \ 'elixir': '.ex',
  \ 'elm': '.elm',
  \ 'erlang': '.erl',
  \ 'flux': '.fx',
  \ 'fortran': '.f90',
  \ 'factor': '.factor',
  \ 'fancy': '.fy',
  \ 'fantom': '.fan',
  \ 'forth': '.fth',
  \ 'gas': '.s',
  \ 'glsl': '.glsl',
  \ 'genshi': '.kid',
  \ 'glyph': '.glf',
  \ 'go': '.go',
  \ 'gosu': '.gs',
  \ 'groff': '.man',
  \ 'groovy': '.groovy',
  \ 'html': '.html',
  \ 'http': '.http',
  \ 'haml': '.haml',
  \ 'handlebars': '.handlebars',
  \ 'harbour': '.hb',
  \ 'haskell': '.hs',
  \ 'haxe': '.hx',
  \ 'hy': '.hy',
  \ 'idl': '.pro',
  \ 'ini': '.ini',
  \ 'idris': '.idr',
  \ 'io': '.io',
  \ 'ioke': '.ik',
  \ 'j': '.ijs',
  \ 'json': '.json',
  \ 'json5': '.json5',
  \ 'jsonld': '.jsonld',
  \ 'jade': '.jade',
  \ 'java': '.java',
  \ 'javascript': '.js',
  \ 'julia': '.jl',
  \ 'krl': '.krl',
  \ 'kotlin': '.kt',
  \ 'lfe': '.lfe',
  \ 'llvm': '.ll',
  \ 'lasso': '.lasso',
  \ 'less': '.less',
  \ 'lilypond': '.ly',
  \ 'livescript': '.ls',
  \ 'logos': '.xm',
  \ 'logtalk': '.lgt',
  \ 'lua': '.lua',
  \ 'm': '.mumps',
  \ 'makefile': '.mak',
  \ 'mako': '.mako',
  \ 'markdown': '.md',
  \ 'mask': '.mask',
  \ 'matlab': '.matlab',
  \ 'max': '.maxpat',
  \ 'mediawiki': '.mediawiki',
  \ 'mirah': '.druby',
  \ 'monkey': '.monkey',
  \ 'moocode': '.moo',
  \ 'moonscript': '.moon',
  \ 'myghty': '.myt',
  \ 'nsis': '.nsi',
  \ 'nemerle': '.n',
  \ 'netlogo': '.nlogo',
  \ 'nginx': '.nginxconf',
  \ 'nimrod': '.nim',
  \ 'nu': '.nu',
  \ 'numpy': '.numpy',
  \ 'ocaml': '.ml',
  \ 'objdump': '.objdump',
  \ 'omgrofl': '.omgrofl',
  \ 'opa': '.opa',
  \ 'opencl': '.cl',
  \ 'org': '.org',
  \ 'oxygene': '.oxygene',
  \ 'pawn': '.pwn',
  \ 'php': '.php',
  \ 'parrot': '.parrot',
  \ 'pascal': '.pas',
  \ 'perl': '.pl',
  \ 'perl6': '.p6',
  \ 'pike': '.pike',
  \ 'pod': '.pod',
  \ 'pogoscript': '.pogo',
  \ 'postscript': '.ps',
  \ 'powershell': '.ps1',
  \ 'processing': '.pde',
  \ 'prolog': '.prolog',
  \ 'puppet': '.pp',
  \ 'python': '.py',
  \ 'qml': '.qml',
  \ 'r': '.r',
  \ 'rdoc': '.rdoc',
  \ 'realbasic': '.rbbas',
  \ 'rhtml': '.rhtml',
  \ 'rmarkdown': '.rmd',
  \ 'racket': '.rkt',
  \ 'rebol': '.rebol',
  \ 'redcode': '.cw',
  \ 'robotframework': '.robot',
  \ 'rouge': '.rg',
  \ 'ruby': '.rb',
  \ 'rust': '.rs',
  \ 'scss': '.scss',
  \ 'sql': '.sql',
  \ 'sage': '.sage',
  \ 'sass': '.sass',
  \ 'scala': '.scala',
  \ 'scaml': '.scaml',
  \ 'scheme': '.scm',
  \ 'scilab': '.sci',
  \ 'self': '.self',
  \ 'shell': '.sh',
  \ 'shen': '.shen',
  \ 'slash': '.sl',
  \ 'smalltalk': '.st',
  \ 'smarty': '.tpl',
  \ 'squirrel': '.nut',
  \ 'stylus': '.styl',
  \ 'supercollider': '.scd',
  \ 'toml': '.toml',
  \ 'txl': '.txl',
  \ 'tcl': '.tcl',
  \ 'tcsh': '.tcsh',
  \ 'tex': '.tex',
  \ 'tea': '.tea',
  \ 'textile': '.textile',
  \ 'turing': '.t',
  \ 'twig': '.twig',
  \ 'typescript': '.ts',
  \ 'unrealscript': '.uc',
  \ 'vhdl': '.vhdl',
  \ 'vala': '.vala',
  \ 'verilog': '.v',
  \ 'viml': '.vim',
  \ 'volt': '.volt',
  \ 'xc': '.xc',
  \ 'xml': '.xml',
  \ 'xproc': '.xpl',
  \ 'xquery': '.xquery',
  \ 'xs': '.xs',
  \ 'xslt': '.xslt',
  \ 'xtend': '.xtend',
  \ 'yaml': '.yml',
  \ 'ec': '.ec',
  \ 'edn': '.edn',
  \ 'fish': '.fish',
  \ 'mupad': '.mu',
  \ 'nesc': '.nc',
  \ 'ooc': '.ooc',
  \ 'restructuredtext': '.rst',
  \ 'wisp': '.wisp',
  \ 'xbase': '.prg',
\ }

function! s:ReplaceEditedBlock()
  augroup MarkdownReplaceEditedBlock
    autocmd!
  augroup END
  augroup! MarkdownReplaceEditedBlock

  if b:code_block['to'] - b:code_block['from'] >= 0
    execute b:code_block['from'] . ',' b:code_block['to'] . ' delete _'
  endif
  let content = readfile(b:code_block['file_path'])
  let content = s:IndentBlock(l:content, b:code_block['indentation'])
  let content = s:SurroundWithFencedCodeBlock(l:content, b:code_block)
  call append(b:code_block['from']-1, content)
  call setpos('.', b:code_block['back_to_position'])

  execute 'silent bwipeout! ' . b:code_block['file_path']
  call delete(b:code_block['file_path'])
  unlet! b:code_block
endfunction

function! s:UnindentBlock(content, indentation)
  return map(a:content, 'substitute(v:val, ''^' . a:indentation . ''', '''', ''g'')')
endfunction

function! s:IndentBlock(content, indentation)
  return map(a:content, 'substitute(v:val, ''^'', ''' . a:indentation . ''', ''g'')')
endfunction

function! s:SurroundWithFencedCodeBlock(code, editing)
  if !a:editing['surround'] | return a:code | endif
  if a:editing['language'] =~# 'markdown' | return a:code | endif
  let before =
    \ (a:editing['make_room_before'] ? [''] : []) +
    \ [a:editing['indentation'] . '```' . a:editing['language']]
  let after =
    \ [a:editing['indentation'] . '```'] +
    \ (a:editing['make_room_after'] ? [''] : [])
  return l:before + a:code + l:after
endfunction

function! s:LocateRangeBlock(from, to)
  " TODO: extract initialize_code_block
  let code_block = {'from': 0, 'to': 0, 'language': 'txt', 'indentation': '', 'surround': 0}
  if a:to >= a:from
    let code_block['from'] = a:from
    let code_block['to'] = a:to
    let code_block['back_to_position'] = getpos('.')
    let code_block['language'] = 'markdown'

    if a:from == a:to && getline(a:from) =~ '^\s*$'
      let code_block['surround'] = 1
      let code_block['make_room_before'] = getline(a:from - 1) !~ '^\s*$'
      let code_block['make_room_after'] = getline(a:to + 1) !~ '^\s*$'
      let code_block['language'] = input('filetype? (default: markdown) ', '', 'filetype')
      if code_block['language'] =~ '^\s*$'
        let code_block['language'] = 'markdown'
      endif
    endif
  endif
  return code_block
endfunction

function! EditBlock() range abort
  if exists('b:markdown_temporary_buffer') && b:markdown_temporary_buffer
    echo 'Sorry, you cannot edit a code block inside a temporary buffer'
    return
  endif
  " Github fenced code blocks like ```ruby
  let code_block = s:LocateFencedCodeBlock(a:firstline,
    \ '^\s*`\{3,}\(\w\+\)\%(\s.*$\|$\)',
    \ '^\s*`\{3,}\s*$'
    \ )
  if code_block['from'] == 0 || code_block['to'] == 0
    " Github fenced code blocks with metadata like ```{ruby, <WHATEVER>}
    let code_block = s:LocateFencedCodeBlock(a:firstline,
      \ '^\s*`\{3,}{\(\w\+\),[^}]\+}\%(\s.*$\|$\)',
      \ '^\s*`\{3,}\s*$'
      \ )
  endif
  if code_block['from'] == 0 || code_block['to'] == 0
    " Github fenced code blocks alternate style like ~~~ruby
    let code_block = s:LocateFencedCodeBlock(a:firstline,
      \ '^\s*\~\{3,}\(\w\+\)\%(\s.*$\|$\)',
      \ '^\s*\~\{3,}\s*$'
      \ )
  endif
  if code_block['from'] == 0 || code_block['to'] == 0
    " Liquid fenced code blocks {% highlight ruby %}
    " (since we support some liquid/jekyll tags, why not?)
    let code_block = s:LocateFencedCodeBlock(a:firstline,
      \ '^\s*{%\s*highlight\s\+\(\w\+\)\s*%}\%(\s.*$\|$\)',
      \ '^\s*{%\s*endhighlight\s*%}\%(\s.*$\|$\)'
      \ )
  endif
  if code_block['from'] == 0 || code_block['to'] == 0
    let code_block = s:LocateRangeBlock(a:firstline, a:lastline)
  endif
  if code_block['from'] == 0 || code_block['to'] == 0
    echo 'Sorry, I did not find any suitable code block to edit or create'
    return
  endif

  let code_block['file_extension'] = '.' . code_block['language']
  if has_key(s:known_file_extensions, code_block['language'])
    let code_block['file_extension'] = s:known_file_extensions[code_block['language']]
  endif
  let code_block['file_path'] = tempname() . code_block['file_extension']
  let code_block['content'] = getline(code_block['from'], code_block['to'])
  let code_block['content'] = s:UnindentBlock(code_block['content'], code_block['indentation'])

  call writefile(code_block['content'], code_block['file_path'])
  augroup MarkdownReplaceEditedBlock
    autocmd BufEnter <buffer> call s:ReplaceEditedBlock()
  augroup END

  let b:code_block = code_block
  execute 'split ' . code_block['file_path']
  let b:markdown_temporary_buffer = 1
  autocmd BufLeave <buffer> wq
endfunction
command! -nargs=0 -range MarkdownEditBlock :<line1>,<line2>call EditBlock()
