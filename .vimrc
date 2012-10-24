" setup pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

colorscheme wombat
syntax on
set autochdir
set noexpandtab
set cursorline
set incsearch
set listchars=tab:>-,trail:-
set nostartofline
set number
set ruler
set scrolloff=10
set showcmd
set sidescrolloff=10
set ignorecase
set smartcase
set shiftwidth=4
set lines=999
set mouse=a
set guioptions=ce
set guifont=Consolas:h11
set columns=999
set nohls
set clipboard+=unnamed
set autoindent
set nosmartindent
set cindent
set hidden
set backspace=indent,eol,start
set tabstop=4
set comments=f://
set ignorecase smartcase
set formatoptions=crql

" dont indent public:
set cino=g0,f
"autocmd BufEnter * lcd %:p:h

hi Cursor guibg=red 
hi Cursor guifg=white 
" no cursor blinking
set guicursor=a:blinkon0


" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
set nocp
filetype plugin on
nnoremap <C-j> :put='' <CR>
let g:netrw_altv = 1
let g:netrw_winsize = 50 
let g:netrw_keepdir = 0

set foldmethod=syntax
set foldlevel=999
set foldminlines=5

autocmd BufWrite * :if &readonly | silent !start p4 edit %
set autoread

" Treat pw script files as c files
au BufNewFile,BufRead *.scr set filetype=c

"""""""""""""""""""""""""""""""""""""""""""""
" Setup relative line mapping
fun! SetRNU()
    if &ft =~ 'nerdtree'
        return
    endif
	" Relative line number mapping
	set rnu
endfun

fun! SetNU()
    if &ft =~ 'nerdtree'
        return
    endif
	" Relative line number mapping
	set nu
endfun

au FocusLost * call SetNU()
au FocusGained * call SetRNU()
au WinLeave * call SetNU()
au WinEnter * call SetRNU()
au CmdwinEnter * call SetNU()
au CmdwinLeave * call SetRNU()

" for entering/exiting command-line
nnoremap : :set nu<Enter>:
cnoremap <Esc> set rnu<Enter>
"""""""""""""""""""""""""""""""""""""""""""""


" Esc gets rid of search highlighting
nnoremap <Esc> :noh<Enter>

" Don't switch working directories when opening files
set noautochdir

" ////////////////////////////////////////////
" 				NERDTree
" ////////////////////////////////////////////
:command! -nargs=* Ex NERDTree <args>

" close vim if only window left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let NERDTreeMininmalUI=1
let NERDTreeShowBookmarks=1
let NERDChristmasTree=0
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.meta', '\.swp', '\.unity', 'cubeGen$[[dir]]', 'effects$[[dir]]', 'Objects$[[dir]]', 'scene$[[dir]]', 'Standard Assets$[[dir]]', 'StrumpyShaderEditor$[[dir]]', 'Audio$[[dir]]', 'Characters$[[dir]]', 'temp$[[dir]]', 'Movies$[[dir]]','Data$[[dir]]', 'Resources$[[dir]]']

autocmd FileType nerdtree setlocal norelativenumber
" ////////////////////////////////////////////

" ////////////////////////////////////////////
" 				AsyncCommand
" ////////////////////////////////////////////
:command! -nargs=* Ac AsyncCommand <args>
nnoremap <F12> >:Ac cmd<Enter>

:command! -nargs=* As AsyncShell <args>
nnoremap <F12> >:As cmd<Enter>

command! -nargs=+ -complete=file Af call s:AsyncFindstr(<q-args>)

function! s:AsyncFindstr(query)
    let grep_cmd = "findstr /nsi ".a:query
    call asynccommand#run(grep_cmd, asynchandler#quickfix(&grepformat, '[Found: %s] findstr ' . a:query))
endfunction
" ////////////////////////////////////////////
