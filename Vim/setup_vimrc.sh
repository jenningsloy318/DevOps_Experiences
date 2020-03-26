#!/bin/bash
#apt-get install libpthread-stubs0-dev  clang-3.5 cmake git curl
#install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
# install delimitMate 
[ -d ~/.vim/bundle/delimitMate  ] && (cd ~/.vim/bundle/delimitMate&&git pull) || git clone https://github.com/vim-scripts/delimitMate.vim.git  ~/.vim/bundle/delimitMate
#install pydiction
[ -d ~/.vim/bundle/pydiction ] && (cd ~/.vim/bundle/pydiction&&git pull) || git clone https://github.com/rkulla/pydiction.git  ~/.vim/bundle/pydiction
#ultisnips vim-snippets
[ -d ~/.vim/bundle/ultisnips ] && (cd ~/.vim/bundle/ultisnips &&git pull) ||git clone https://github.com/SirVer/ultisnips.git  ~/.vim/bundle/ultisnips
[ -d ~/.vim/bundle/vim-snippets ]&&( cd ~/.vim/bundle/vim-snippets&&git pull) || git clone https://github.com/honza/vim-snippets.git ~/.vim/bundle/vim-snippets
#install vim-colors-solarized
[ -d ~/.vim/bundle/vim-colors-solarized ] && (cd  ~/.vim/bundle/vim-colors-solarized&&git pull) ||git clone https://github.com/altercation/vim-colors-solarized.git  ~/.vim/bundle/vim-colors-solarized
#install vim-indent-guides
[ -d ~/.vim/bundle/vim-indent-guides ] && (cd ~/.vim/bundle/vim-indent-guides &&git pull) || git clone git://github.com/nathanaelkane/vim-indent-guides.git  ~/.vim/bundle/vim-indent-guides
#install YouCompleteMe
[ -d ~/.vim/bundle/YouCompleteMe ] && (cd ~/.vim/bundle/YouCompleteMe && git pull) || git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe && git submodule update --init --recursive  &&  sed -i '/\/usr\/bin\/env/s/python$/python3/' install.py && apt install python3 python3-dev gcc make cmake clang -y
#ln -s /usr/lib/{lvm-version}/lib/libclang.so.1 /usr/lib/{llvm-version}/lib/libclang.so
./install.py --clang-completer --system-libclang

# install vim-cpp-enhanced-highlight:additional vim c++ syntax highlighting
[ -d ~/.vim/bundle/syntax/vim-cpp-enhanced-highlight ] &&( cd  ~/.vim/bundle/syntax/vim-cpp-enhanced-highlight &&git pull) || (mkdir -p ~/.vim/bundle/syntax &&  git clone  https://github.com/octol/vim-cpp-enhanced-highlight.git  ~/.vim/bundle/syntax/vim-cpp-enhanced-highlight)

# install vim-surround
[ -d ~/.vim/bundle/vim-surround ]  && (cd ~/.vim/bundle/vim-surround&&git pull) ||  git clone git://github.com/tpope/vim-surround.git ~/.vim/bundle/vim-surround


# install  vim-bracketed-paste
[ -d  ~/.vim/bundle/vim-bracketed-paste  ] && (cd  ~/.vim/bundle/vim-bracketed-paste && git pull ) || git clone https://github.com/ConradIrwin/vim-bracketed-paste  ~/.vim/bundle/vim-bracketed-paste
