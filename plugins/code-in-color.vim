function! s:GetNameFromLine(line)
    return substitute(a:line, '\(\w\+\).\+', '\1', '')
endfunction

function! s:GetNames()
    let l:ctags_output = system('ctags -f - ' . expand('%'))
    let l:lines = split(l:ctags_output, '\n')
    return map(l:lines, 's:GetNameFromLine(v:val)')
endfunction
