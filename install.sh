#!/bin/bash
#

# Installs the basic links etc.

# NOTE: this assumes you're in the dotfiles directory when you run install.sh
export DOTFILE_HOME=`pwd`

# Build working directories.
mkdir ~/dev > /dev/null
mkdir ~/tmp > /dev/null

# Prerequisites / Utilities
brew install ack
brew install bash-completion
brew install ctags

# install macvim/vim and link macvim into Applications dir
brew install macvim --override-system-vim
brew linkapps

# Apache on OSX 10.8 + doesn't provide the older standard locations for apache.
sudo ln -s /Library/WebServer/Documents /etc/apache2/htdocs
sudo ln -s /Library/WebServer/CGI-Executables /etc/apache2/cgi-bin

# Bash
mv ~/.bash_profile ~/.bash_profile_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/bash/bash_profile ~/.bash_profile

[[ -e ~/.bashrc ]] && \cp ~/.bashrc ~/.localrc
mv ~/.bashrc ~/.bashrc_orig > /dev/null
mv ~/.localrc ~/.localrc_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/bash/bashrc ~/.bashrc

mv ~/.login.before ~/.login.before_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/bash/login.before ~/.login.before
mv ~/.login.after ~/.login.after_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/bash/login.after ~/.login.after
mv ~/.local.before ~/.local.before_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/bash/local.before ~/.local.before
mv ~/.local.after ~/.local.after_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/bash/local.after ~/.local.after

# Bin
mv ~/bin.local ~/bin.local_orig > /dev/null
ln -sv ${DOTFILE_HOME}/bin ~/bin.local

# Git
ln -sfv ${DOTFILE_HOME}/git/git-flow-completion/git-flow-completion.bash ~/.git-flow-completion.bash
mv ~/.gitignore ~/.gitignore_orig > /dev/null
\cp ${DOTFILE_HOME}/git/gitignore.idearat ~/.gitignore
mv ~/.gitconfig ~/.gitconfig_orig > /dev/null
\cp -sfv ${DOTFILE_HOME}/git/gitconfig.idearat ~/.gitconfig

git config --global core.excludesfile ~/.gitignore

# Node

# TODO: ensure proper installation of nvm, then node

# Ruby

# TODO: remove rvm, replace with rbenv, and install.
# NOTE that installing pre-1.9.x versions requires old GCC from
# https://github.com/kennethreitz/osx-gcc-installer/downloads

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

# IF brew install vim is done then don't do this step...
# /usr/local/share doesn't always have a vim reference.
#ln -sfv /usr/share/vim /usr/local/share/vim

# TODO add flag to turn this off as desired.
# Initialize submodules. Janus etc. must be updated before we can link them.
git submodule init
git submodule update
pushd vim/janus
rake
popd

mv ~/.vim ~/.vim_orig > /dev/null
ln -sFv ${DOTFILE_HOME}/vim/janus/janus/vim ~/.vim
mv ~/.janus ~/.janus_orig > /dev/null
ln -sFv ${DOTFILE_HOME}/vim/janus.local ~/.janus

mv ~/.vimrc ~/.vimrc_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/vim/janus/janus/vim/vimrc ~/.vimrc
mv ~/.vimrc.after ~/.vimrc.after_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/vim/vimrc.after ~/.vimrc.after
mv ~/.vimrc.before ~/.vimrc.before_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/vim/vimrc.before ~/.vimrc.before
mv ~/.vimrc.final ~/.vimrc.final_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/vim/vimrc.final ~/.vimrc.final

mv ~/.gvimrc ~/.gvimrc_orig > /dev/null
ln -sfv ${DOTFILE_HOME}/vim/janus/janus/vim/gvimrc ~/.gvimrc

# TODO: add echo for installing Command-T (gotta build it)


