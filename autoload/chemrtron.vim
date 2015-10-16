function! chemrtron#complete(arglead, cmdline, cursorpos)
  return filter(map(split(expand('~/.chemr/cache/*.dat'), "\n"), 'fnamemodify(v:val, ":t:r")'), 'stridx(v:val, a:arglead)==0')
endfunction

