" completion source

let g:ncm2_vsnip#source = extend(get(g:, 'ncm2_vsnip#source', {}), {
            \ 'name': 'vsnip',
            \ 'priority': 7,
            \ 'mark': 'vs',
            \ 'word_pattern': '\S+',
            \ 'on_complete': 'ncm2_vsnip#on_complete',
            \ }, 'keep')

function! ncm2_vsnip#init()
    call ncm2#register_source(g:ncm2_vsnip#source)
endfunction

function! ncm2_vsnip#on_complete(ctx)
    let matches = []
    for item in vsnip#get_complete_items(a:ctx['bufnr'])
        call add(matches, {
                    \ 'abbr': item['abbr'],
                    \ 'word': item['word'],
                    \ 'menu': substitute(item['menu'], '^\[.*\] ', '', ''),
                    \ 'dup': item['dup'],
                    \ })
    endfor
    call ncm2#complete(a:ctx, a:ctx.startccol, matches)
endfunction
