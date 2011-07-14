"=============================================================================
" idearat's .vimrc
" ...heavily influenced by/cribbed from:
"		Drew Neil's (www.vimcasts.org)
"		Derek Wyatt's (www.derekwyatt.org)
"		These two guys just rock.
"
"-----------------------------------------------------------------------------
" Drew Neil (Baseline)
"-----------------------------------------------------------------------------

" Manage plugins. {{{1
runtime macros/matchit.vim
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
let g:GetLatestVimScripts_allowautoinstall=1
" An example for a vimrc file. {{{1
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Jul 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Preferences {{{1
set visualbell t_vb=
set number
set cursorline
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set hidden
set nojoinspaces
"set listchars=tab:▸\ ,eol:¬
set wildmode=longest,list
"set spelllang=en_gb
" Put swap files in /tmp file
set backupdir=~/tmp
set directory=~/tmp
if has("autocmd")
  autocmd FileType html,css,scss,ruby,pml,yaml,coffee,vim setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType markdown setlocal wrap linebreak nolist
  autocmd BufNewFile,BufRead *.rss setfiletype xml
  autocmd BufNewFile,BufRead Rakefile,Capfile,Gemfile,Termfile,config.ru setfiletype ruby
  autocmd FileType ruby :Abolish -buffer initialise initialize
  autocmd FileType vo_base :colorscheme solarized
endif

" Toggles & Switches (Leader commands) {{{1
let mapleader = ","
nmap <silent> <leader>l :set list!<CR>
nmap <silent> <leader>w :set wrap!<CR>
nmap <silent> <buffer> <leader>s :set spell!<CR>
nmap <silent> <leader>n :silent :nohlsearch<CR>
nmap <silent> <leader>c :IndentGuidesToggle<CR>
command! -nargs=* Wrap set wrap linebreak nolist
command! -nargs=* Maxsize set columns=1000 lines=1000
" CTags {{{1
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
let Tlist_WinWidth = 50
let tlist_markdown_settings='markdown;h:Headings'
let Tlist_Show_One_File=1
nmap <Leader>/ :TlistToggle<CR>

" Mappings {{{1
" Speed up buffer switching {{{2
map <C-k> <C-W>k
map <C-j> <C-W>j
map <C-h> <C-W>h
map <C-l> <C-W>l
" Speed up tab switching {{{2
map <D-S-]> gt
map <D-S-[> gT
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>
" Shortcuts to make it easier to explore wrapped lines {{{2
" These come in handy when the following settings are enabled:
"     :set linebreak wrap nolist
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g^
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g^
" Shortcuts for opening file in same directory as current file {{{2
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%
map <leader>er :e <C-R>=expand("%:r")."."<CR>
" Shortcuts for visual selections {{{2
nmap gV `[v`]
" Alignment commands {{{1
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif
" TextObject tweaks {{{1
nnoremap viT vitVkoj
nnoremap vaT vatV
" Insert mode mappings {{{1
" emacs style jump to end of line
imap <C-e> <C-o>A
imap <C-a> <C-o>I
" Open line above (ctrl-shift-o much easier than ctrl-o shift-O)
imap <C-Enter> <C-o>o
imap <C-S-Enter> <C-o>O
" Easily modify vimrc {{{1
nmap <leader>v :e $HOME/.vimrc<CR>
" http://stackoverflow.com/questions/2400264/is-it-possible-to-apply-vim-configurations-without-restarting/2400289#2400289
if has("autocmd")
  augroup myvimrchooks
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $HOME/.vimrc | if has('gui_running') | so $HOME/.gvimrc | endif
  augroup END
endif

" Custom commands and functions {{{1
" Create a :Quickfixdo command, to match :argdo/bufdo/windo {{{2
" Define a command to make it easier to use
command! -nargs=* Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction

command! -nargs=+ QFDo call QFDo(<q-args>)
" Function that does the work
function! QFDo(command)
  " Create a dictionary so that we can get the list of buffers rather than
  " the list of lines in buffers (easy way to get unique entries)
  let buffer_numbers = {}
  " For each entry, use the buffer number as a dictionary key (won't get
  " repeats)
  for fixlist_entry in getqflist()
    let buffer_numbers[fixlist_entry['bufnr']] = 1
  endfor
  " Make it into a list as it seems cleaner
  let buffer_number_list = keys(buffer_numbers)

  " For each buffer
  for num in buffer_number_list
    " Select the buffer
    exe 'buffer' num
    " Run the command that's passed as an argument
    exe a:command
    " Save if necessary
    update
  endfor
endfunction
" http://stackoverflow.com/questions/4792561/how-to-do-search-replace-with-ack-in-vim
" Show syntax highlighting groups for word under cursor {{{2
" Tip: http://stackoverflow.com/questions/1467438/find-out-to-which-highlight-group-a-particular-keyword-symbol-belongs-in-vim
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" Wipe all buffers which are not active (i.e. not visible in a window/tab) {{{2
" http://stackoverflow.com/questions/2974192/how-can-i-pare-down-vims-buffer-list-to-only-include-active-buffers
" http://stackoverflow.com/questions/1534835/how-do-i-close-all-buffers-that-arent-shown-in-a-window-in-vim
command! -nargs=* Only call CloseHiddenBuffers()
function! CloseHiddenBuffers()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that are loaded and not visible
  let l:tally = 0
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      let l:tally += 1
      exe 'bw ' . b
    endif
  endfor
  echon "Deleted " . l:tally . " buffers"
endfun

" Set tabstop, softtabstop and shiftwidth to the same value {{{2
" From http://vimcasts.org/episodes/tabs-and-spaces/
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction
 
function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    end
  finally
    echohl None
  endtry
endfunction

" Strip trailing whitespaces  {{{2
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>
" Swap words in a single substitution command {{{2
" http://stackoverflow.com/questions/765894/can-i-substitute-multiple-items-in-a-single-regular-expression-in-vim-or-perl/766093#766093
function! Refactor(dict) range
  execute a:firstline . ',' . a:lastline .  's/\C\<\%(' . join(keys(a:dict),'\|'). '\)\>/\='.string(a:dict).'[submatch(0)]/ge'
endfunction
command! -range=% -nargs=1 Refactor :<line1>,<line2>call Refactor(<args>)

" Running :Refactor {'quick':'slow', 'lazy':'energetic'}  will change the following text:
"    The quick brown fox ran quickly next to the lazy brook.
"into:
"    The slow brown fox ran slowly next to the energetic brook.

" TODO: create a :Swap command, which turns:
"    :Swap(portrait,landscape)
" into
"    :Refactor {'portrait':'landscape', 'landscape':'portrait'}

" Status line {{{1
" Good article on setting a statusline:
"   http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
" Always show the status line (even if no split windows)
set laststatus=2
" Mappings for a recovering TextMate user {{{1
" Indentation {{{2
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" Commenting {{{2
" requires NERDCommenter plugin
vmap <D-/> ,c<space>gv
map <D-/> ,c<space>

" Duplicate selection {{{2
"vmap <S-C-D> :copy'> <CR>V`[o
"nmap <S-C-D> :copy .<CR>
" Move selection {{{2
  " Move current line down/up
  map <C-Down> ]e
  map <C-Up> [e
  " Move visually selected lines down/up
  vmap <C-Down> ]egv
  vmap <C-Up> [egv
" Move visual selection back/forwards
set ww+=<,>
vmap <C-Left> x<Left>P`[v`]
vmap <C-Right> x<Right>P`[v`]
" Configure plugins {{{1
" Gundo.vim {{{2
map <Leader>u :GundoToggle<CR>

