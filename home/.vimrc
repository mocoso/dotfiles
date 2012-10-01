call pathogen#infect()

let mapleader = ","

" Powerline plugin
let g:Powerline_symbols = 'fancy'

set laststatus=2  " always show the status bar

" Ctrl-P plugin
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\',
  \ }



color vibrantink

set colorcolumn=81

if has('mac')
  set clipboard=unnamed
endif

" Change the cursor to a vertical bar for insert mode
" see http://code.google.com/p/iterm2/wiki/ProprietaryEscapeCodes for more
" details
"
" Note: tmux will only forward escape sequences to the terminal if surrounded by
" a DCS sequence
" http://sourceforge.net/mailarchive/forum.php?thread_name=AANLkTinkbdoZ8eNR1X2UobLTeww1jFrvfJxTMfKSq-L%2B%40mail.gmail.com&forum_name=tmux-users

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

set scrolloff=3

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" Making it so ; works like : for commands.
nnoremap ; :

" Highlight current line
set cursorline

" Underline highlighted terms to make the highlight less jarring
highlight Search ctermfg=white ctermbg=black cterm=underline

