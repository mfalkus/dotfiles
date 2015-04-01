#!/bin/bash

dir=`pwd`
# list of files/folders to symlink in homedir
# note, don't copy .gitconfig by default
files=".bashrc .screenrc .vimrc .ctags .tmux.conf"
cp_files=".gitconfig"

# change to the dotfiles directory
cd ~

for file in $files; do
    echo "Unlinking $file"
    unlink ~/$file
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file
done

for file in $cp_files; do
    echo "Copying $file (+ making backup if required)"
    cp -b $dir/$file ~/$file
done
