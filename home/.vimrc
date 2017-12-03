execute pathogen#infect()

set nocompatible      " Use vim, no vi defaults
set number            " Show line numbers
set ruler             " Show line and column number
syntax enable         " Turn on syntax highlighting allowing local overrides
set encoding=utf-8    " Set default encoding to UTF-8
set showmatch         " show matching bracket on insert (if it exists)
set ttimeout
set ttimeoutlen=50
set showcmd
set wildmenu
set display+=lastline
set autoread
set autowrite
set visualbell        " no more beeps

" Make Y consistent with C and D.  See :help Y.
nnoremap Y y$

""
"" Whitespace
""

set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set shiftround                    " round to multiple of shiftwidth
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode
set autoindent                    " autoindent to same level as previous line

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots

""
"" Searching
""

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

""
"" Wild settings
""

" TODO: Investigate the precise meaning of these settings
" set wildmode=list:longest,list:full

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore sass cache
set wildignore+=*/vendor/cache/*,*/.sass-cache/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

" Ignore tag files
set wildignore+=tags

" Ignore image files
 set wildignore+=*.png,*.jpg,*.jpeg,*.gif

""
"" Per project settings
""

" enable per-project .vimrc files
 set exrc
" Only execute safe per-project vimrc commands
set secure

""
"" Backup and swap files
""

set backupdir=~/.vim/_backup//    " where to put backup files.
set directory=~/.vim/_temp//      " where to put swap files.


""
"" Helpers
""

" Some file types should wrap their text
function! s:setupWrapping()
  set wrap
  set linebreak
  set textwidth=72
  set nolist
endfunction

""
"" File types
""

" In Makefiles, use real tabs, not tabs expanded to spaces
au FileType make setlocal noexpandtab

" Set the Ruby filetype for a number of common Ruby files without .rb
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,Vagrantfile,Thorfile,Procfile,config.ru,*.rake,*.thor} set ft=ruby

" Make sure all markdown files have the correct filetype set and setup wrapping
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} set ft=markdown | call s:setupWrapping()

" Treat JSON files like JavaScript
au BufNewFile,BufRead *.json set ft=javascript

" make Python follow PEP8 for whitespace ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4

" make PHP folllow standard 4 spaces for tabs
au FileType php setlocal softtabstop=4 tabstop=4 shiftwidth=4

" use spellchecker for markdown and commit messages
au FileType gitcommit setlocal spell spelllang=en_gb
au FileType markdown setlocal spell spelllang=en_gb


" Remember last location in file, but not for commit messages.
" see :help last-position-jump
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g`\"" | endif


let mapleader = ","

" Use extra symbols for PowerLine pagech fonts in airline
let g:airline_powerline_fonts = 1

set laststatus=2  " always show the status bar

" Ctrl-P plugin
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\',
  \ }

let g:ctrlp_dotfiles = 1

color vibrantink

highlight ColorColumn ctermbg=233 guibg=#121212
let &colorcolumn=join(range(81,999),",")
let &colorcolumn="80,".join(range(120,999),",")

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
set sidescrolloff=5

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

" Stop it taking such a long time to appear leave insert mode, see
" http://www.johnhawthorn.com/2012/09/vi-escape-delays/ for more info
set timeoutlen=1000 ttimeoutlen=0

" Alternative switching modes
"
" On Linux - press Shift-Space to toggle normal/insert mode
:imap <S-Space> <Esc>
:nmap <S-Space> i
" On OSX - press Alt-Space to toggler normal/insert mode
:imap <M-Space> <Esc>`^
:nmap <M-Space> i

" Cycle through buffers with Tab/Shift-Tab
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>


" Settings for vim-commentary
autocmd FileType ruby set commentstring=#\ %s
autocmd FileType sh set commentstring=#\ %s
