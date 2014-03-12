1. git clone --recursive git://github.com/msloan/vimfiles.git ~/vimfiles

2. Create symlinks:

    OSX
    ln -s ~/vimfiles/ ~/.vim

    WINDOWS
    mklink /H _vimrc .\vimfiles\vimrc

3. Make sure the path to bundles is set correctly in vimrc.

4. Run :BundleInstall in vim.
