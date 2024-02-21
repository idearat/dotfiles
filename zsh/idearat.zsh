#!/usr/local/bin/zsh

# ---
# path roots
# ---

export PATH="${HOME}/bin:${HOME}/.local/bin"
export PATH="${PATH}:/opt/homebrew/bin"
export PATH="${PATH}:/opt/homebrew/opt/ruby@3.2/bin"
export PATH="${PATH}:/opt/homebrew/opt/postgresql@15/bin"
export PATH="${PATH}:/usr/local/bin:/usr/local/bin/araxis:/usr/local/sbin"
export PATH="${PATH}:/usr/texbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"

source $(brew --prefix chruby)/share/chruby/chruby.sh > /dev/null 2>&1
chruby 2.2.3 > /dev/null 2>&1

source ~/.nvm/nvm.sh > /dev/null 2>&1

source ~/.gvm/scripts/gvm > /dev/null 2>&1

export MANPATH=".:${HOME}/man:/usr/local/man:/usr/local/share/man:/usr/man:\
  /usr/bin/man:/usr/share/man:/usr/share/locale/en/man:/usr/X11R6/man"

export DEVL_HOME="${HOME}/dev"
export USB_ROOT='/Volumes/secure'

source "$HOME/.cargo/env" > /dev/null 2>&1

#export COUCH='http://0.0.0.0:5984'
#export COUCH_URL="http://localhost:5984"

# ---
# shell options
# ---

set -o noclobber
set -o ignoreeof
set -o vi

# ---
# shell variables
# ---

export CLICOLOR=1
export EDITOR='nvim'
export LAUNCH_EDITOR='code'
export IGNOREEOF=1
export LC_TYPE='en_US.UTF-8'
export LESS=FRSX
export LS_OPTIONS='--color=auto'
export LSCOLORS='gxgxfxfxcxdxdxhbadbxbx'
export TERM=xterm-256color

# ---
# zsh upgrades
# ---

if [[ "$SHELL" =~ 'zsh$' ]]; then
  if type brew &>/dev/null; then
      FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

      autoload -Uz compinit
      compinit
  fi

  setopt completeinword

  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
  zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

  autoload select-word-style
  select-word-style shell

  # extended globs
  setopt extendedglob
  unsetopt caseglob

  # extended history
  setopt extendedhistory
  unsetopt sharehistory
fi

export REPORTTIME=10

# ---
# history setup
# ---

HISTFILE=${HOME}/.zhistory
HISTSIZE=SAVEHIST=10000
HISTCONTROL=erasedups

# ---
# project roots
# ---

export IDEARAT_HOME="${DEVL_HOME}/idearat"
export PROJECT_HOME="${DEVL_HOME}/idearat"

export NGINX_HOME="/usr/local/etc/nginx"
export TPI_HOME="${DEVL_HOME}/TPI"
export CODERATS_HOME="${DEVL_HOME}/coderats"
export TIBET_HOME="${TPI_HOME}/TIBET"
export CMDFLOW_HOME="${CODERATS_HOME}/viziflow/cmdflow"
export VIZITD_HOME="${CODERATS_HOME}/viziflow/vizitd"

alias writing='cd ~/Documents/SS\ Docs/Writing'
alias journal='ss; vi journal.md'
alias inspire='ss; vi inspirations.md'
alias mantras='ss; vi mantras.md'
alias big7='cd ~/dev/idearat/big7'
alias docs='cd ~/Documents/SS\ Docs/'

# ---
# config files
# ---

alias cddot="cd ${HOME}/.dotfiles"
alias cdvim='cd ${HOME}/.config/idearat'
alias cdlv='cd ${HOME}/.config/lvim'

alias vimit="vi ${HOME}/.dotfiles/zsh/idearat.zsh"
alias srcit="source ${HOME}/.zshrc"

alias vimpk="vi ${HOME}/.p10k.zsh"
alias srcpk="source ${HOME}/.p10k.zsh"

