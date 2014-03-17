#!/bin/bash

# Installs the various tools leveraged by my standard configuration files and
# links those configuration files into place.

# ---
# Pre-Install
# ---

# Verify brew exists. If not then stop right now.
if [[ $(which brew) ]]; then
    echo 'Homebrew (brew) found. Verifying brew installation...'
    if [[ $(brew doctor) ]]; then
      echo 'Your system is ready to brew.'
    else
      echo 'Repair brew doctor issues and retry.'
      exit
    fi
else
    echo 'Homebrew (brew) not found. Install brew and retry.'
    echo 'install brew via:'; echo
    echo 'ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"'
fi

echo 'Updating git submodules...'
git submodule init
git submodule update
git submodule foreach 'git fetch origin; git checkout $(git rev-parse --abbrev-ref HEAD); git reset --hard origin/$(git rev-parse --abbrev-ref HEAD); git submodule update --recursive; git clean -dfx'

# ---
# Shell Etc.
# ---

# Configure a root we can simply our paths with.
export DOTFILES="$HOME/.dotfiles"

echo 'Creating working directories...'
[[ -d ~/dev ]] || mkdir ~/dev > /dev/null 2>&1
[[ -d ~/tmp ]] || mkdir ~/tmp > /dev/null 2>&1

echo 'Verifying zsh installation...'
[[ $(brew list zsh) ]] > /dev/null 2>&1 || \
(echo 'Installing zsh via brew...' && brew install zsh)

# Normally this would run next, but we'll be linking in from ./zsh/oh-my-zsh.
#curl -L http://install.ohmyz.sh | sh

# ---
# Command-line utilities
# ---

echo 'Verifying command line utilities...'

# Ack is my default search tool from the command line.
echo 'Checking for ack...'
[[ $(brew list ack) ]] > /dev/null 2>&1 || \
(echo 'Installing ack via brew...' && brew install ack)

# Supposedly even faster than ack for codebase searches.
echo 'Checking for ag...'
[[ $(brew list ag) ]] > /dev/null 2>&1 || \
(echo 'Installing ag via brew...' && brew install ag)

# Install CTAGS to provide support for jstags operation.
echo 'Checking for ctags...'
[[ $(brew list ctags) ]] > /dev/null 2>&1 || \
(echo 'Installing ctags via brew...' && brew install ctags)

# gh (GitHub CLI)
echo 'Checking for gh (Github CLI)...'
[[ $(brew list gh) ]] > /dev/null 2>&1 || \
(echo 'Installing gh via brew...' && \
brew tap jingweno/gh && \
brew install gh && \
brew install --build-from-source gh && \
brew install --build-from-source --HEAD gh)

# Some cut/paste installs rely on wget so install it.
echo 'Checking for wget...'
[[ $(brew list wget) ]] > /dev/null 2>&1 || \
(echo 'Installing wget via brew...' && brew install wget)

# ---
# Languages
# ---

echo 'Verifying language support...'

# Install the node version manager and use it to install node.js.
echo 'Checking for nvm and node.js...'
[[ $(brew list nvm) ]] > /dev/null 2>&1 || \
(echo 'Installing nvm via brew...' && brew install nvm && nvm install 0.10)

# Install PhantomJS for web testing.
echo 'Checking for phantomjs...'
[[ $(brew list phantomjs) ]] > /dev/null 2>&1 || \
(echo 'Installing phantomjs via brew...' && brew install phantomjs)

# Install updated python for pip, powerline, etc.
echo 'Checking for python...'
[[ $(brew list python) ]] > /dev/null 2>&1 || \
(echo 'Installing python via brew...' && brew install python)

# Install rbenv (rather than rvm) and use it to install Ruby.
echo 'Checking for rbenv and ruby...'
[[ $(brew list rbenv) ]] > /dev/null 2>&1 || \
(echo 'Installing rbenv via brew...' && \
brew install rbenv && \
rbenv init - > /dev/null 2>&1 && \
brew install ruby-build && \
rbenv install 1.9.3-p0 && \
rbenv local 1.9.3-p0 && \
rbenv rehash)

# ---
# Applications
# ---

echo 'Verifying application support...'

# Install (Mac)VIM and link MacVIM into Applications dir.
echo 'Checking for macvim and vim...'
[[ $(brew list rbenv) ]] > /dev/null 2>&1 || \
[[ $(brew list macvin) ]] > /dev/null 2>&1 || \
(echo 'Installing macvin via brew...' && \
brew install macvim --override-system-vim && \
brew linkapps)

# Install TMUX support and MacOSX patches for clipboard.
echo 'Checking for tmux...'
[[ $(brew list tmux) ]] > /dev/null 2>&1 || \
(echo 'Installing tmux via brew...' && brew install tmux)

