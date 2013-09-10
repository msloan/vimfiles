1. git clone git://github.com/msloan/vimfiles.git ~/vimfiles

2. Create symlinks:

    OSX
    ln -s ~/vimfiles/ ~/.vim

    WINDOWS
    mklink -H .vimrc .\vimfiles\vimrc

3. git clone git://github.com/gmarik/vundle ~/vimfiles/bundle

3. Run :BundleInstall in vim.
