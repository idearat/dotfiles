#!/bin/bash
ln -sfv ~/dotfiles/bash_profile ~/.bash_profile
ln -sfv ~/dotfiles/bashrc ~/.bashrc 
ln -sfv ~/dotfiles/gitconfig ~/.gitconfig 
ln -sfv ~/dotfiles/irbrc ~/.irbrc 
ln -sfv ~/dotfiles/rvmrc ~/.rvmrc 
ln -sfv ~/dotfiles/screenrc ~/.screenrc 
ln -sfv ~/dotfiles/tibetrc ~/.tibetrc 
ln -sfv ~/dotfiles/vimrc ~/.vimrc 
mv -f ~/.vim ~/.vim_orig
ln -sFv ~/dotfiles/vim/ ~/.vim 
