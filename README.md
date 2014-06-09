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
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
```

If you don't have ruby on your machine, well, maybe it's time for a new one ;).

If you already have `brew` you should ensure it's up to date by running:

```bash
brew update
brew doctor
```

The `brew doctor` command should run clean before proceeding.

### XCode

On a Mac you'll need to install XCode and XCode's command line tools. Download the
XCode package for your system and then install them from the XCode Download menu:

```
Preferences -> Downloads -> Command Line Tools
```

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

Once the repository is in place run the install script:

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

For everything to work properly you may need to edit /etc/shells to place an entry
for /usr/local/bin/zsh there to allow you to make it your default shell.

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

If you use iTerm or Terminal (of course you do!) you'll want to ensure that you
set your font to a Powerline-compatible font. This will help you see the full
display from any Powerline status line improvements etc.

## Cleanup

You can list the _orig files by running:

    \ls -a | grep '_orig$'

You can remove these files by running:

    \ls -a | grep '_orig$' | xargs -n 1 rm