alias vimdot="vi ${HOME}/.dotfiles/install.sh"
alias vimgit="vi ${HOME}/.gitconfig"
alias vimng="vi /usr/local/etc/nginx/nginx.conf"
alias vimtmux="vi ${HOME}/.tmux.conf"

alias vimvi="vi ${HOME}/.vimrc.after"
alias vimvilocal="vi ${HOME}/.vimrc.local"
alias vimlocal="vi ${HOME}/.localrc"
alias vimcolor="vi ${HOME}/.vim/bundle/idearat/colors/idearat"
alias vimsyntax="vi ${HOME}/.vim/bundle/idearat/syntax/javascript.vim"

# ---
# listings
# ---

alias ls='ls -H'
alias l='ls -Fh'
alias la='ls -aFh'
alias ll='ls -lFh'
alias lla='ls -laFh'
alias lsd='ls -laFh **/**'
alias l1='ls -C1'

# ---
# common flags
# ---

alias bc='bc -l'
alias cls='clear; ls'
alias cp='cp -i'
alias df='df -H'
alias du='du -ch'
alias egrep='egrep --color=auto'
alias env='env | sort'
alias fgrep='fgrep --color=auto'
alias ftp='ftp -i'
alias grep='grep --color=auto'
alias h='history'
alias ifconfig='ifconfig -a'
alias irc='irssi'
alias jobs='jobs -l'
alias ln='ln -i'
alias lynx='lynx -vikeys'
alias md5='md5 -r'
alias md5sum='md5 -r'
alias mkdir='mkdir -pv'
alias mv='mv -i'
alias p="pnpm"
alias px="pnpm dlx"
alias ping='ping -c 5'
alias psw='ps auxww'
alias ql='qlmanage -p 2>/dev/null'
alias rm='rm -i'
alias su='sudo -i'
alias tail="tail -f"
alias tmux="tmux -2"
alias wget='wget -c'
alias x="exit"  # don't want X-Quartz anyway ;)
alias x="exit"  # don't want X-Quartz anyway ;)

# ---
# common destinations
# ---

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cdbin="cd ${HOME}/bin"
alias cddev="cd ${DEVL_HOME}"

alias cdref="cd ${DEVL_HOME}/Reference"

# NB: depends on having cloned into ${HOME}/.dotfiles.
alias cdidearat='cd ${IDEARAT_HOME}'
alias cdforks='cd ${IDEARAT_HOME}/forks'
alias cdhello='cd ${HOME}/temporary/hello'
alias cdfluff='cd ${HOME}/temporary/fluffy'
alias cdzippy='cd ${HOME}/temporary/zippy'
alias cdsrc='cd /usr/local/src'
alias cdtmp="cd ${HOME}/temporary"
alias cdtri="cd ${HOME}/Documents/SS\ Docs/Triathlon"
alias cdusb="cd ${USB_ROOT}"

alias ang="cd ${HOME}/temporary/angular-quickstart"

# ---
# utility Aliases
# ---

alias hours="vim ~/DroppedBox/hours.md"
alias todo="vim ~/temporary/todo.md"
alias notes="vim ~/DroppedBox/notes.md"
alias more='less'

alias v="nvim-idea"
alias nv="nvim-idea"
alias vi='nvim-idea'
alias vim='nvim-idea'
alias lv=lvim

alias z="/opt/homebrew/etc/profile.d/z.sh"

alias lint="eslint .; jshint .";

alias finddir="find . -type d -maxdepth 1 | sort"

alias myip="curl ipv4.icanhazip.com"
# Show time/date in easy form.
alias now='date +"%T"'
alias nowtime='now'
alias nowdate='date +"%d-%m-%Y"'

alias rmorig="\\ls -a | grep '_orig$' | xargs -n 1 rm -rf"
alias rmzcomp="\\ls -a | grep 'zcompdump' | xargs -n 1 rm -rf"

alias server="http-server" # npm install -g http-server

# Output decent size information
alias sizes='du -s *'

# NB: this relies on vim config to put temp files in ${HOME}/temporary
alias swapped='find ${HOME}/temporary/vimswap -name '"'*.sw[opnm]'"' -print'

