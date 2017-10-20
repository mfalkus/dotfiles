#!/bin/bash

dir=`pwd`
# list of files/folders to symlink in homedir
# note, don't copy .gitconfig by default
files=".bashrc .screenrc .vimrc .ctags .tmux.conf .gitignore_everywhere"
cp_files=".gitconfig"

# change to the dotfiles directory
cd ~

for file in $files; do
    if [ -e ~/$file ]; then
        unlink ~/$file && echo "Unlinked $file"
    fi
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file
done

for file in $cp_files; do
    echo "Copying $file"
    if [ -f ~/$file ];
        then
            CUR_TIME=$(date +'%s') && \
            NEW_FILE=$file".previous-"$CUR_TIME && \
            cp ~/$file ~/$NEW_FILE && \
            echo "Current .gitconfig copied to $NEW_FILE";
    fi
    cp $dir/$file ~/$file
done