" TextObject customizations {{{2
" Entire text object {{{3
" Map text-object for entire buffer to `ia` and `aa`.
let g:textobj_entire_no_default_key_mappings = 1
xmap aa  <Plug>(textobj-entire-a)
omap aa  <Plug>(textobj-entire-a)
xmap ia  <Plug>(textobj-entire-i)
omap ia  <Plug>(textobj-entire-i)
" }}}
" Space.vim {{{2
let g:space_disable_select_mode=1
let g:space_no_search = 1

" Solarized {{{2
set background=light
colorscheme solarized
if has("autocmd")
  " For some reason, opening a vimoutliner file switches to another
  " colorscheme. This prevents that from happening.
  autocmd FileType vo_base :colorscheme solarized
endif
function! ToggleBackground()
    if (g:solarized_style=="dark")
    let g:solarized_style="light"
    colorscheme solarized
else
    let g:solarized_style="dark"
    colorscheme solarized
endif
endfunction
command! Togbg call ToggleBackground()

" EasyMotion {{{2
let g:EasyMotion_leader_key = ',,'

" Vim wiki {{{2
let g:vimwiki_menu=''
" NERDcommenter {{{2
let g:NERDMenuMode=0
"  Modelines: {{{1
" vim: nowrap fdm=marker
" }}}

