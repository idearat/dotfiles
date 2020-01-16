# README


My zsh, vim, tmux, etc. support file configuration. Uses a customizable
configuration for zsh and vim, Pathogen for VIM components, and a few
other pre-built dotfiles for common utilities like ack, git, etc.

# Installing

Note that the following instructions assume you're running on a relatively
recent version of Mac OSX. In particular, one that has at least a standard
`ruby` executable that will let you install `brew` as described below.

## Prerequisites

### Homebrew (Brew)

You need `brew` to install various other dependencies. Get it via:

```bash
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

If you don't have ruby on your machine, well, maybe it's time for a new one ;).

If you already have `brew` you should ensure it's up to date by running:

```bash
brew update
brew doctor
```

The `brew doctor` command should run cleanly before you proceed.

### XCode

On a Mac you'll need to install XCode and XCode's command line tools.

There are a couple of options for doing this from installing XCode to running `xcode-select --install`. Use whatever approach works best for your version of MacOS.

### Git

You'll need git so you can download the dotfiles repo. Once you have `brew`
installed:

```bash
brew install git
```

## Dotfiles Install

To install the dotfiles start with a git clone:

```bash
git clone https://github.com/idearat/dotfiles ~/.dotfiles
```

Once the repository is in place run the install script from your home directory:

```
~/.dotfiles/install.sh
```

The `install.sh` file will invoke `brew` to install utilities including `ack`,
`ctags`, etc. Additional steps include moving various files into backup
positions, linking in dotfile versions, and checking for other tools.

A number of git submodules, mostly vim plugins, will also be installed (or
updated if you run the install script multiple times).

The installer will also install an updated VIM executable to ensure that you
have support for the clipboard, ruby, etc. This version of VIM is installed
along with MacVim and overrides your standard system version of VIM.

## Post-Install Steps

Once the install script has run you will have a new set of zsh startup scripts,
aliases, etc. which you can take advantage of.

To properly use the new `zsh` instance you'll need to do a couple of preliminary
steps using the Terminal application.

### Install iTerm2

If you're not already running iTerm2 I recommend installing it as a replacement
for the standard MacOS Terminal application.

```
https://www.iterm2.com/downloads.html
```

### Update your default shell

Regardless of your choice of terminal open a new terminal and edit `/etc/shells`
to ensure the brew-installed `zsh` is available.

You'll want to verify the  path (typically `/usr/local/bin/zsh`).

```
$ which zsh
/usr/local/bin/zsh
```

Once you have the right path edit `/etc/shells` and add the path:

```
sudo vi /etc/shells
```

Once you've added the `zsh` to your shell options set `zsh` to be the default
shell by typing:

``` bash
chsh -s /usr/local/bin/zsh
```

With that change in place exit any terminals so you get a clean login that will
execute the dotfiles-installed startup scripts. This should give you a set of
new aliases which let you complete the rest of the steps here.

### Update your vim-related git submodules

Update any submodules to be sure they're available (mostly for vim) using the
`subup` alias:

```
subup
```

Install the powerline-fonts so you can use them in iTerm2 or Terminal:
```
~/.dotfiles/util/powerline-fonts/install.sh
```

Update iTerm2 (or Terminal) to use 'Inconsolata for Powerline' by editing the
proper text preferences in that application.


Install vim via brew to be sure you have clipboard support etc.
```
brew install vim
```

Update the VIMRUNTIME value in your startup scripts (via `vimit`). The default
value is probably something like `/usr/local/share/vim/vim82` but you should
change that last portion to point to the version you installed.
```
export VIMRUNTIME="/usr/local/share/vim/vim82"
```

For npm completion to work effectively you may want to execute the following:

```bash
npm completion >> ~/.zshrc
```

Once your default shell has been set you'll want to source your ~/.zshrc file to
activate your profile in any open shells, or simply restart your terminal app(s).

```bash
source ~/.zshrc
```

Update your local gitconfig to use the proper username and email for your
environment.

```bash
vi ~/.gitconfig   # edit name/email to proper values
```

If you use two-factor authentication for GitHub (and you should) you'll need to
ensure your credentials are in place. Use the instructions at:

```bash
https://help.github.com/articles/caching-your-github-password-in-git/
```

If you use iTerm or Terminal (of course you do!) you'll want to ensure that you
set your font to a Powerline-compatible font. This will help you see the full
display from any Powerline status line improvements etc.

```bash
defaults write com.apple.finder AppleShowAllFiles -boolean true
killall Finder
```

## Cleanup

You can list the _orig files by running:

    \ls -a | grep '_orig$'

You can remove these files by running:

    \ls -a | grep '_orig$' | xargs -n 1 rm

