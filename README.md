# README

My bash, vim, git, etc. support file configuration. Uses a customizable
configuration for bash and vim, Janus for the VIM baseline, and a few
other pre-built dotfiles for common utilities like ack, git, tmux, etc.

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

### Gnu make

On a Mac you'll need to install XCode's command line tools. Download the XCode
package for your system and then either...

Install them from the XCode Download menu:

```
Preferences -> Downloads -> Command Line Tools
```

OR

Install them from the command line:

```bash
xcode-select -switch /Library/Developer/CommandLineTools
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
`bash-completion`, and `ctags`. Additional steps include moving various files
into backup positions, linking in dotfile versions, and checking for other
tools.


## Post-Install Steps

Once the install script has run you will have a new set of bash startup scripts,
aliases, etc. which you can take advantage of. You'll want to source your
~/.bash\_profile to activate those in any open shells, or simply restart your
terminal application.

```bash
source ~/.bash_profile
```

Update your local gitconfig to use the proper username and email for your
environment.

```bash
vi ~/.gitconfig   # edit name/email to proper values
```

Make sure you have a VIM that isn't crippled:

```bash
vim --version
```

If you don't see at least version 7.3, or you see -clipboard, or no ruby
support, then install a new vim using brew:

```bash
brew install macvim --override-system-vim
```

If that fails it may be due to Apple removing/moving python headers. sigh. You
can try installing python etc. etc. etc. etc.

# tl;dr

## General

The install.sh script moves any existing file it will replace to an _orig
version during installation so running it should not cause any data loss. See
the Cleanup section for how to list/remove these once you're satisfied with your
overall configuration.

## Bash

### Login Shells

The .bash_profile runs:

    [[ -s ${HOME}/.login.before ]] && source ${HOME}/.login.before
    [[ -s ${HOME}/.bashrc ]] && source ${HOME}/.bashrc
    [[ -s ${HOME}/.login.after ]] && source ${HOME}/.login.after

By default the .login.before and .login.after files are empty.
This allows you to fully customize any login-specific operations. Note
that .bash\_profile is only run when a login shell is invoked. The
.bashrc file is run for all shells given that it's invoked here.

### All Shells

The .bashrc file runs:

    [[ -s ${HOME}/.local.before ]] && source ${HOME}/.local.before
    [[ -s ${HOME}/.localrc ]] && source ${HOME}/.localrc
    [[ -s ${HOME}/.local.after ]] && source ${HOME}/.local.after

As with the 'login' variants there are before and after files for local
configuration, as well as a .localrc file for "core" operations.

In environments where you must use a company .bashrc file it's a good idea
to rename .bashrc to .localrc (the install script does this for you if
there's a previous .bashrc in existence).

It's recommended that you keep your personal bash configuration in the
local.before and local.after files in case you have to work in a
"hybrid" environment where pre-existing .bashrc logic is a requirement.

The .local.after file provided is significantly customized to match my
personal preferences. A few minor configuration items are found in the
.local.before file as well.

You can edit the most meaningful of these files by using the two aliases 'vimit'
and 'vimlocal' which open the .login.after and .localrc files respectively.

## VIM

This configuration is built on top of the Janus vim setup baseline.
Configuration of Janus is managed largely by putting your customizations
in a ~/.janus folder. There's a default version of this folder
containing 'idearat' content which represents my personal 'bundle'.
See https://github.com/carlhuda/janus for complete information on customizing
janus and vim.

The default .vimrc file is a Janus file which loads:

    ~/.vim/core/before/plugin/janus.vim
    ~/.vimrc.before
    ... pathogen bundles ...
    ~/.vimrc.after

The .vimrc.after file provided is a bit quirky. Because vim can load any number
of plugins or file-type customizations the vimrc.after file I use adds an
autocmd group and a BufReadPost rule to trigger running ~/.vimrc.final. This
file _should_ be the last thing loaded by VIM other than anything triggered by
the rules/settings in that file itself. It's all a little complex, but the vimvi
alias will load the vimrc.final file for your edits. You don't need to mess with
most of the other setup.

## Others

There are numerous other dotfiles, such as an .ackrc file, which are
also linked into place by the install script. You should feel free to
fork the repository and adjust all of these as you see fit.

## Cleanup

You can list the _orig files by running:

    \ls -a | grep '_orig$'

You can remove these files by running:

    \ls -a | grep '_orig$' | xargs -n 1 rm