"-----------------------------------------------------------------------------
" Derek Wyatt's  
"-----------------------------------------------------------------------------

" Set the status line the way i like it
set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]

" Don't update the display while executing macros
set lazyredraw

" Show the current mode
set showmode

" Hide the mouse pointer while typing
set mousehide

" Set up the gui cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0
set guicursor+=ve:ver35-Cursor
set guicursor+=o:hor50-Cursor
set guicursor+=i-ci:ver25-Cursor
set guicursor+=r-cr:hor20-Cursor
set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

" set the gui options the way I like
set guioptions=ac

" This is the timeout used while waiting for user input on a multi-keyed macro
" or while just sitting and waiting for another key to be pressed measured
" in milliseconds.
"
" i.e. for the ",d" command, there is a "timeoutlen" wait period between the
"      "," key and the "d" key.  If the "d" key isn't pressed before the
"      timeout expires, one of two things happens: The "," command is executed
"      if there is one (which there isn't) or the command aborts.
set timeoutlen=750

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" When the page starts to scroll, keep the cursor N lines from the top and N
" lines from the bottom
set scrolloff=3

" These things start comment lines
set comments=sl:/*,mb:\ *,ex:\ */,O://,b:#,:%,:XCOMM,n:>,fb:-

" Disable encryption (:X)
set key=

" Make the command-line completion better
set wildmenu

" Same as default except that I remove the 'u' option
set complete=.,w,b,t

" When completing by tag, show the whole tag, not just the function name
set showfulltag

" Set the textwidth to be 80 chars...yeah, I still print things.
set textwidth=80

" get rid of the silly characters in window separators
set fillchars=""

" Add ignorance of whitespace to diff
set diffopt+=iwhite

