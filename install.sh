#!/bin/bash

# Installs the various tools leveraged by my standard configuration files and
# links those configuration files into place.

# Verify brew exists. If not then stop right now.
if [[ which brew ]]; then
    echo 'Homebrew found. Proceeding with install.'
else
    echo 'Homebrew not found.'
fi

export DOTFILES="$HOME/.dotfiles"

# Build working directories.

mkdir ~/dev > /dev/null
mkdir ~/tmp > /dev/null

# pull down custom oh-my-zsh repo fork


# Install and activate ZSH.
brew install zsh
curl -L http://install.ohmyz.sh | sh

# Install command-line utilities.
brew install ack
brew install ag     # not using yet, claimed better than ack for code
brew install wget   # some cut/paste installs use wget vs. curl.

brew install python # for pip, powerline, etc.

# Install TMUX support and MacOSX patches for clipboard.
brew install tmux
brew install reattach-to-user-namespace

# Install the node version manager and use it to install node.js.
#brew install nvm
#nvm install 0.10

# Install PhantomJS for web testing.
#brew install phantomjs

# Patch up Apache legacy links to match historical aliases.
# Apache on OSX 10.8 + doesn't provide the older standard locations. link them.
sudo ln -s /Library/WebServer/Documents /etc/apache2/htdocs
sudo ln -s /Library/WebServer/CGI-Executables /etc/apache2/cgi-bin

# Install rbenv (rather than rvm) and use it to install Ruby.
#brew install rbenv
#brew install ruby-build
#rbenv install 1.9.3-p0
#rbenv local 1.9.3-p0
#rbenv rehash

# Install (Mac)VIM and link MacVIM into Applications dir.
brew install macvim --override-system-vim
brew linkapps

# Install CTAGS to provide support for jstags operation.
brew install ctags

# Build the command-t plugin properly so it will load in VIM (after Ruby)
pushd ${DOTFILES}/vim/vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make
popd

# gh (GitHub CLI)
brew tap jingweno/gh
brew install gh
brew install --build-from-source gh # build gh from source
brew install --build-from-source --HEAD gh # build gh HEAD from source

# ACK
mv ~/.ackrc ~/.ackrc_orig > /dev/null
ln -sfv ${DOTFILES}/ack/ackrc ~/.ackrc

# local bin
mv ~/bin ~/bin_orig > /dev/null
ln -sfv ${DOTFILES}/bin ~/bin

# git
mv ~/.gitconfig ~/.gitconfig_orig > /dev/null
\cp -sfv ${DOTFILES}/git/gitconfig.idearat ~/.gitconfig

mv ~/.gitignore ~/.gitignore_orig > /dev/null
\cp ${DOTFILES}/git/gitignore.idearat ~/.gitignore

mv ~/.gitmessage.txt ~/.gitmessage.txt_orig > /dev/null
\cp -sfv ${DOTFILES}/git/gitmessage.txt.idearat ~/.gitmessage.txt

# ruby

mv ~/.irbrc ~/.irbrc_orig > /dev/null
ln -sfv ${DOTFILES}/ruby/irbrc ~/.irbrc

mv ~/.rdebugrc ~/.rdebugrc_orig > /dev/null
ln -sfv ${DOTFILES}/ruby/rdebugrc ~/.rdebugrc

# TIBET
mv ~/.tibetrc ~/.tibetrc_orig > /dev/null
ln -sfv ${DOTFILES}/tibet/tibetrc ~/.tibetrc

# TMUX
mv ~/.tmux.conf ~/.tmux.conf_orig > /dev/null
ln -sfv ${DOTFILES}/tmux/tmux.conf ~/.tmux.conf

# VIM
mv ~/.vim ~/.vim_orig > /dev/null
ln -sFv ${DOTFILES}/vim/vim ~/.vim

mv ~/.vimrc ~/.vimrc_orig > /dev/null
ln -sfv ${DOTFILES}/vim/vimrc ~/.vimrc

mv ~/.vimrc.after ~/.vimrc.after_orig > /dev/null
ln -sfv ${DOTFILES}/vim/vimrc.after ~/.vimrc.after

mv ~/.gvimrc ~/.gvimrc_orig > /dev/null
ln -sfv ${DOTFILES}/vim/vim/gvimrc ~/.gvimrc

mv ~/.editorconfig ~/.editorconfig_orig > /dev/null
ln -sfv ${DOTFILES}/vim/editorconfig ~/.editorconfig

# TODO: powerline install
# git clone ...
# TODO: powerline fonts etc. etc.
# git clone ...
# install font, configure font

# ZSH
mv ~/.local.after ~/.local.after_orig > /dev/null
ln -sfv ${DOTFILES}/bash/local.after ~/.local.after

# TODO: echo set of 'post-install hints'

# if you want to make zsh your default shell...
#
