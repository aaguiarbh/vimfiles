"---------------------------------------------------------------------
" from Guido
" vimrc file for following the coding standards specified in PEP 8
"---------------------------------------------------------------------

" Number of spaces to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python: 4 spaces
" C: 8 spaces (pre-existing files) or 4 spaces (new files)
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead *.c,*.h set shiftwidth=8
au BufNewFile *.c,*.h set shiftwidth=4

" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.
" Python: 4
" C: 4
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4

" Replace tabs with the equivalent number of spaces.
" Also have an autocmd for Makefiles since they require hard tabs.
" Python: yes
" C: no
" Makefile: no
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.c,*.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab

" Use the below highlight group when displaying bad whitespace is desired
" highlight BadWhitespace ctermbg=red guisp=red gui=undercurl guifg=NONE guibg=NONE

" Display tabs at the beginning of a line in Python mode as bad.
" au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
" Python: 120
" C: 120
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=120

" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" Python: not needed
" C: prevents insertion of '*' at the beginning of every line in a comment
au BufRead,BufNewFile *.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r

" Use UNIX (\n) line endings.
" Only used for new files so as to not force existing files to change their
" line endings.
" Python: yes
" C: yes
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

" The following section contains suggested settings.  While in no way required
" to meet coding standards, they are helpful.

" Set the default file encoding to UTF-8: 
set encoding=utf-8

" Puts a marker at the beginning of the file to differentiate between UTF and
" UCS encoding (WARNING: can trick shells into thinking a text file is actually
" a binary file when executing the text file): ``set bomb``

" For full syntax highlighting:
let python_highlight_all=1
set syntax=on
filetype on

" Automatically indent based on file type: 
filetype indent on

" Automaticaly enuble plugin by file type:
filetype plugin on

" Keep indentation level from previous line: 
set autoindent

" Disable read-only protection
set modifiable

"---------------------------------------------------------------------
" Python IDE relatd staff
"---------------------------------------------------------------------

" highlight variable under cursor (not smart)
" Python: yes
" C: yes

au BufRead,BufNewFile *.py,*.pyw,*.c  autocmd CursorMoved * silent! exe printf('match IncSearch /\<%s\>/', expand('<cword>'))

" Folding based on indentation:
" set foldmethod=indent

"---------------------------------------------------------------------
" File formats support 
"---------------------------------------------------------------------

" Json
au! BufRead,BufNewFile *.json setfiletype json 

"---------------------------------------------------------------------
" gVim - related staff
"---------------------------------------------------------------------
syntax enable
set guifont=Liberation\ Mono\ 10
set term=gnome-256color
set background=dark
colorscheme railscasts

"---------------------------------------------------------------------
" Common settings
"---------------------------------------------------------------------
set nocompatible 
set ruler

" Show full tags when doing search completion
set showfulltag

" Speed up macros
set lazyredraw

" Include $HOME in cdpath
let &cdpath=','.expand("$HOME")

" Disable backup files
set noswapfile
set nobackup

" Set mouse mod
set mouse=a
set mousemodel=popup

" Try to show at least three lines and two columns of context when
" scrolling
set scrolloff=3
set sidescrolloff=2

" Allow edit buffers to be hidden
set hidden
" 1 height windows
set winminheight=1

" Wrap on these
set whichwrap+=<,>,[,]

" Use the cool tab complete menu
set wildmenu
set wildignore=*.o,*~

" If possible, try to use a narrow number column.
setlocal numberwidth=4

set fillchars=fold:-

"---------------------------------------------------------------------
" completion
"---------------------------------------------------------------------

"by tags
set dictionary=/usr/share/dict/words
let g:showfuncctagsbin = "/usr/bin/ctags"

" by pydict
let g:pydiction_location = '~/.vim/after/ftplugin/pydiction/complete-dict' 

"---------------------------------------------------------------------
" navigation
"---------------------------------------------------------------------

" --------- Split windows

" Easy split window navigation
" use ALT+navigation key to switch split windows
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

