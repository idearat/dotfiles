" Vim syntax file
" Language:	CR:UX (JavaScript subset)
" Based on:	JavaScript syntax by Claudio Fleiner
" Modified for CR:UX forbidden keyword highlighting

if !exists("main_syntax")
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'crux'
elseif exists("b:current_syntax") && b:current_syntax == "crux"
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Load JavaScript syntax first
runtime! syntax/javascript.vim
unlet! b:current_syntax

" Override with RED using syn match (higher priority than keyword)
syn match cruxError /\<new\>/ containedin=ALL
syn match cruxError /\<var\>/ containedin=ALL
syn match cruxError /\<let\>/ containedin=ALL
syn match cruxError /\<class\>/ containedin=ALL
syn match cruxError /\<extends\>/ containedin=ALL
syn match cruxError /\<super\>/ containedin=ALL
syn match cruxError /\<with\>/ containedin=ALL
syn match cruxError /\<eval\>/ containedin=ALL
syn match cruxError /\<void\>/ containedin=ALL
syn match cruxError /\<delete\>/ containedin=ALL
syn match cruxError /\<debugger\>/ containedin=ALL
syn match cruxError /\<typeof\>/ containedin=ALL
syn match cruxError /\<instanceof\>/ containedin=ALL
syn match cruxError /\<null\>/ containedin=ALL
syn match cruxError /\<undefined\>/ containedin=ALL
syn match cruxError /\<this\>/ containedin=ALL
syn match cruxError /\<arguments\>/ containedin=ALL
syn match cruxError /\<import\>/ containedin=ALL
syn match cruxError /\<export\>/ containedin=ALL
syn match cruxError /\<try\>/ containedin=ALL
syn match cruxError /\<catch\>/ containedin=ALL
syn match cruxError /\<throw\>/ containedin=ALL
syn match cruxError /\<finally\>/ containedin=ALL

" Labels
syn match cruxError /\v<(JSVM|GLOBALS)\s*:/ containedin=ALL

" Force RED highlighting
hi! cruxError guifg=#ff0000 gui=bold ctermfg=9 cterm=bold

let b:current_syntax = "crux"
if main_syntax == 'crux'
  unlet main_syntax
endif
let &cpo = s:cpo_save
unlet s:cpo_save
