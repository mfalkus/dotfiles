#!/bin/bash

dir=`pwd`
# list of files/folders to symlink in homedir
files=".bashrc .vimrc .ctags .gitconfig .tmux.conf"

# change to the dotfiles directory
cd ~

for file in $files; do
    echo "Unlinking $file"
    unlink ~/$file
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file
done
