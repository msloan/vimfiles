"vundle
set nocompatible
filetype off                   
set rtp+=~/vimfiles/bundle/vundle
let path='~/vimfiles/bundle'
call vundle#rc(path)
Bundle 'gmarik/vundle'
Bundle 'SirVer/ultisnips'
"end vundle

filetype plugin indent on