alias killcrash='sudo launchctl unload /Library/LaunchDaemons/com.code42.service.plist'
alias loadcrash='sudo launchctl load /Library/LaunchDaemons/com.code42.service.plist'

alias killsophos='sudo launchctl unload /Library/LaunchDaemons/com.sophos.common.servicemanager.plist'
alias loadsophos='sudo launchctl load /Library/LaunchDaemons/com.sophos.common.servicemanager.plist'

alias killjenkins="sudo launchctl unload /Library/LaunchDaemons/org.jenkins-ci.plist"

alias fixcamera='sudo killall VDCAssistant'
alias fixscreen='sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.screensharing.plist &&  sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.screensharing.plist'

alias unlock='rm -rf package-lock.json'

# ---
# utility functions
# ---

# Common prompting routine for querying the user with defaults for Y/N.
# Adapted for ZSH based on original at https://gist.github.com/1965569.
function ask () {
    local REPLY
    local prompt
    local default
    while [ -z $REPLY ]; do
        if [[ "${2:-}" = "Y" ]]; then
            prompt="Y/n"
            default="y"
        elif [[ "${2:-}" = "N" ]]; then
            prompt="y/N"
            default="n"
        else
            prompt="y/n"
            default=""
        fi

        read "REPLY?$1 [$prompt] "

        if [[ -z $REPLY ]]; then
          REPLY=$default
        fi
    done

    if [[ $REPLY = "y" ]]; then
      return 0
    elif [[ $REPLY = "n" ]]; then
      return 1
    fi
}

# Dump a list of any submodules which may have detached heads. This is necessary
# to avoid editing in a detached state, which effectively ensures your edits are
# a complete loss.
function detached () {
  local IFS_COPY=$IFS
  IFS=$'\n';
  data=($(git submodule foreach 'git status --branch --porcelain'))
  IFS=$IFS_COPY

  # Sample output...but note git output breaks at ' '
  # Entering 'vim/vim/bundle/vim-dispatch'
  # ## master...origin/master
  # Entering 'vim/vim/bundle/vim-fugitive'
  # ## HEAD (no branch)

  for line in $data; do
    if [[ $line =~ "^Entering" ]]; then
      repo=$line[11,-2]
    fi
    if [[ $line =~ "HEAD" ]]; then
      echo $repo
    fi
  done
}

# Test for existence of a command. used for cmd-specific setups later.
# NB: it appears ZSH does better at this than Bash when using 'which'.
function exists () {
  command -v "$@" &>/dev/null 2>&1
  if [[ $? -eq 0 ]]; then
    return 0
  else
    return 1
  fi
}

# Goal here is to get a list of files by name without junk from subversion or
# similar directory trees. Prune them (to avoid descent) and then remove the
# directory from the resulting file list via grep -v. Note the trailing sed
# line which handles filenames with blanks.
function findem () {
  find . -name .svn -prune -o -name .git -prune -o -name node_modules\
    -prune -o -iname "*$1*" -print 2<&1 | grep -v '\.svn' | grep -v '\.git$' |\
    grep -v 'node_modules' | grep -v 'thirdParty' |\
    grep -v 'Permission denied' | grep -v '\.sw[op]' |\
    grep -v '\.class' | grep -v '\.scssc' | grep -v '\.tap' | sed 's/\ /\\ /g'
}
alias findme=findem

