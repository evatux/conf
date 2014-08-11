""""""""""""""""""""""""
" => General
""""""""""""""""""""""""
syntax on
setglobal fileencodings=utf8
set history=700

" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on

set autochdir   " follow file
set autoread    " auto update
set bs=2        " backspaces ???
set ts=4        " tab stop
set sw=4        " shift width???
set expandtab
set ruler
set mouse=a
set nowrap      " no text wrap

set autoindent  " auto formating
set cindent     " auto formating
set smartindent " auto formating

set foldmethod=syntax

" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */


""""""""""""""""""""""""
" => Vim Interface
""""""""""""""""""""""""
colorscheme h80_my

set showmatch   " highlight matching braces
set hlsearch    " highlight search results

" highlight after 80 symbol
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermfg=red ctermbg=black
"set colorcolumn=80

" highlight trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

" highlight TABS
highlight AllTab ctermbg=blue guifg=blue guibg=red
match AllTab /\t/
autocmd BufWinEnter * match AllTab /\t/
autocmd InsertLeave * match AllTab /\t/

" Status line
set laststatus=2
set statusline=%f%m%r\ %=c:%2c\ l:%2l/%L\ [%2p%%]


""""""""""""""""""""""""
" => Misc
""""""""""""""""""""""""

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" let's try to do cross-vim buffer exchange
vmap <silent> ,y y:new<CR>:call setline(1,getregtype())<CR>o<Esc>P:wq! ~/.vim/clipboard.txt<CR>
nmap <silent> ,y :new<CR>:call setline(1,getregtype())<CR>o<Esc>P:wq! ~/.vim/clipboard.txt<CR>
map <silent> ,p :sview ~/.vim/clipboard.txt<CR>"zdddG:q!<CR>:call setreg('"', @", @z)<CR>p
map <silent> ,P :sview ~/.vim/clipboard.txt<CR>"zdddG:q!<CR>:call setreg('"', @", @z)<CR>P

" F2 for saving changes
imap <F2> <Esc>:w<CR>
map  <F2> <Esc>:w<CR>

" tabs
map <Esc>1 1gt
map <Esc>2 2gt
map <Esc>3 3gt
map <Esc>4 4gt
map <Esc>5 5gt
map <Esc>6 6gt
map <Esc>7 7gt
map <Esc>8 8gt
map <Esc>9 9gt
map <Esc>0 :tablast<CR>
map <Esc>t :tabnew<CR>
map <Esc>w :tabclose<CR>

set tabline=%!MyTabLine()
function MyTabLine()
  let s = '        ' " complete tabline goes here
  " loop through each tab page
  for t in range(tabpagenr('$'))
    " select the highlighting for the buffer names
    if t + 1 == tabpagenr()
      let s .= '%#TabLine#'
    else
      let s .= '%#TabLineSel#'
    endif
    " empty space
    let s .= ' '
    " set the tab page number (for mouse clicks)
    let s .= '%' . (t + 1) . 'T'
    " set page number string
    let s .= t + 1 . ' '
    " get buffer names and statuses
    let n = ''  "temp string for buffer names while we loop and check buftype
    let m = 0 " &modified counter
    let wn = '' " windows number (x)
    let bc = len(tabpagebuflist(t + 1))  "counter to avoid last ' '
    " loop through each buffer in a tab
    for b in tabpagebuflist(t + 1)
      " buffer types: quickfix gets a [Q], help gets [H]{base fname}
      " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
      if getbufvar( b, "&buftype" ) == 'help'
        let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
      elseif getbufvar( b, "&buftype" ) == 'quickfix'
        let n .= '[Q]'
      else
        let n .= pathshorten(bufname(b))
        "let n .= bufname(b)
      endif
      " check and ++ tab's &modified count
      if getbufvar( b, "&modified" )
        let m += 1
      endif
      " no final ' ' added...formatting looks better done later
      if bc > 1
        let n .= ' '
      endif
      let bc -= 1
    endfor
    " add modified label [n+] where n pages in tab are modified
    if m > 0
      let s .= '[' . m . '+] '
      "let s.= '[+]'
    endif
    " add buffer names
    if n == ''
      let s .= '[No Name]'
    else
      let win_number = tabpagewinnr(t+1, '$')
      if win_number > 1
          let wn = '(' . win_number . ')'
      endif
      let cur_win    = tabpagewinnr(t+1)
      let buflist    = tabpagebuflist(t+1)
      let cur_buf    = buflist[cur_win-1]
      let s         .= pathshorten(bufname(cur_buf))
      let s         .= ' ' . wn
"      let s .= n
    endif
    " switch to no underlining and add final space to buffer list
    "let s .= '%#TabLineSel#' . '  '
    let s .= '  '
  endfor
  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'
  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999XX'
  endif
  return s
endfunction


""""""""""""""""""""""""
" => Uknown part
""""""""""""""""""""""""

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