" Initial path seeding
set path=
set path+=/usr/local/include/**
set path+=/usr/include/**

" Set the tags files to be the following
set tags=./tags,tags

" Let the syntax highlighting for Java files allow cpp keywords
let java_allow_cpp_keywords = 1

" Toggle paste mode
nmap <silent> ,p :set invpaste<CR>:set paste?<CR>

" cd to the directory containing the file in the buffer
nmap <silent> ,cd :lcd %:h<CR>
nmap <silent> ,md :!mkdir -p %:p:h<CR>

" Turn off that stupid highlight search
nmap <silent> ,n :set invhls<CR>:set hls?<CR>

" put the vim directives for my file editing settings in
nmap <silent> ,vi
     \ ovim:set ts=4 sts=4 sw=4:<CR>vim600:fdm=marker fdl=1 fdc=0:<ESC>

" Show all available VIM servers
nmap <silent> ,ss :echo serverlist()<CR>

" The following beast is something i didn't write... it will return the
" syntax highlighting group that the current "thing" under the cursor
" belongs to -- very useful for figuring out what to change as far as
" syntax highlighting goes.
nmap <silent> <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
     \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
     \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
     \ . ">"<CR>

" set text wrapping toggles
nmap <silent> ,w :set invwrap<CR>:set wrap?<CR>

" Run the command that was just yanked
nmap <silent> ,rc :@"<cr>

" allow command line editing like emacs
cnoremap <C-A>      <Home>
cnoremap <C-B>      <Left>
cnoremap <C-E>      <End>
cnoremap <C-F>      <Right>
cnoremap <C-N>      <End>
cnoremap <C-P>      <Up>
cnoremap <ESC>b     <S-Left>
cnoremap <ESC><C-B> <S-Left>
cnoremap <ESC>f     <S-Right>
cnoremap <ESC><C-F> <S-Right>
cnoremap <ESC><C-H> <C-W>

" Maps to make handling windows a bit easier
noremap <silent> ,h :wincmd h<CR>
noremap <silent> ,j :wincmd j<CR>
noremap <silent> ,k :wincmd k<CR>
noremap <silent> ,l :wincmd l<CR>
noremap <silent> ,sb :wincmd p<CR>
noremap <silent> <C-F9>  :vertical resize -10<CR>
noremap <silent> <C-F10> :resize +10<CR>
noremap <silent> <C-F11> :resize -10<CR>
noremap <silent> <C-F12> :vertical resize +10<CR>
noremap <silent> ,s8 :vertical resize 83<CR>
noremap <silent> ,cj :wincmd j<CR>:close<CR>
noremap <silent> ,ck :wincmd k<CR>:close<CR>
noremap <silent> ,ch :wincmd h<CR>:close<CR>
noremap <silent> ,cl :wincmd l<CR>:close<CR>
noremap <silent> ,cc :close<CR>
noremap <silent> ,cw :cclose<CR>
noremap <silent> ,ml <C-W>L
noremap <silent> ,mk <C-W>K
noremap <silent> ,mh <C-W>H
noremap <silent> ,mj <C-W>J
noremap <silent> <C-7> <C-W>>
noremap <silent> <C-8> <C-W>+
noremap <silent> <C-9> <C-W>+
noremap <silent> <C-0> <C-W>>

" Map CTRL-E to do what ',' used to do
nnoremap <c-e> ,
vnoremap <c-e> ,

" Buffer commands
"noremap <silent> ,bd :bd<CR>

" Edit the vimrc file
nmap <silent> ,ev :e $HOME/.vimrc<CR>
nmap <silent> ,sv :so $HOME/.vimrc<CR>
nmap <silent> ,eb :e $HOME/.bashrc<CR>

" Make horizontal scrolling easier
nmap <silent> <C-o> 10zl
nmap <silent> <C-i> 10zh

" Highlight all instances of the current word under the cursor
nmap <silent> ^ :setl hls<CR>:let @/="<C-r><C-w>"<CR>

" Search the current file for what's currently in the search
" register and display matches
nmap <silent> ,gs
     \ :vimgrep /<C-r>// %<CR>:ccl<CR>:cwin<CR><C-W>J:set nohls<CR>

" Search the current file for the word under the cursor and display matches
nmap <silent> ,gw
     \ :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:set nohls<CR>

" Search the current file for the WORD under the cursor and display matches
nmap <silent> ,gW
     \ :vimgrep /<C-r><C-a>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:set nohls<CR>

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" Underline the current line with '='
nmap <silent> ,ul :t.\|s/./=/g\|set nohls<cr>

" Delete all buffers
nmap <silent> ,da :exec "1," . bufnr('$') . "bd"<cr>

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048

" I don't like it when the matching parens are automatically highlighted
let loaded_matchparen = 1

"-----------------------------------------------------------------------------
" MiniBufExplorer Plugin Settings
"-----------------------------------------------------------------------------
" Yup, I don't like this one either
let loaded_minibufexplorer = 1

"-----------------------------------------------------------------------------
" ShowMarks Plugin Stuff
"-----------------------------------------------------------------------------
" I don't think I like this
let g:loaded_showmarks = 1

"-----------------------------------------------------------------------------
" Source Explorer Plugin Settings
"-----------------------------------------------------------------------------
" The switch of the Source Explorer
nmap <silent> <F8> :SrcExplToggle<CR>

" Set the height of Source Explorer window
let g:SrcExpl_winHeight = 16

" Set 10 ms for refreshing the Source Explorer
let g:SrcExpl_refreshTime = 10

" In order to Avoid conflicts, the Source Explorer should know what plugins
" are using buffers. And you need add their bufname into the list below
" according to the command ":buffers!"
let g:SrcExpl_pluginList = [
            \ "_NERD_tree_",
            \ "Source_Explorer"
            \ ]
" Enable/Disable the local definition searching, and note that this is not
" guaranteed to work, the Source Explorer doesn't check the syntax for now.
" It only searches for a match with the keyword according to command 'gd'
let g:SrcExpl_searchLocalDef = 1

" Do not let the Source Explorer update the tags file when opening
let g:SrcExpl_isUpdateTags = 0

" Use program 'ctags' with argument '--sort=foldcase -R' to create or
" update a tags file
let g:SrcExpl_updateTagsCmd = "retag.ksh"

" Set "<F9>" key for updating the tags file artificially
let g:SrcExpl_updateTagsKey = "<F9>" 

"-----------------------------------------------------------------------------
" NERD Tree Plugin Settings
"-----------------------------------------------------------------------------
" Toggle the NERD Tree on an off with F7
nmap <F7> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F7
nmap <S-F7> :NERDTreeClose<CR>

" Store the bookmarks file in perforce
let NERDTreeBookmarksFile="~/.vim/NERDTreeBookmarks"

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.ncb$', '\.suo$', '\.vcproj\.RIMNET', '\.obj$',
            \ '\.ilk$', '^BuildLog.htm$', '\.pdb$', '\.idb$',
            \ '\.embed\.manifest$', '\.embed\.manifest.res$',
            \ '\.intermediate\.manifest$', '^mt.dep$' ]

"-----------------------------------------------------------------------------
" FSwitch Settings
"-----------------------------------------------------------------------------
nmap <silent> ,of :FSHere<CR>
nmap <silent> ,ol :FSRight<CR>
nmap <silent> ,oL :FSSplitRight<CR>
nmap <silent> ,oh :FSLeft<CR>
nmap <silent> ,oH :FSSplitLeft<CR>
nmap <silent> ,ok :FSAbove<CR>
nmap <silent> ,oK :FSSplitAbove<CR>
nmap <silent> ,oj :FSBelow<CR>
nmap <silent> ,oJ :FSSplitBelow<CR>

"-----------------------------------------------------------------------------
" SnipMate Settings
"-----------------------------------------------------------------------------
"source ~/.vim/snippets/support_functions.vim
"source ~/.vim/snippets/support_functions_derek.vim

function! ListKnownSnippetLanguageTypes(A, L, P)
    let filesanddirs = split(globpath(g:snippets_dir, a:A . "*"), "\n")
    let dirsonly = []
    for f in filesanddirs
        if isdirectory(f)
            let each = split(f, '/')
            let dirsonly = add(dirsonly, each[-1])
        end
    endfor
    return dirsonly
endfunction

function! ReloadSnippets(type)
    call ResetSnippets()
    if a:type != ""
        call ExtractSnips(g:snippets_dir . a:type, a:type)
    else
        let alltypes = ListKnownSnippetLanguageTypes("", "", "")
        for type in alltypes
            call ExtractSnips(g:snippets_dir . type, type)
        endfor
    endif
endfunction

command! -complete=customlist,ListKnownSnippetLanguageTypes
         \ -nargs=? RS call ReloadSnippets("<args>")

"-----------------------------------------------------------------------------
" FuzzyFinder Settings
"-----------------------------------------------------------------------------
nmap ,fb :FuzzyFinderBuffer<CR>
nmap ,ff :FuzzyFinderFile<CR>
nmap ,ft :FuzzyFinderTag<CR>

"-----------------------------------------------------------------------------
" UltiSnips Settings
"-----------------------------------------------------------------------------
set runtimepath+=~/.vim/ultisnips
let g:UltiSnipsExpandTrigger="<c-9>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"-----------------------------------------------------------------------------
" Functions
"-----------------------------------------------------------------------------

function! RunSystemCall(systemcall)
    let output = system(a:systemcall)
    let output = substitute(output, "\n", '', 'g')
    return output
endfunction

"-----------------------------------------------------------------------------
" Auto commands
"-----------------------------------------------------------------------------
augroup derek_scons
    au!
    au BufNewFile,BufRead SCons* setf scons
augroup END

augroup derek_xsd
    au!
    au BufEnter *.xsd,*.wsdl,*.xml setl tabstop=4 | setl shiftwidth=4
    au BufEnter *.xsd,*.wsdl,*.xml setl formatoptions=crq | setl textwidth=80
augroup END

augroup Binary
    au!
    au BufReadPre   *.bin let &bin=1
    au BufReadPost  *.bin if &bin | %!xxd
    au BufReadPost  *.bin set filetype=xxd | endif
    au BufWritePre  *.bin if &bin | %!xxd -r
    au BufWritePre  *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
augroup END

"-----------------------------------------------------------------------------
" Fix constant spelling mistakes
"-----------------------------------------------------------------------------

iab teh       the
iab Teh       The
iab taht      that
iab Taht      That
iab alos      also
iab Alos      Also
iab aslo      also
iab Aslo      Also
iab becuase   because
iab Becuase   Because
iab bianry    binary
iab Bianry    Binary
iab bianries  binaries
iab Bianries  Binaries
iab charcter  character
iab Charcter  Character
iab charcters characters
iab Charcters Characters
iab exmaple   example
iab Exmaple   Example
iab exmaples  examples
iab Exmaples  Examples
iab shoudl    should
iab Shoudl    Should
iab seperate  separate
iab Seperate  Separate
iab fone      phone
iab Fone      Phone

"-----------------------------------------------------------------------------
" Set up the window colors and size
"-----------------------------------------------------------------------------

if has("gui_running")
    set guifont=Inconsolata:h12
    "set guifont=Deja Vu Sans Condensed:h11
    if !exists("g:vimrcloaded")
        if ! &diff
            winsize 187 62 
        else
            winsize 187 62
        endif
        let g:vimrcloaded = 1
    endif
endif
:nohls

"-----------------------------------------------------------------------------
" Idearat Tweaks
"-----------------------------------------------------------------------------

" Folding
"set foldmethod=indent
set foldminlines=5

" Spelling
cab ehlp    help
cab hepl    help
cab hlp     help
cab hep     help

" Coloring
let color="true"
colorscheme ss 

nmap <leader>ec :e $HOME/.vim/colors/ss.vim<CR>

" Tabstops
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab nolist
"set tabstop=4 softtabstop=4 shiftwidth=4 expandtab list
"set tabstop=2 softtabstop=2 shiftwidth=2 expandtab list
"set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab nolist

nmap <leader>l :set list!<CR>

autocmd BufNewFile,BufRead *.json set ft=javascript

set virtualedit=insert

set history=100		" keep 100 lines of command line history
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set showmatch		" highlight matching elements on navigation
set incsearch		" do incremental searching
set wrapscan		" wrap around file end when searching
set ignorecase		" case-insensitive searching
set smartcase		" drive case search by the search string
set shellslash		" don't use backslashes...ever
set ch=2			" command-line 2 lines high

set path+=/usr/local/src/TIBET/**
set path+=/usr/local/src/teamtibet/**
set path+=/usr/local/src/claremont/**

set diffopt-=iwhite

set synmaxcol=1024
set wrapmargin=2

" Search google for what's under the visual mode selection.
"vmap ,g "zy:let @z=substitute(substitute(@z,"\\W\\+\\\\|\\<\\w\\>","+","g") ,"[[:space:]]","+","g")<CR>:!open "http://www.google.com/search?q="<C-R>z<CR><CR>:redraw<CR>

nmap <D-S-Left> :tabp<CR>
nmap <D-S-Right> :tabn<CR>

"=============================================================================
