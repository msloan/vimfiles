"undle
set nocompatible
filetype off                   
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'AndrewRadev/linediff.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'SirVer/ultisnips'
Bundle 'Valloric/YouCompleteMe'
Bundle 'corntrace/bufexplorer'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'shemerey/vim-project'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/BufOnly.vim'
Bundle 'vim-scripts/mru.vim'
"end vundle

filetype plugin indent on

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

" fugitive status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

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

" Use markdown syntax in html files for use with strapdown.js
au BufNewFile,BufRead *.html set syntax=markdown

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
	:sil g/^\s*$/d
	:sil g/WriteWindowsDebugString called and HOST/d
	:sil g/(Filename/d
	:sil g/CrossTitleContent - UpdateFHP/d
	:sil g/GuiAnimClickLink/d
	:sil g/<Sentient Internal/d
	:sil g/: Error code 0x0: S_OK/d
	:sil g/TRC/d
	:sil g/Linked statically/d
	:sil g/Playing animation/d
	:sil g/AiEngine_MakePlayStyle/d
	:sil g/Unloading . unused Assets/d
	:sil g/System memory in use before/d
	:sil g/New submit key/d
	:sil g/^Authorization:/d
	:sil g/Unused Serialized files (/d
	:sil g/Unloading \w\+ unused Assets to/d
	:sil g/System memory in use after/d
	:sil g/sending \S\+ bytes from/d
	:sil g/received \S\+ bytes from/d
	:sil g/sending \S\+ bytes to/d
	:sil g/received \S\+ bytes to/d
	:sil g/The referenced script on this/d
	:sil g/FindLiveObjects: /d
 endfunction
:command! CleanUnityLog call CleanUnityLog()
:au BufNewFile,BufRead *unitylog.txt call CleanUnityLog()

" put current line number in buffer
nnoremap ,n <Esc>:let @*=line(".")<CR>

"grep files in directory that are not ignored
:command! -nargs=* Gr silent Ggrep --exclude-standard --no-index <args>

" Open quick fix window after grep
autocmd QuickFixCmdPost *grep* cwindow

" cycle quick fix
nnoremap <F8> :cn<CR>
nnoremap <S-F8> :cp<CR>

" grep word under cursor
nnoremap <C-]> :Ggrep --exclude-standard --no-index <C-r><C-w><CR>

au BufNewFile,BufRead *.py setlocal expandtab

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
let g:proj_flags="istvcg"

let g:UltiSnipsSnippetDirectories=["snippets","UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"


" re-source vimrc
:command! So so $MYVIMRC

" TODO: 
" YCM
" Search and replace with Ggrep
" Script to update project.vim list or delete project.vim
" c# folding
" UltiSnip: should have an option to configure if list is brought up when duplicate snippets are detected
" Need cmd for - git commit everything and create new branch to work on try something else

