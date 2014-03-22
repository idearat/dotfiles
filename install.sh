#!/bin/bash

# Installs the various tools leveraged by the configuration files in this
# collection and links those configuration files into place.

# ---
# Pre-Install
# ---

# Set a path we can count on. Otherwise things can get strange/circular.
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

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

# Install the node version manager and use it to install node.js/npm. Note that
# the 'nvm use' here adds to the start of our path for subsequent node calls.
echo 'Checking for nvm and node.js...'
[[ $(brew list nvm) ]] > /dev/null 2>&1 || \
(echo 'Installing nvm via brew...' && brew install nvm && nvm install 0.10)
source $(brew --prefix nvm)/nvm.sh && nvm use 0.10

# We use a lot of submodules in the vim section in particular. The most
# important one is the zsh/oh-my-zsh submodule which pulls in the main zsh
# profile files. Note we checkout master to avoid detached HEAD conditions.
echo 'Updating git submodules...'
git submodule init
git submodule update --recursive
git submodule foreach 'git fetch origin; git checkout master; git pull'

# ---
# Shell Etc.
# ---

# Configure a root we can simplify our references in this script with.
export DOTFILES="$HOME/.dotfiles"

echo 'Creating working directories...'
[[ -d ~/dev ]] || mkdir ~/dev > /dev/null 2>&1
[[ -d ~/tmp ]] || mkdir ~/tmp > /dev/null 2>&1

echo 'Verifying zsh installation...'
[[ $(brew list zsh) ]] > /dev/null 2>&1 || \
(echo 'Installing zsh via brew...' && brew install zsh)

# Normally this would run next, but we'll be linking in from ./zsh/oh-my-zsh.
# Retained here more for reference.
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

# Install CTAGS to provide support for jstags alias in zsh config.
echo 'Checking for ctags...'
[[ $(brew list ctags) ]] > /dev/null 2>&1 || \
(echo 'Installing ctags via brew...' && brew install ctags)

# TODO: I branched this repo to add enterprise support. Update when that's ready
# so we install my branch rather than the npm module (until changes merge ;)).
# gh (GitHub CLI)
echo 'Checking for gh (GitHub CLI)...'
[[ $(npm info gh) ]] > /dev/null 2>&1 || \
(echo 'Installing gh via npm...' &&  npm install -g gh)

# Some cut/paste installs from the web rely on wget so install it.
echo 'Checking for wget...'
[[ $(brew list wget) ]] > /dev/null 2>&1 || \
(echo 'Installing wget via brew...' && brew install wget)

# ---
# Languages
# ---

echo 'Verifying language support...'

# Install PhantomJS for web testing.
echo 'Checking for phantomjs...'
[[ $(brew list phantomjs) ]] > /dev/null 2>&1 || \
(echo 'Installing phantomjs via brew...' && brew install phantomjs)

# Install updated python for pip, powerline, etc.
echo 'Checking for python...'
[[ $(brew list python) ]] > /dev/null 2>&1 || \
(echo 'Installing python via brew...' && brew install python)

