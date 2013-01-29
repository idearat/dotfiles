# README

Basic bash, vim, etc. support file configuration. Uses a customizable
configuration for bash startup, Janus for the VIM baseline, and a few
other pre-built dotfiles for common utilities like ack, tmux, etc.

# Installing

## Baseline Install Steps

    cd ~
    git clone https://github.com/idearat/dotfiles .dotfiles
    cd .dotfiles
    ./install.sh

## Post-Install Steps  

    vi .gitconfig   # edit name/email to proper values

# tl;dr

## General

The install.sh script moves every existing file to an _orig version
during installation so running it should not cause any data loss. See
the Cleanup section for how to list/remove these once you're satisfied
with your overall configuration.

## Bash

The .bash_profile runs:

    [[ -s ${HOME}/.login.before ]] && source ${HOME}/.login.before
    [[ -s ${HOME}/.bashrc ]] && source ${HOME}/.bashrc
    [[ -s ${HOME}/.login.after ]] && source ${HOME}/.login.after

By default the .login.before and .login.after files are empty.
This allows you to fully customize any login-specific operations. Note
that .bash_profile is only run when a login shell is invoked. The
.bashrc file is run for all shells given that it's invoked here.

The .bashrc file runs:

    [[ -s ${HOME}/.local.before ]] && source ${HOME}/.local.before
    [[ -s ${HOME}/.localrc ]] && source ${HOME}/.localrc
    [[ -s ${HOME}/.local.after ]] && source ${HOME}/.local.after

As with the 'login' variants there are before and after files for local
configuration, as well as a .localrc file for "core" operations. In
environments where you must use a company .bashrc file it's a good idea
to rename .bashrc to .localrc (the install script does this for you if
there's a previous .bashrc in existence.

It's recommended that you keep your personal bash configuration in the
local.before and local.after files in case you have to work in a
"hybrid" environment where pre-existing .bashrc logic is a requirement.

The .local.after file provided is significantly customized to match my
personal preferences. A few minor configuration items are found in the
.local.before file as well.

## VIM

This configuration is built on top of the excellent Janus baseline.
Configuration of Janus is managed largely by putting your customizations
in a ~/.janus folder. There's a default version of this folder
containing 'idearat' content which represents my personal 'bundle'.
See https://github.com/carlhuda/janus for complete information.

The default .vimrc file is a Janus file which load:

    ~/.vim/core/before/plugin/janus.vim
    ~/.vimrc.before
    ... pathogen bundles ...
    ~/.vimrc.after

The .vimrc.after file provided is significantly customized to match
my personal preferences. A few minor configuration items are found in
the .vimrc.before file as well.

## Others

There are numerous other dotfiles, such as an .ackrc file, which are
also linked into place by the install script. You should feel free to
fork the repository and adjust all of these as you see fit.

## Cleanup

You can list the _orig files by running:

    \ls -a | grep '_orig$'

You can remove these files by running:

    \ls -a | grep '_orig$' | xargs -n 1 rm 

