syntax on
setglobal fileencodings=utf8
set history=700
filetype on
filetype plugin on
filetype indent on
set autoread
set bs=2 " backspaces ???
set ts=4 " tab stop
set sw=4 " shift width???
set expandtab
set ruler
set mouse=a

set nowrap
" no text wrap

" auto formating
set autoindent
set cindent
set smartindent

" highlight matching braces
set showmatch

" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" Omni
set tags+=~/.vim/tags/cpp
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1		" autocomplete after .
let OmniCpp_MayCompleteArrow = 1	" autocomplete after ->
let OmniCpp_MayCompleteScope = 1	" autocomplete after ::
let OmniCpp_DefaultNamespace = ["std", "_GLIBCXX_STD"]
" let OmniCpp_SelectFirstSearch = 2 " select first item (but don't insert)

set ofu=syntaxcomplete#Complete
set completeopt=menuone,menu,longest,preview

colorscheme h80

set ignorecase
set hlsearch

set foldmethod=syntax

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
"vnoremap <silent> * :call VisualSelection('f')<CR>
"vnoremap <silent> # :call VisualSelection('b')<CR>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

if has("gui_running")
    " C-Space seems to work under gVim on both Linux and win32
    inoremap <C-Space> <C-n>
else " no gui
  if has("unix")
    inoremap <Nul> <C-n>
  else
  " I have no idea of the name of Ctrl-Space elsewhere
  endif
endif