# Install rbenv (rather than rvm) and use it to install Ruby. One thing to be
# aware of is that on Mac you need 1.9.3 greater than a certain patch level or
# the ruby-build step will fail unless you use the apple-gcc42 found here.
echo 'Checking for rbenv and ruby...'
[[ $(brew list rbenv) ]] > /dev/null 2>&1 || \
(echo 'Installing rbenv via brew...' && \
brew install rbenv && \
rbenv init - > /dev/null 2>&1 && \
brew install ruby-build && \
brew tap homebrew/dupes && \
brew install apple-gcc42 && \
rbenv install 1.8.7-p357 && \
rbenv local 1.8.7-p357 && \
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

# Install powerline fonts so we see what we want in vim and tmux status bars.
echo 'Checking for powerline-font installation...'
if [[ ! -e /Library/Fonts/Inconsolata\ for\ Powerline.otf ]]; then
  echo 'Installing powerline-font fonts in /Library/Fonts...'
  find $DOTFILES/util/powerline -name "*.otf" -exec cp '{}' /Library/Fonts \;
  find $DOTFILES/util/powerline-fonts -name "*.otf" -exec cp '{}' /Library/Fonts \;
fi

# ---
# Links
# ---

echo 'Linking in profile configuration files...'

# Patch up Apache legacy links to match historical aliases.
# Apache on OSX 10.8 + doesn't provide the older standard locations.
echo 'Checking legacy apache2 links...'
[[ -e /etc/apache2/htdocs ]] || (sudo ln -s /Library/WebServer/Documents /etc/apache2/htdocs > /dev/null 2>&1)
[[ -e /etc/apache2/cgi-bin ]] || (sudo ln -s /Library/WebServer/CGI-Executables /etc/apache2/cgi-bin > /dev/null 2>&1)

# bin directory
\mv -f ~/bin ~/bin_orig > /dev/null 2>&1
ln -sfFv $DOTFILES/bin ~/
rm -rf bin/bin > /dev/null 2>&1

# ack
\mv -f ~/.ackrc ~/.ackrc_orig > /dev/null 2>&1
ln -sfv $DOTFILES/ack/ackrc ~/.ackrc

# git
\mv -f ~/.gitconfig ~/.gitconfig_orig > /dev/null 2>&1
\cp -fv $DOTFILES/git/gitconfig.idearat ~/.gitconfig

\mv -f ~/.gitignore ~/.gitignore_orig > /dev/null 2>&1
\cp -fv $DOTFILES/git/gitignore.idearat ~/.gitignore

\mv -f ~/.gitmessage.txt ~/.gitmessage.txt_orig > /dev/null 2>&1
\cp -fv $DOTFILES/git/gitmessage.txt.idearat ~/.gitmessage.txt

# ruby
\mv -f ~/.irbrc ~/.irbrc_orig > /dev/null 2>&1
ln -sfv $DOTFILES/ruby/irbrc ~/.irbrc

\mv -f ~/.rdebugrc ~/.rdebugrc_orig > /dev/null 2>&1
ln -sfv $DOTFILES/ruby/rdebugrc ~/.rdebugrc

# tmux
\mv -f ~/.tmux.conf ~/.tmux.conf_orig > /dev/null 2>&1
ln -sfv $DOTFILES/tmux/tmux.conf ~/.tmux.conf

\mv -f ~/.tmux_status.conf ~/.tmux_status.conf_orig > /dev/null 2>&1
ln -sfv $DOTFILES/tmux/tmux_status.conf ~/.tmux_status.conf

# vim
\mv -f ~/.editorconfig ~/.editorconfig_orig > /dev/null 2>&1
ln -sfv $DOTFILES/vim/editorconfig ~/.editorconfig

\mv -f ~/.gvimrc ~/.gvimrc_orig > /dev/null 2>&1
ln -sfv $DOTFILES/vim/gvimrc ~/.gvimrc

\mv -f ~/.vim ~/.vim_orig > /dev/null 2>&1
ln -sfFv $DOTFILES/vim/vim ~/.vim
rm -rf vim/vim/.vim > /dev/null 2>&1

\mv -f ~/.vimrc ~/.vimrc_orig > /dev/null 2>&1
ln -sfv $DOTFILES/vim/vimrc ~/.vimrc

\mv -f ~/.vimrc.after ~/.vimrc.after_orig > /dev/null 2>&1
ln -sfv $DOTFILES/vim/vimrc.after ~/.vimrc.after

\mv -f ~/.zshrc ~/.zshrc_orig > /dev/null 2>&1
ln -sfv $DOTFILES/zsh/zshrc ~/.zshrc

\mv -f ~/.oh-my-zsh ~/.oh-my-zsh_orig > /dev/null 2>&1
ln -sfFv $DOTFILES/zsh/oh-my-zsh ~/.oh-my-zsh
rm -rf zsh/oh-my-zsh/.oh-my-zsh > /dev/null 2>&1

\mv -f ~/.tibetrc ~/.tibetrc_orig > /dev/null 2>&1
ln -sfv $DOTFILES/tibet/tibetrc ~/.tibetrc

# ---
# Post-Install
# ---

echo 'Installation complete.'; echo

# TODO: echo set of 'post-install hints'

echo 'Post-installation options:'; echo

echo 'To make zsh your default shell (and you should now):'
echo 'chsh -s /usr/local/bin/zsh'; echo

echo 'To remove _orig files use:'
echo "\ls -a | grep \'_orig$\' | xargs -n 1 rm -rf";
echo "or 'rmorig' from your home directory if safe."; echo

echo 'For best results close all terminals now and reopen them.'
echo 'Enjoy!'

