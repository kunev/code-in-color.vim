function! s:CheckExtractorForFiletype()
    if &filetype == 'python'
        let b:name_extractor = 's:GetPython3Names'
    else
        echom "No names extractor for filetype=" . &filetype
    endif
endfunction

function s:GetPython3Names()
    let names = system('py3names ' . expand('%'))
    return split(names, '\n')
endf

function s:GetNames()
    call s:CheckExtractorForFiletype()
    if exists('b:name_extractor')
        let names = eval(b:name_extractor . '()')
        return names
    endif
endfunction

function! s:CodeInColorInit()
    let names = s:GetNames()
    let colorNum = 58
    set syntax=off

    for name in names
        let groupname = substitute(name, '^\w', '\U&', '')
        execute 'syntax match ' . groupname . ' "\<' . name . '\>"'
        "calculate color for each word individually
        execute 'hi ' . groupname . ' ctermfg=' . colorNum
        let colorNum += 1
    endfor
endfunction

function! s:CodeInColorStop()
    exec 'setf ' . &ft
    exec 'syntax off'
    exec 'syntax on'
endfunction

command! StartCodeInColor call s:CodeInColorInit()
command! StopCodeInColor call s:CodeInColorStop()
command! ShowNames echo s:GetNames()