# Regex-driven update of javascript-specific CTAGS data. Prunes nested levels of
# node_modules but allows for the first level so you can drill down into libs.
# Run this in the directory you want searched.
function jstags () {
  find . -name '*.js' | grep -v 'node_modules/.*/node_modules' | grep -v '\.min\.js' |\
  ctags -L - -R --langdef=js --langmap=js:.js \
  --regex-js="/(,|(;|^)[ \t]*(var|let|([A-Za-z_$][A-Za-z0-9_$.]+\.)*))[ \t]*([A-Za-z0-9_$]+)[ \t]*=[ \t]*\{/\5/,object/" \
  --regex-js="/(,|(;|^)[ \t]*(var|let|([A-Za-z_$][A-Za-z0-9_$.]+\.)*))[ \t]*([A-Za-z0-9_$]+)[ \t]*=[ \t]*function[ \t]*\(/\5/,function/" \
  --regex-js="/(,|(;|^)[ \t]*(var|let|([A-Za-z_$][A-Za-z0-9_$.]+\.)*))[ \t]*([A-Za-z0-9_$]+)[ \t]*=[ \t]*\[/\5/,array/" \
  --regex-js="/(,|(;|^)[ \t]*(var|let|([A-Za-z_$][A-Za-z0-9_$.]+\.)*))[ \t]*([A-Za-z0-9_$]+)[ \t]*=[ \t]*[^\"]'[^']*/\5/,string/" \
  --regex-js="/(,|(;|^)[ \t]*(var|let|([A-Za-z_$][A-Za-z0-9_$.]+\.)*))[ \t]*([A-Za-z0-9_$]+)[ \t]*=[ \t]*(true|false)/\5/,boolean/" \
  --regex-js="/(,|(;|^)[ \t]*(var|let|([A-Za-z_$][A-Za-z0-9_$.]+\.)*))[ \t]*([A-Za-z0-9_$]+)[ \t]*=[ \t]*[0-9]+/\5/,number/" \
  --regex-js="/(,|(;|^)[ \t]*(var|let|([A-Za-z_$][A-Za-z0-9_$.]+\.)*))[ \t]*([A-Za-z0-9_$]+)[ \t]*=[ \t]*.+([,;=]|$)/\5/,variable/" \
  --regex-js="/(,|(;|^)[ \t]*(var|let|([A-Za-z_$][A-Za-z0-9_$.]+\.)*))[ \t]*([A-Za-z0-9_$]+)[ \t]*[ \t]*([,;]|$)/\5/,variable/" \
  --regex-js="/function[ \t]+([A-Za-z0-9_$]+)[ \t]*\([^)]*\)/\1/,function/" \
  --regex-js="/(,|^)[ \t]*([A-Za-z_$][A-Za-z0-9_$]+)[ \t]*:[ \t]*\{/\2/,object/" \
  --regex-js="/(,|^)[ \t]*([A-Za-z_$][A-Za-z0-9_$]+)[ \t]*:[ \t]*function[ \t]*\(/\2/,function/" \
  --regex-js="/(,|^)[ \t]*([A-Za-z_$][A-Za-z0-9_$]+)[ \t]*:[ \t]*\[/\2/,array/" \
  --regex-js="/(,|^)[ \t]*([A-Za-z_$][A-Za-z0-9_$]+)[ \t]*:[ \t]*[^\"]'[^']*/\2/,string/" \
  --regex-js="/(,|^)[ \t]*([A-Za-z_$][A-Za-z0-9_$]+)[ \t]*:[ \t]*(true|false)/\2/,boolean/" \
  --regex-js="/(,|^)[ \t]*([A-Za-z_$][A-Za-z0-9_$]+)[ \t]*:[ \t]*[0-9]+/\2/,number/" \
  --regex-js="/(,|^)[ \t]*([A-Za-z_$][A-Za-z0-9_$]+)[ \t]*:[ \t]*[^=]+([,;]|$)/\2/,variable/" \
  "$@"
}

# Interactively kill listener processes. Often needed when shutting down
# certain systems whose sub-processes don't always die cleanly. I'm looking at
# you Java.
function killem () {
  local IFS_COPY=$IFS
  IFS=$'\n';
  procs=( $(listeners "$*") )
  IFS=$IFS_COPY

  local last=''
  for line in $procs; do
    local pid=$(echo $line | awk '{print $2}')
    local ident=$(echo $line | awk '{print ("  ", $1, "(", $2, ")") }')
    if [[ $pid -eq $last ]]; then
      continue
    fi

    echo -e $line
    last=$pid
    ask "kill -9 $ident ?" N;
    if [[ $? -eq 0 ]]; then
      kill -9 $pid
    fi
  done
}

