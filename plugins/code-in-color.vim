function! s:GetNameFromLine(line)
    return substitute(a:line, '\(\w\+\).\+', '\1', '')
endfunction

function! s:GetNames()
    let ctags_output = system('ctags -f - ' . expand('%'))
    let lines = split(ctags_output, '\n')
    return sort(map(lines, 's:GetNameFromLine(v:val)'))
endfunction

function! s:CodeInColorInit()
    let names = s:GetNames()
    syntax off

    for name in names
        let groupname = substitute(name, '^\w', '\U&', '')
        execute 'syntax match ' . groupname . ' "' . name . '"'
        "calculate color for each word individually
        execute 'hi ' . groupname . ' ctermfg=145'
    endfor
endfunction

command! CodeInColor call s:CodeInColorInit()
