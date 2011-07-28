#!/bin/bash
ln -sfv ~/dotfiles/bash_profile ~/.bash_profile
ln -sfv ~/dotfiles/bashrc ~/.bashrc 
ln -sfv ~/dotfiles/.git-flow-completion.bash ~/.git-flow-completion.sh
ln -sfv ~/dotfiles/gitconfig ~/.gitconfig 
ln -sfv ~/dotfiles/gitignore ~/.gitignore 
ln -sfv ~/dotfiles/irbrc/irbrc ~/.irbrc 
ln -sfv ~/dotfiles/rvmrc ~/.rvmrc 
ln -sfv ~/dotfiles/screenrc ~/.screenrc 
ln -sfv ~/dotfiles/tmux.conf ~/.tmux.conf 
ln -sfv ~/dotfiles/tibetrc ~/.tibetrc 
ln -sfv ~/dotfiles/vimrc ~/.vimrc 
ln -sfv ~/dotfiles/gvimrc ~/.gvimrc 
ln -sfv ~/dotfiles/rdebugrc ~/.rdebugrc 

mv ~/.vim ~/.vim_orig > /dev/null
ln -sFv ~/dotfiles/vim/ ~/.vim 

ln -sv ~/dotfiles/bin ~/bin
mkdir  ~/tmp > /dev/null
