if exists('g:loaded_ctrlp_chemrtron') && g:loaded_ctrlp_chemrtron
  finish
endif
let g:loaded_ctrlp_chemrtron = 1

let s:config_file = get(g:, 'ctrlp_chemrtron_file', '~/.ctrlp-chemrtron')

let s:chemrtron_var = {
\  'init':   'ctrlp#chemrtron#init()',
\  'exit':   'ctrlp#chemrtron#exit()',
\  'accept': 'ctrlp#chemrtron#accept',
\  'lname':  'chemrtron',
\  'sname':  'chemrtron',
\  'type':   'path',
\  'sort':   0,
\  'nolim':  1,
\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:chemrtron_var)
else
  let g:ctrlp_ext_vars = [s:chemrtron_var]
endif

function! ctrlp#chemrtron#init()
  let s:lines = readfile(expand('~/.chemr/cache/' . s:word . '.dat'))[1:]
  if s:word == 'cpan'
    let s:lines = map(s:lines, 'v:val . "\thttp://search.cpan.org/perldoc?" . v:val')
  endif
  return s:lines
endfunc

function! ctrlp#chemrtron#start(word)
  let s:word = a:word
  call ctrlp#init(ctrlp#chemrtron#id())
endfunction

function! ctrlp#chemrtron#accept(mode, str)
  let items = filter(copy(s:lines), 'stridx(v:val, a:str) != -1')
  if len(items) != 0
    call ctrlp#exit()
    call openbrowser#open(split(items[0], "\t")[1]) 
  endif
endfunction

function! ctrlp#chemrtron#exit()
  if exists('s:list')
    unlet! s:list
  endif
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#chemrtron#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
