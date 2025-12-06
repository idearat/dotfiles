" CR:UX syntax - delegates to tree-sitter
" This file exists only to prevent Neovim from loading javascript.vim

if exists("b:current_syntax")
  finish
endif

" Do nothing - let tree-sitter handle everything
let b:current_syntax = "crux"