" --------- Tab settings 

" Tab change by Alt-Left/Right
nmap <M-Right> gt
nmap <M-Left> gT
imap <M-Right> <C-O>gt
imap <M-Left> <C-O>gT

" Tabbar plugin settings (changa tab by Alt+tab number)
hi Tb_Changed ctermbg=black ctermfg=yellow " Colour of changed tab
hi Tb_VisibleChanged ctermbg=black ctermfg=magenta " Colour of current changed tab



" --------- Disk navigation

" totalcommander, file explorer. Required NERDTree plugin
noremap <silent> <leader>p :NERDTreeToggle<CR>
let NERDTreeWinSize = 25 
let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '\.swp$', '\~$']

"map to bufexplorer
nnoremap <leader>b :BufExplorer<cr>

" --------- Projects
let g:proj_flags = "imstg"

"---------------------------------------------------------------------
" autocmds
"---------------------------------------------------------------------

setlocal foldcolumn=1
set number

" сохранение текущего буфера
imap <F2> <Esc>:w<CR>a
nmap <F2> :w<CR>
 
" сохранение всех буферов
imap <S-F2> <Esc>:wa<CR>a
nmap <S-F2> :wa<CR>


"---------------------------------------------------------------------
" HTML settings
"---------------------------------------------------------------------

" Preview page in firefox using 'Preview' command
command Preview :!firefox %<CR>


"---------------------------------------------------------------------
" Plugins
"---------------------------------------------------------------------

" --------- Rope 

" Add rope complenition
au BufRead,BufNewFile *.py,*pyw let ropevim_vim_completion=1
let rope_vim_completion=1

function! TabWrapperRope()
  if strpart(getline('.'), 0, col('.')-1) =~ '^\s*$'
    return "\<Tab>"
  else
    return "\<C-R>=RopeCodeAssistInsertMode()\<CR>"
  endif
endfunction

au BufRead,BufNewFile *.py,*pyw imap <Tab> <C-R>=TabWrapperRope()<CR>
au BufRead,BufNewFile *.py,*pyw imap <silent><C-Space> <ESC>l:RopeCodeAssist<CR>
au BufRead,BufNewFile *.py,*pyw nmap <silent><C-Space> :RopeCodeAssist<CR>
au BufRead,BufNewFile *.py,*pyw nnoremap <silent>, :call RopeShowDoc()<CR>

" --------- Svndiff
let g:svndiff_autoupdate = 1 

hi DiffAdd      ctermfg=0 ctermbg=2 guibg='green'
hi DiffDelete   ctermfg=0 ctermbg=1 guibg='red'
hi DiffChange   ctermfg=0 ctermbg=3 guibg='yellow'

au BufRead,BufNewFile *.* call Svndiff("next")

" --------- Ctags
nnoremap <silent> <F9> :TlistToggle<CR>
" show list on the rightmost side of the window
let Tlist_Use_Right_Window = 1
" remove empty lines
let Tlist_Compact_Format = 1
" show Tlist menu in gVim
let Tlist_Show_Menu = 1 

" --------- Pylint
autocmd FileType python compiler pylint
" Don't show quickfix window. Manually can be opened by :cope
let g:pylint_cwindow = 0
" Don't show style errors
let g:pylint_conventions = 0
" Check file 'on fly'
let g:pylint_onfly = 0

" --------- Ack
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

"---------------------------------------------------------------------
" Charsets  and locale
"---------------------------------------------------------------------

" Change charset by F8
set wildmenu
 set wcm=<Tab>
 menu Encoding.koi8-r   :e ++enc=koi8-r<CR>
 menu Encoding.windows-1251 :e ++enc=cp1251<CR>
 menu Encoding.ibm-866      :e ++enc=ibm866<CR>
 menu Encoding.utf-8        :e ++enc=utf-8 <CR>
 map <F8> :emenu Encoding.<TAB>

" Fechamento automático de parenteses
imap { {}<left>
imap ( ()<left>
imap [ []<left>