echo 'Checking for tmux macosx clipboard patches...'
[[ $(brew list reattach-to-user-namespace) ]] > /dev/null 2>&1 || \
(echo 'Installing reattach-to-user-namespace via brew...' && brew install reattach-to-user-namespace)

# TODO: powerline configuration

# Install powerline fonts so we see what we want in the vim and tmux status bars.
echo 'Checking for powerline-font installation...'
if [[ ! -e /Library/Fonts/Inconsolata\ for\ Powerline.otf ]]; then
  echo 'Installing powerline-font fonts in /Library/Fonts...'
  find ${DOTFILES}/util/powerline-fonts -name "*.otf" -exec cp '{}' /Library/Fonts \;
fi

# Build the command-t plugin properly so it will load in VIM (after Ruby)
echo 'Rebuilding command-t plugin via ruby/make...'
pushd ${DOTFILES}/vim/vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make
popd

# ---
# Links
# ---

echo 'Linking in profile configuration files...'

# Patch up Apache legacy links to match historical aliases.
# Apache on OSX 10.8 + doesn't provide the older standard locations. link them.
echo 'Checking legacy apache2 links...'
[[ -e /etc/apache2/htdocs ]] || (sudo ln -s /Library/WebServer/Documents /etc/apache2/htdocs > /dev/null 2>&1)
[[ -e /etc/apache2/cgi-bin ]] || (sudo ln -s /Library/WebServer/CGI-Executables /etc/apache2/cgi-bin > /dev/null 2>&1)

# bin directory
\mv -f ~/bin ~/bin_orig > /dev/null 2>&1
ln -sfv ${DOTFILES}/bin ~/bin

# ack
\mv -f ~/.ackrc ~/.ackrc_orig > /dev/null 2>&1
ln -sfv ${DOTFILES}/ack/ackrc ~/.ackrc

# git
\mv -f ~/.gitconfig ~/.gitconfig_orig > /dev/null 2>&1
\cp -fv ${DOTFILES}/git/gitconfig.idearat ~/.gitconfig

\mv -f ~/.gitignore ~/.gitignore_orig > /dev/null 2>&1
\cp -fv ${DOTFILES}/git/gitignore.idearat ~/.gitignore

\mv -f ~/.gitmessage.txt ~/.gitmessage.txt_orig > /dev/null 2>&1
\cp -fv ${DOTFILES}/git/gitmessage.txt.idearat ~/.gitmessage.txt

# ruby
\mv -f ~/.irbrc ~/.irbrc_orig > /dev/null 2>&1
ln -sfv ${DOTFILES}/ruby/irbrc ~/.irbrc

\mv -f ~/.rdebugrc ~/.rdebugrc_orig > /dev/null 2>&1
ln -sfv ${DOTFILES}/ruby/rdebugrc ~/.rdebugrc

# tmux
\mv -f ~/.tmux.conf ~/.tmux.conf_orig > /dev/null 2>&1
ln -sfv ${DOTFILES}/tmux/tmux.conf ~/.tmux.conf

# vim
\mv -f ~/.editorconfig ~/.editorconfig_orig > /dev/null 2>&1
ln -sfv ${DOTFILES}/vim/editorconfig ~/.editorconfig

\mv -f ~/.gvimrc ~/.gvimrc_orig > /dev/null 2>&1
ln -sfv ${DOTFILES}/vim/vim/gvimrc ~/.gvimrc

\mv -f ~/.vim ~/.vim_orig > /dev/null 2>&1
ln -sFv ${DOTFILES}/vim/vim ~/.vim

\mv -f ~/.vimrc ~/.vimrc_orig > /dev/null 2>&1
ln -sfv ${DOTFILES}/vim/vimrc ~/.vimrc

\mv -f ~/.vimrc.after ~/.vimrc.after_orig > /dev/null 2>&1
ln -sfv ${DOTFILES}/vim/vimrc.after ~/.vimrc.after

\mv -f ~/.zshrc ~/.zshrc_orig > /dev/null 2>&1
ln -sfv ${DOTFILES}/zsh/zshrc ~/.zshrc

\mv -f ~/.oh-my-zsh ~/.oh-my-zsh_orig > /dev/null 2>&1
ln -sfv ${DOTFILES}/zsh/oh-my-zsh ~/.oh-my-zsh

\mv -f ~/.tibetrc ~/.tibetrc_orig > /dev/null 2>&1
ln -sfv ${DOTFILES}/tibet/tibetrc ~/.tibetrc

# ---
# Post-Install
# ---

echo 'Installation complete.'; echo

# TODO: echo set of 'post-install hints'

echo 'Post-installation options:'; echo

echo 'To make zsh your default shell (and you should now):'
echo 'chsh -s /usr/local/bin/zsh'; echo

echo 'To remove _orig files use:'
echo "\ls -a | grep \'_orig$\' | xargs -n 1 rm -rf"; echo

echo 'For best results close all terminals now and reopen them.'
echo 'Enjoy!'
