function! Write750Entry()
    let g:work_dir = expand('~/Documents/750words')

    if !isdirectory(g:work_dir)
        call mkdir(g:work_dir, "p")
    endif

    let l:filename = g:work_dir . "/" . strftime("%d.%b.%Y.md")

    execute 'edit ' . l:filename

    if filereadable(l:filename) == 0
        call append(0, "# 750 Words - " . strftime("%d %B %Y"))
        call append(1, "")
        call append(2, "---")
        call append(3, "")
    endif
endfunction

function! Reveal750(...)
    let g:words_directory = expand('~/Documents/750words')

    if !isdirectory(g:words_directory)
        echo "Notes folder not found: " . g:words_directory
        return
    endif

    let l:files = globpath(g:words_directory, "*.md", 0, 1)

    if empty(l:files)
        echo "No notes found!"
        return
    endif

    let l:temp_buffer = '__750words_list__'
    execute 'botright new ' . l:temp_buffer
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal nobuflisted
    setlocal nowrap
    setlocal nonumber
    setlocal norelativenumber
    setlocal noswapfile
    setlocal signcolumn=no

    let l:notes_by_month = {}
    for l:file in l:files
        let l:date = split(fnamemodify(l:file, ":t"), '\.')
        let l:month_year = toupper(l:date[1]) . ' ' . l:date[2]
        if !has_key(l:notes_by_month, l:month_year)
            let l:notes_by_month[l:month_year] = []
        endif
        call add(l:notes_by_month[l:month_year], fnamemodify(l:file, ":t"))
    endfor

    let l:lines = []
    for l:month in keys(l:notes_by_month)
        call add(l:lines, '**' . l:month . '**')
        call extend(l:lines, l:notes_by_month[l:month])
        call add(l:lines, '')
    endfor

    call setline(1, l:lines)

    call append('$', '---')
    call append('$', 'Use <CR> to open a file, or q to quit.')

    nnoremap <buffer> <CR> :call Open750File()<CR>
    nnoremap <buffer> q :bd!<CR>
endfunction

function! Open750File()
    let g:words_directory = expand('~/Documents/750words')
    let l:line = getline('.')

    if l:line =~ '^\*\*.*\*\*$' || l:line =~ '^---$' || l:line == ''
        return
    endif

    let l:filepath = g:words_directory . '/' . l:line

    if filereadable(l:filepath)
        execute 'edit ' . l:filepath
    else
        echo "File not found: " . l:filepath
    endif
endfunction

function! Reminder750()
    let g:work_dir = expand('~/Documents/750words')

    let l:reminder_date = strftime("%d.%b.%Y", localtime() - (30 * 86400))
    let l:filename = g:work_dir . "/" . l:reminder_date . ".md"

    if filereadable(l:filename)
        echo "Reminder: Revisit your 750-word entry from " . l:reminder_date . " (:Reveal750 30)"
    else
        echo "No entry found for " . l:reminder_date
    endif
endfunction

function! WordCount()
    let l:word_count = len(split(join(getline(1, '$')), '\W\+'))
    echo "Word count: " . l:word_count
endfunction

command! Write750 call Write750Entry()
command! -nargs=? Reveal750 call Reveal750(<f-args>)
nnoremap <leader>wc :call WordCount()<CR>

autocmd VimEnter * call Reminder750()