# List all processes that are listening on ports. Useful for debugging
# EADDRINUSE errors. Leveraged by killem() to provide input for kill.
function listeners () {
  local cmd='lsof -i -n -P | grep -i "listen"'
  if [[ $# > 0 ]];  then
    cmd="$cmd | grep \"$*\""
  fi
  eval $cmd
}

# Dump link (if found) for a particular pattern (if no params shows all).
function lnks () {
  ls -la | grep " ->" | grep "$*" | awk '{print $9, $10, $11}'
}

# Dump path list split on ':' so it's readable as an ordered list.
function paths () {
  echo ${PATH} | awk 'BEGIN{RS=":";} {print;}'
}

# Dump the real version of a command being run. This is 'which' but it will
# traverse at least one link level to point to a true target executable.
function real () {
  local src=`which $*`
  src=$(ls -al $src | grep "\->" | grep "$*" | awk '{print $9, $10, $11}')
  if [[ ${#src} -ne 0 ]]; then
    echo $src
  else
    which "$@"
  fi
}

# Find a directory containing a specific file. Useful for locating a "starting
# directory" for various operations within project directories like linting.
function root () {
  file="$1"
  dir=$PWD
  while [[ $dir != '/' ]]; do
    if [[ -e $dir/$file ]]; then
      echo $dir
      break
    else
      dir=`dirname $dir`
    fi
  done
}

# Update submodules, bringing then back onto master branch and sync'ing.
function subup () {
  echo 'Updating git submodules...'
  git submodule init
  git submodule update --recursive --force
  git submodule foreach 'git fetch origin; git checkout master; git pull'
}

# Test for existence of a varable/export.
function varexists () {
  local VAR
  eval 'VAR=${'"$*"'}'
  if [[ -z $VAR ]]; then
    return 1
  fi
  return 0
}

# ---
# PATH-sensitive installations
# ---

# Now that our path is complete we can test for existence of various tools and
# install customizations/extensions as appropriate.


# Warn if we haven't got brew installed. We use it to install most everything
# else.
if ! exists brew; then
  echo 'brew not found'
  echo 'install brew via:'; echo
  echo 'ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"'
else
  # TODO: do we want brew doctor here?
fi

# Ack for common file types in web development.
if exists ack; then
  # in theory this filter works: ack -g '^((?!TIBET-INF\/tibet).)*$' | ack -x *$
  alias ack='ack --ignore-dir lib/src --ignore-dir deps --ignore-dir thirdParty --ignore-dir .sass-cache --ignore-dir build --ignore-dir TIBET-INF/tibet/lib/src --ignore-dir TIBET-INF/tibet/deps --ignore-dir TIBET-INF/tibet/build --ignore-dir node_modules --ignore-dir .next --ignore-dir tibet-lama-extension'
  alias ackls='ack -l -s --ignore-file=ext:map'
  alias ackall='ack -l -s --nolog --ignore-file=ext:map'
  alias ackit='ack -l -s --nolog --ignore-file=ext:map --ignore-dir TIBET-INF/tibet'
  alias ackcss='ack -l -s --css --sass --less'
  alias ackhtml='ack -l -s --html'
  alias ackjs='ack -l -s --js'
  alias ackjsish='ack -l -s --js --json'
  alias ackjson='ack -l -s --json'
  alias ackmd='ack -l -s --markdown'
  alias ackxml='ack -l -s --xml'
  alias ackvim='ack -l -s --vim'
else
  echo 'ack not found'
  echo 'install ack via:';echo
  echo 'brew install ack'
fi

# Docker and Docker Compose
if exists docker; then
  alias d='docker'
  alias dps='docker ps'
  alias dc='docker-compose'
  alias dce='docker-compose exec'
  alias dcr='docker-compose run'
fi
alias ldocker='lazydocker'

if exists kubectl; then
  alias k="kubectl"
fi
alias lk='lazykube'

# Git, and if that's not here, well, that's curious :)
if exists git; then
  alias gb="git branch"
  alias gba="git branch -a"
  alias gd='git diff --name-status HEAD..master'
  alias moo="git moo"
  alias gm="moo"
  alias gs='git status --short --branch'
  alias gsl='git stash list'
  alias gtt='git log --oneline --graph --all --date-order --first-parent --decorate=short --simplify-by-decoration'
  alias glb="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
  alias gl="git log --graph --all --oneline --decorate --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"

  # Display the files which are considered changed in any form.
  function changed () {
    git status --short | awk '{print $2}'
  }

  # ---
  # prompt
  # ---

  c_cyan=`tput setaf 6`
  c_red=`tput setaf 1`
  c_green=`tput setaf 2`
  c_sgr0=`tput sgr0`

  function trim_pwd ()
  {
    #   How many characters of the $PWD should be kept
    local pwdmaxlen=20
    #   Indicator that there has been directory truncation:
    #trunc_symbol="<"
    local trunc_symbol='...'
    if [[ ${#PWD} -gt $pwdmaxlen ]]; then
      local pwdoffset=$(( ${#PWD} - $pwdmaxlen ))
      newPWD="${trunc_symbol}${PWD:$pwdoffset:$pwdmaxlen}"
    else
      newPWD=${PWD}
    fi
    echo $newPWD
  }

  function parse_git_branch ()
  {
    if git rev-parse --git-dir >/dev/null 2>&1; then
      gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
    else
      return 0
    fi
    echo -e $gitver
  }

  function parse_git_user ()
  {
    if git rev-parse --git-dir >/dev/null 2>&1; then
          gitusr=$(git config user.name)
    else
      return 0
    fi
    echo -e $gitusr
  }

  function branch_color ()
  {
    if git rev-parse --git-dir >/dev/null 2>&1; then
      color=''
      if git diff --quiet 2>/dev/null >&2; then
        color="${c_green}"
      else
        color="${c_red}"
      fi
    else
      return 0
    fi
    echo -ne $color
  }

  export PS1='$(parse_git_user) [\[$(branch_color)\]$(parse_git_branch)\[${c_sgr0}\]] \[${c_red}\]$(trim_pwd)\[${c_sgr0}\] $ '
else
  echo 'git not found'
  echo 'install git via:';echo
  echo 'brew install git'
fi

# Go
if exists gvm; then
  gvm use go1.21.4
fi

# Node. Need this to install JS-related packages like JSHint etc.

# test for nvm and initialize it if found
if exists nvm; then
  nvm use --silent v18

  export NODE_VERSION=`node --version`
  alias cdnvm="cd ${NVM_DIR}/versions/node/${NODE_VERSION}/lib/node_modules"
fi

if ! exists node; then
  echo 'node not found'
  echo 'install node via:';echo
  echo 'nvm install {version}'
  echo 'install nvm from https://github.com/creationix/nvm'
fi

# OpenSSL
if exists openssl; then
  alias sha1='openssl sha1'
else
  echo 'openssl not found'
  echo 'install openssl via:';echo
  echo 'brew install openssl'
fi

# Perl
if exists perl; then
  # convert line-endings. probably an easier way now tho.
  alias fixcm="perl -ne 's/\cM/\n/g; print'"
  alias fixdos="perl -ne 's/\cM\cJ/\n/g; print'"
  alias fixmac="perl -ne 's/\cM/\n/g; print'"

  if exists wc.pl; then
    function loc () {
      find . -name "$*" -exec wc {} \; | wc.pl
    }
  fi
else
  echo 'perl not found'
  echo 'install perlbrew via:'; echo
  echo 'curl -kL http://install.perlbrew.pl | bash'
  echo 'source ${HOME}/perl5/perlbrew/etc/bashrc'
  echo 'perlbrew'
fi

# Python
if ! exists pyenv; then
  echo 'pyenv not found'
  echo 'install pyenv via:';echo
  echo 'brew install pyenv'
  echo 'see https://github.com/pyenv/pyenv'
fi

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

export PATH=${PYENV_ROOT}/shims:$PATH

if ! exists python; then
  echo 'python not found'
  echo 'install python via:'; echo
  echo 'pyenv install '
fi

# Console Vim
if exists vim; then

  # neovim
  export VIMRUNTIME="/opt/homebrew/share/nvim/runtime"

   # classic vim
#  if [[ -e /opt/homebrew/share/vim ]]; then
#    export VIMRUNTIME="/opt/homebrew/share/vim/vim90"
#  else
#    if [[ -e /opt/share/vim ]]; then
#      export VIMRUNTIME="/opt/share/vim/vim90"
#    fi
#  fi

  export VISUAL=vim

  # Turn off flow control. This lets VIM have better access to these keys.
  stty start undef stop undef 2> /dev/null
else
  echo 'vim not found'
  echo 'install vim via:';echo
  echo 'brew install macvim --override-system-vim'
fi

# TODO: clean up a combination of GCL and JSHint
# Google Closure Linter
if exists gjslint; then
  alias glint="gjslint --jslint_error optional_type_marker,well_formed_author,\
    no_braces_around_inherit_doc,braces_around_type,blank_lines_at_top_level\
    --additional_extensions 'mu' --custom_jsdoc_tags=module,submodule,namespace"

  alias tlint="gjslint --jslint_error optional_type_marker,well_formed_author,\
    no_braces_around_inherit_doc,braces_around_type,blank_lines_at_top_level\
    --custom_jsdoc_tags=name,synopsis,description,example,returns,todo"
#else
#  echo 'gjslint not found'
#  echo 'install gjslint via:';echo
#  echo 'cd /usr/local/src'
#  echo 'svn checkout http://closure-linter.googlecode.com/svn/trunk/ closure-linter-read-only';
#  echo 'cd closure-linter-read-only'
#  echo 'python ./setup.py install'
fi

# TODO: write something that actually works. This doesn't really work.
# relativize a path. $1 is the root, $2 is the path to relativize
function relative () {
  echo $2 | sed "s@$1@.@g"
}

# Lint just the files which have changed since the last commit. Designed to be
# run from anywhere within the project so you don't have to CD around.
function hintem () {
  # find the directory at/above us with the .git directory
  dir=$(root '.git')
  pushd $dir &>/dev/null

  # look for custom lint (for increased strictness hopefully ;))
  if [[ -e .jshintrc_local ]]; then
    rules='.jshintrc_local'
  else
    rules='.jshintrc'
  fi

  files=`git diff --name-only master | grep --color=never '\.js'`
  for f in $files; do
    echo "----- jshint --config $rules $f -----"
    jshint --config $rules $f
  done
  popd &>/dev/null
}

# Google Closure Linter, minus things we'll rely on from jshint settings or
# which are effectively non-bug/style concerns.
function glintem () {
  # find the directory at/above us with the .git directory
  dir=$(root '.git')
  pushd $dir &>/dev/null

  files=`git diff --name-only master | grep --color=never '\.js'`
  for f in $files; do
    glint $f | grep -v "Extra space after \"function" | grep -v "Line too long" | grep -v "Single-quoted string"
  done
  popd &>/dev/null
}

# Run both jshint and google's linter to get a complete picture.
alias lintem="hintem; glintem"

# ---
# /Applications
# ---

# Chrome
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --disable-web-security --allow-file-access-from-files --user-data-dir=/tmp/user-data-dir"
alias cleanroom="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --disable-web-security --allow-file-access-from-files --user-data-dir=/tmp/user-data-dir"
alias canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary --disable-web-security --allow-file-access-from-files --user-data-dir=/tmp/user-data-dir"


# TODO: convert to something we can run from Alfred
[[ -e '/Applications/Marked.app/Contents/MacOS/Marked' ]] && \
  alias marked='/Applications/Marked.app/Contents/MacOS/Marked &'

# ---
# tool-specific vars
# ---

alias lnpm='lazynpm'

# ---
# git
# ---

lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}
alias lgit='lg'

# ---
# java
# ---

if exists ant; then
  export ANT_HOME="$(which ant)"
  export ANT_OPTS="-Xmx512M -Xss5120k"
fi

# java
# TODO: check for libexec, and java
export JAVA_HOME="$(/usr/libexec/java_home)"
export JRE="$(/usr/libexec/java_home)"
export JAVA_OPTS="-Xmx256m"

export CLASSPATH="~/etc/*.jar;${CLASSPATH}"

export ANDROID_HOME="${HOME}/Library/Android/sdk"
export PATH="$GOPATH/bin:${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/build-tools/25.0.2"

export SCALA_HOME="/usr/local/share/scala"

# NB: This is a tab
export XMLLINT_INDENT="	"

# TODO: requires installation of the closure compiler jar file
alias gjscomp="java -D=/usr/local/src/compiler-latest/ -jar compiler.jar"

# TODO: requires installation of Mozilla JavaScript-in-JVM project.
alias rhino="java org.mozilla.javascript.tools.shell.Main"

# TODO: these require installation of selenium
alias selenium_firefox="java -Dwebdriver.firefox.profile=default\
  -jar /usr/local/src/selenium/selenium-server-standalone-2.25.0.jar"
alias selenium_chrome="java -Dwebdriver.chrome.profile=default\
  -jar /usr/local/src/selenium/selenium-server-standalone-2.25.0.jar"

# TODO: this requires installation of xalan
alias xalan="java org.apache.xalan.xslt.Process"

# ---
# javascript
# ---

# Mac JavaScript interpreter from WebKit
alias jsc="/System/Library/Frameworks/JavaScriptCore.\
framework/Versions/A/Resources/jsc"

# ---
# puppeteer
# ---

export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=`which chromium`

# ---
# ruby
# ---

export RAILS_ENV="development"

# ---
# nvim
# ---

# per https://github.com/elijahmanor/dotfiles/blob/master/zsh/.zshrc
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-idea="NVIM_APPNAME=idearat nvim"
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
function nvims() {
  items=("clean" "AstroNvim" "idearat" "LazyVim" "LunarVim" "NvChad")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  cmd="nvim"
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "LunarVim" ]]; then
    config=""
    cmd="lvim"
  elif [[ $config == "clean" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config $cmd $@
}
bindkey -s  "nvims\n"

# ---
# ss
# ---

alias ssbod="pushd ${HOME}/dev/idearat/big7; ./ssbod.js; popd"
function sslbs () {
  # note use of $@ here to send 'unrolled' params.
  pushd ${HOME}/dev/idearat/big7 > /dev/null 2>&1; ./sslbs.js "$@"; popd > /dev/null 2>&1;
}
function ssmet () {
  # note use of $@ here to send 'unrolled' params.
  pushd ${HOME}/dev/idearat/big7 > /dev/null 2>&1; ./ssmet.js "$@"; popd > /dev/null 2>&1;
}

# ---
# mac stuff
# ---

alias show_hidden="defaults write com.apple.Finder AppleShowAllFiles YES && killall Finder"
alias hide_hidden="defaults write com.apple.Finder AppleShowAllFiles NO && killall Finder"

# ---
# other rc files
# ---

[[ -s ${HOME}/.localrc ]] && source ${HOME}/.localrc > /dev/null 2>&1
[[ -s ${HOME}/.tibetrc ]] && source ${HOME}/.tibetrc > /dev/null 2>&1

# airline-promptline shell prompt file, if used.
[[ -s ${HOME}/.shell_prompt.sh ]] && source ${HOME}/.shell_prompt.sh > /dev/null 2>&1

#source ~/Dropbox/zsh.localrc > /dev/null 2>&1

export PATH="$PATH:$SCALA_HOME/bin"

# Only show the current directory's name in the tab
export DISABLE_AUTO_TITLE="true"
function precmd() {
  print -Pn "\e]1;${PWD##*/}\a"
}

# colormap for powerlevel10k
function colormap() {
  for i in {0..255};
    do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'};
  done
}

export ENABLE_FLUTTER_DESKTOP=true

export BAT_THEME="Coldark-Dark"

source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme > /dev/null 2>&1
