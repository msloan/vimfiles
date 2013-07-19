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
set formatoptions=cql

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
"nnoremap : :call SetNU()<Enter>:
"cnoremap <Esc> :call SetRNU()<Enter>
"""""""""""""""""""""""""""""""""""""""""""""


" Esc gets rid of search highlighting
nnoremap <silent> <Esc> :noh<Enter>

" Don't switch working directories when opening files
set noautochdir

" NERDTree.vim
:command! -nargs=* Ex NERDTree <args>
let NERDTreeMininmalUI=1
let NERDTreeShowBookmarks=1
let NERDChristmasTree=0
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.meta', '\.swp', '\.exe']
let g:NERDTreeDirArrows=0
autocmd FileType nerdtree setlocal norelativenumber

" Reduces the noise of unity log files
fun! CleanUnityLog()
	:g/^\s*$/d
	:g/WriteWindowsDebugString called and HOST/d
	:g/(Filename/d
	:g/CrossTitleContent - UpdateFHP/d
	:g/GuiAnimClickLink/d
	:g/<Sentient Internal/d
	:g/: Error code 0x0: S_OK/d
	:g/TRC/d
	:g/Linked statically/d
	:g/Playing animation/d
	:g/AiEngine_MakePlayStyle/d
	:g/Unloading . unused Assets/d
	:g/System memory in use before/d
	:g/New submit key/d
	:g/^Authorization:/d
 endfunction
:command! CleanUnityLog call CleanUnityLog()

" put current line number in buffer
nnoremap ,n <Esc>:let @*=line(".")<CR>


au BufNewFile,BufRead *.py setlocal expandtab

" TODO: snippets for comment headers, singletons, comment lines

" linediff.vim
noremap \ldt :Linediff<CR>
noremap \ldo :LinediffReset<CR>
nnoremap gm :call cursor(0, len(getline('.'))/2)<cr>

" Ctrl tab to cycle buffers like in msvs
nnoremap <C-Tab> :bn<CR>

" project.vim
let g:proj_window_width = 40
nnoremap <silent> <Leader>p :Project<CR>
fun! FixupProject()
	" Delete empty folders
	let i = 0
	while i < &fdn
		let i += 1
		:%s/\n.*{\n.*}//
	endwhile
endfunction
:command! FixupProject silent! call FixupProject()
let g:proj_flags="imstvcg"

