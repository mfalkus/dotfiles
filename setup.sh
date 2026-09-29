#!/bin/bash

# 1. Define variables
dir=$(pwd)
files=".bashrc .screenrc .vimrc .ctags .tmux.conf .gitignore_everywhere"
cp_files=".gitconfig"

# 2. Create necessary directories
mkdir -p ~/.vim/plugged
mkdir -p ~/.vim/autoload
mkdir -p ~/.gnupg
chmod 700 ~/.gnupg # GPG is picky about permissions

# 3. Symlink files FIRST
# This ensures ~/.vimrc exists before we try to install plugins
for file in $files; do
    if [ -L ~/$file ] || [ -f ~/$file ]; then
        rm ~/$file && echo "Removed existing $file"
    fi
    echo "Creating symlink to $file in home directory."
    ln -s "$dir/$file" "$HOME/$file"
done

# 4. Handle .gitconfig copies
for file in $cp_files; do
    if [ -f ~/$file ]; then
        CUR_TIME=$(date +'%s')
        NEW_FILE=$file".previous-"$CUR_TIME
        cp ~/$file ~/$NEW_FILE
        echo "Current $file backed up to $NEW_FILE"
    fi
    cp "$dir/$file" ~/$file
done

# 5. Install Vim-Plug if missing
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    echo "Installing vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# 6. Now install the plugins (now that .vimrc is linked)
echo "Installing/Updating Vim plugins..."
vim +PlugInstall +qall

# 7. macOS GPG Agent Setup
if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! grep -q "pinentry-program" ~/.gnupg/gpg-agent.conf 2>/dev/null; then
        echo "Configuring GPG pinentry for macOS..."
        # Use which to find the path dynamically (Intel vs Apple Silicon)
        PINENTRY_PATH=$(which pinentry-mac)
        if [ -n "$PINENTRY_PATH" ]; then
            echo "pinentry-program $PINENTRY_PATH" >> ~/.gnupg/gpg-agent.conf
            gpgconf --kill gpg-agent
        else
            echo "Warning: pinentry-mac not found. Install with 'brew install pinentry-mac'"
        fi
    fi
fi

echo "Setup complete!"
