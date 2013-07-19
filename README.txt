Installation:

    git clone git://github.com/msloan/vimfiles.git ~/vimfiles

Create symlinks:

    OSX
    ln -s ~/vimfiles/vimrc ~/.vimrc
    ln -s ~/vimfiles/gvimrc ~/.gvimrc

    WINDOWS
    mklink -H .vimrc .\vimfiles\vimrc

Switch to the `~/vimfiles` directory, and fetch submodules:

    cd ~/vimfiles
    git submodule init
    git submodule update
