require 'rubygems'
require 'interactive_editor'

if has("autocmd")
	" Enable filetype detection
	filetype plugin indent on

	" Restore cursor position
	autocmd BufReadPost *
		\ if line("'\"") > 1 && line("'\"") <= line("$") |
		\		exe "normal! g`\"" |
		\	endif
endif
if &t_Co > 2 || has("gui_running")
	" Enable syntax highlighting
	syntax on
endif

