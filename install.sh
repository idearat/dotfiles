#!/bin/bash
#
# Installs the basic links etc.

export DOTFILE_HOME=`pwd`

# Bash
mv ~/.bash_profile ~/.bash_profile_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/bash/bash_profile ~/.bash_profile

mv ~/.bashrc ~/.bashrc_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/bash/bashrc ~/.bashrc

ln -sfv ${DOTFILE_HOME}/bash/login.before ~/.login.before
ln -sfv ${DOTFILE_HOME}/bash/login.after ~/.login.after
ln -sfv ${DOTFILE_HOME}/bash/local.before ~/.local.before
ln -sfv ${DOTFILE_HOME}/bash/local.after ~/.local.after

# Bin
ln -sv ${DOTFILE_HOME}/bin ~/bin.local

# Git
ln -sfv ${DOTFILE_HOME}/git/git-flow-completion/git-flow-completion.bash ~/.git-flow-completion.bash
mv ~/.gitignore ~/.gitignore_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/git/gitignore ~/.gitignore

# Node

# Ruby
mv ~/.irbrc ~/.irbrc_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/ruby/irbrc/irbrc ~/.irbrc
mv ~/.rdebugrc ~/.rdebugrc_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/ruby/rdebugrc ~/.rdebugrc

# TIBET
mv ~/.tibetrc ~/.tibetrc_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/tibet/tibetrc ~/.tibetrc

# Utils
mv ~/.ackrc ~/.ackrc_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/utils/ackrc ~/.ackrc
mv ~/.screenrc ~/.screenrc_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/utils/screenrc ~/.screenrc
mv ~/.tmux.conf ~/.tmux.conf_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/utils/tmux.conf ~/.tmux.conf

# VIM
mv ~/.vim ~/.vim_orig > /dev/null
ln -sFv ${DOTFILE_HOME}/vim/janus/janus/vim ~/.vim
mv ~/.janus ~/.janus_orig > /dev/null
ln -sFv ${DOTFILE_HOME}/vim/janus.local ~/.janus

ln -sfv ${DOTFILE_HOME}/vim/janus/janus/vim/vimrc ~/.vimrc
ln -sfv ${DOTFILE_HOME}/vim/vimrc.after ~/.vimrc.after
ln -sfv ${DOTFILE_HOME}/vim/vimrc.before ~/.vimrc.before

mv ~/.gvimrc ~/.gvimrc_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/vim/janus/janus/vim/gvimrc ~/.gvimrc

mkdir ~/tmp > /dev/null

