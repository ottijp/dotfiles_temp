#!/usr/bin/env bash

ln -snf ~/dotfiles/.vimrc ~/.vimrc
ln -snf ~/dotfiles/.gvimrc ~/.gvimrc
ln -snf ~/dotfiles/.xvimrc ~/.xvimrc
ln -snf ~/dotfiles/.ideavimrc ~/.ideavimrc
ln -snf ~/dotfiles/.vimperatorrc ~/.vimperatorrc
ln -snf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -snf ~/dotfiles/.gitconfig ~/.gitconfig
curl -L -o .git-completion.bash https://github.com/git/git/raw/master/contrib/completion/git-completion.bash
ln -snf ~/dotfiles/.git-completion.bash ~/.git-completion.bash
curl -L -o .git-prompt.sh https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh
chmod +x .git-prompt
ln -snf ~/dotfiles/.git-prompt.sh ~/.git-prompt.sh
ln -snf ~/dotfiles/.ctags ~/.ctags
ln -snf ~/dotfiles/karabiner/private.xml ~/Library/Application\ Support/Karabiner/private.xml
mkdir -p ~/.hammerspoon
ln -snf ~/dotfiles/.hammerspoon/init.lua ~/.hammerspoon/init.lua
ln -snf ~/dotfiles/.iterm2 ~/.iterm2
ln -snf ~/dotfiles/.fzf.bash ~/.fzf.bash
ln -snf ~/dotfiles/.inputrc ~/.inputrc
ln -snf ~/dotfiles/.bashrc ~/.bashrc

mkdir -p ~/vimbackup
mkdir -p ~/.vim
ln -snf ~/dotfiles/colors ~/.vim/colors

cat .bashrc_diff >> ~/.bashrc

