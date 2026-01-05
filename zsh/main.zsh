# primary zsh customizations
#

# ---
# zshrc edit / reload
# ---

alias srcit='source ~/.zshrc'
alias vimit='vim ~/.dotfiles/zsh/main.zsh'

# ---
# path roots
# ---

# Rebuild "user" path to inject PG and other custom elements into full path.
# NOTE: base and post are defined in ~/.zshrc
export PATH_USER="opt/homebrew/opt/postgresql@15/bin:/usr/local/bin/araxis:${HOME}/.natster/bin"
export PATH="${PATH_BASE}:${PATH_USER}:${PATH_POST}"


export MANPATH=".:${HOME}/man:/usr/local/man:/usr/local/share/man:/usr/man:\
  /usr/bin/man:/usr/share/man:/usr/share/locale/en/man:/usr/X11R6/man"

export DEVL_HOME="${HOME}/dev"
export NGINX_HOME="/usr/local/etc/nginx"

export GOBIN="${HOME}/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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
export IGNOREEOF=1
export LAUNCH_EDITOR='code'
export LC_TYPE='en_US.UTF-8'
export LESS=FRSX
export LSCOLORS='gxgxfxfxcxdxdxhbadbxbx'
export LS_OPTIONS='--color=auto'
export REPORTTIME=10
export TERM=xterm-256color

# ---
# history setup
# ---

HISTFILE=${HOME}/.zhistory
HISTSIZE=SAVEHIST=10000
HISTCONTROL=erasedups

# ---
# config files
# ---

alias cdconfig="cd ${HOME}/.config"
alias cddot="cd ${HOME}/.dotfiles"

alias vimdot="vi ${HOME}/.dotfiles/install.sh"
alias vimgit="vi ${HOME}/.gitconfig"
alias vimng="vi /usr/local/etc/nginx/nginx.conf"
alias vimtmux="vi ${HOME}/.tmux.conf"

alias vimvi="vi ${HOME}/.vimrc.after"
alias vimvilocal="vi ${HOME}/.vimrc.local"

# ---
# common flags
# ---

alias bc='bc -l'
alias cl='clear'
alias cls='clear; ls'
#alias cp='cp -i'
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
#alias ln='ln -i'
alias ls='ls -H'
alias lsd='ls -laFh **/**'
alias lynx='lynx -vikeys'
alias md5='md5 -r'
alias md5sum='md5 -r'
alias mkdir='mkdir -pv'
#alias mv='mv -i'
alias ping='ping -c 5'
alias psw='ps auxww'
alias ql='qlmanage -p 2>/dev/null'
#alias rm='rm -i'
alias su='sudo -i'
#alias tail="tail -f"
alias wget='wget -c'

# ---
# remappings
# ---

alias more='less'
alias x="exit"  # don't want X-Quartz anyway ;)

# ---
# common destinations
# ---

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias cdbin="cd ${HOME}/bin"
alias cddev="cd ${DEVL_HOME}"
alias cdtmp="cd ${HOME}/temporary"
alias cdtools="cd ${DEVL_HOME}/tools"


cx() { cd "$@" && l; }

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
  \ls -la | grep " ->" | grep "$*" | awk '{print $9, $10, $11}'
}

# Dump path list split on ':' so it's readable as an ordered list.
function paths () {
  echo ${PATH} | awk 'BEGIN{RS=":";} {print;}'
}

# Dump the real version of a command being run. This is 'which' but it will
# traverse at least one link level to point to a true target executable.
function real () {
  local src=`which $*`
  src=$(\ls -al $src | grep "\->" | grep "$*" | awk '{print $9, $10, $11}')
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

# test for various tools and install customizations/extensions as appropriate.

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

# AG for common file types in web development.
if exists ag; then
  alias ag='ag --ignore-dir lib/src --ignore-dir deps --ignore-dir thirdParty --ignore-dir .sass-cache --ignore-dir build --ignore-dir TIBET-INF/tibet/lib/src --ignore-dir TIBET-INF/tibet/deps --ignore-dir TIBET-INF/tibet/build --ignore-dir node_modules --ignore-dir .next --ignore-dir tibet-lama-extension'
  alias agls='ag -l -s --ignore-file=ext:map'
  alias agall='ag -l -s --nolog --ignore-file=ext:map'
  alias agit='ag -l -s --nolog --ignore-file=ext:map --ignore-dir TIBET-INF/tibet'
  alias agcss='ag -l -s --css --sass --less'
  alias aghtml='ag -l -s --html'
  alias agjs='ag -l -s --js'
  alias agjsish='ag -l -s --js --json'
  alias agjson='ag -l -s --json'
  alias agmd='ag -l -s --markdown'
  alias agxml='ag -l -s --xml'
  alias agvim='ag -l -s --vim'
else
  echo 'ag not found'
  echo 'install ag via:';echo
  echo 'brew install the_silver_searcher'
fi

if exists bat; then
  export BAT_THEME="Coldark-Dark"
  alias cat='bat'
fi

# Deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Docker and Docker Compose
if exists docker; then
  alias dc='docker-compose'
  alias dce='docker-compose exec'
  alias dcr='docker-compose run'
  alias de="docker exec -it"
  alias dl="docker ps -l -q"
  alias dpa="docker ps -a"
  alias dps="docker ps"
fi

if exists eza; then
  alias l1="eza -1 --icons --git"
  alias l1a="eza -1 --icons --git"
  alias l="eza --icons --git"
  alias la="eza --icons --git -a"
  alias ll="eza -l --icons --git"
  alias lla="eza -l --icons --git -a"
  alias lt="eza --tree --level=2 --long --icons --git"
else
  alias l1='ls -C1'
  alias l1a='ls -C1 -a'
  alias l='ls -Fh'
  alias la='ls -aFh'
  alias ll='ls -lFh'
  alias lla='ls -laFh'
fi

if exists fzf; then
  export FZF_COMPLETION_TRIGGER='**'
  export FZF_DEFAULT_COMMAND='ag --hidden -l'

  fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && pwd && l; }
  f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
  fvi() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }
fi

# Git, and if that's not here, well, that's curious :)
if exists git; then
  alias ga='git add'
  alias gaa='git add -all'
  alias gb='git branch'
  alias gba="git branch -a"
  alias gc="git commit -m"
  alias gca="git commit -a -m"
  alias gcb="git checkout -b"
  alias gco="git checkout"
  alias gd="git diff"
  alias gl="git log --graph --all --oneline --decorate --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
  alias glb="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
  alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
  alias gp="git push"
  alias gpu="git push origin"
  alias gph="git push origin HEAD"
  alias gl="git pull"
  alias gpl="git pull origin"
  alias gr='git remote'
  alias gs='git status --short --branch'
  alias gsl='git stash list'
  alias gtt='git log --oneline --graph --all --date-order --first-parent --decorate=short --simplify-by-decoration'

  alias gm="moo"
  alias moo="git moo"

  # Display the files which are considered changed in any form.
  function changed () {
    git status --short | awk '{print $2}'
  }

  # Update submodules, bringing then back onto master branch and sync'ing.
  function subup () {
    echo 'Updating git submodules...'
    git submodule update --init --recursive
    git submodule update --remote --merge
  }

else
  echo 'git not found'
  echo 'install git via:';echo
  echo 'brew install git'
fi

# ---
# vfox (runtime management for nodejs, golang, etc)
# ---

# if exists vfox; then
#   eval "$(vfox activate zsh)"
#
#   vfox use golang@1.22.5
#   vfox use nodejs@20.15.0
# fi
#
# Go
# source ~/.gvm/scripts/gvm > /dev/null 2>&1
# if exists gvm; then
#   gvm use go1.24.0 > /dev/null 2>&1
# fi

# asdf (tool version manager for Golang et. al.)
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
asdf set golang 1.25.0

if exists kubectl; then
  export KUBECONFIG=~/.kube/config
  alias k="kubectl"
  alias ka="kubectl apply -f"
  alias kg="kubectl get"
  alias kd="kubectl describe"
  alias kdel="kubectl delete"
  alias kl="kubectl logs"
  alias kgpo="kubectl get pod"
  alias kgd="kubectl get deployments"
  alias kc="kubectx"
  alias kns="kubens"
  alias kl="kubectl logs -f"
  alias ke="kubectl exec -it"
  alias kcns='kubectl config set-context --current --namespace'
  alias podname=''
fi

if exists lazydocker; then
  alias ldocker='lazydocker'
else
  echo 'lazydocker not found'
  echo 'install lazydocker via:';echo
  echo 'brew install jesseduffield/lazydocker/lazydocker'
fi

if exists lazygit; then
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
else
  echo 'lazygit not found'
  echo 'install lazygit via:';echo
  echo 'brew install jesseduffield/lazygit/lazygit'
fi

if exists lazykube; then
  alias lkube='lazykube'
else
  echo 'lazykube not found'
  echo 'install lazykube via:';echo
  echo 'brew install tnk-studio/tools/lazykube'
fi

if exists lazynpm; then
  alias lnpm='lazynpm'
else
  echo 'lazynpm not found'
  echo 'install lazynpm via:';echo
  echo 'brew install jesseduffield/lazynpm/lazynpm'
fi

if exists local-ai; then
  export MODELS_PATH="${HOME}/.dotfiles/ai/local_ai/models/"
fi

# Node. Need this to install JS-related packages like JSHint etc.

# test for nvm and initialize it if found
if exists nvm; then
  source ~/.nvm/nvm.sh > /dev/null 2>&1

  nvm use --silent v24

  export NODE_VERSION=`node --version`
  alias cdnvm="cd ${NVM_DIR}/versions/node/${NODE_VERSION}/lib/node_modules"
fi

if ! exists node; then
  echo 'node not found'
  echo 'install node via:';echo
  echo 'nvm install {version}'
  echo 'install nvm from https://github.com/creationix/nvm'
fi

if exists nvim; then

  # neovim
  export VIMRUNTIME="/opt/homebrew/share/nvim/runtime"
  export VISUAL=nvim

  export NVIM_DIR="$HOME/.dotfiles/nvim/astronvim_v4"
  alias cdnvim="cd ${NVIM_DIR}"
  alias vimnvim="vi ${NVIM_DIR}"

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

  alias v='nvim-astro'

  # Turn off flow control. This lets VIM have better access to these keys.
  stty start undef stop undef 2> /dev/null
else
  echo 'nvim not found'
  echo 'install nvim via:';echo
  echo 'brew install neovim'
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
if exists pyenv; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH=${PYENV_ROOT}/shims:$PATH

  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"

  pyenv global 3.10.6 2.7.18
else
  echo 'pyenv not found'
  echo 'install pyenv via:';echo
  echo 'brew install pyenv'
  echo 'see https://github.com/pyenv/pyenv'
fi

if ! exists python; then
  echo 'python not found'
  echo 'install python via:'; echo
  echo 'pyenv install '
fi

if exists ranger; then
  alias rr="ranger"
else
  echo 'ranger not found'
  echo 'install ranger via:';echo
  echo 'brew install ranger'
echo
fi

if exists rg; then
  alias rgu="rg -uuu"
else
  echo 'ripgrep not found'
  echo 'install ripgrep via:';echo
  echo 'brew install ripgrep'
fi

# Rust
if exists cargo; then
  source "$HOME/.cargo/env" > /dev/null 2>&1
fi

if exists tree; then
  alias t="tree"
else
  echo 'tree not found'
  echo 'install tree via:';echo
  echo 'brew install tree'
fi

# HTTP requests with xh!
if exists xh; then
  alias http="xh"
else
  echo 'xh not found'
  echo 'install xh via:';echo
  echo 'brew install xh'
fi

# ---
# /Applications
# ---

# Chrome
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --disable-web-security --allow-file-access-from-files --user-data-dir=/tmp/user-data-dir"
alias cleanroom="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --disable-web-security --allow-file-access-from-files --user-data-dir=/tmp/user-data-dir"
alias canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary --disable-web-security --allow-file-access-from-files --user-data-dir=/tmp/user-data-dir"

if exists '/Applications/iTerm2v3.app/Contents/MacOS/iTerm2'; then
  alias tm="tmux -CC"
  alias tma="tmux -CC attach"
fi

# Marked 2
if exists '/Applications/Marked 2.app/Contents/MacOS/Marked 2'; then
  alias marked='"/Applications/Marked 2.app/Contents/MacOS/Marked 2" &'
  alias m2='marked'
fi

# ---
# java
# ---

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
# nats
# ---


# ---
# ruby
# ---

export RAILS_ENV="development"

# ---
# rust
# ---

alias dh_view="open ${HOME}/dev/tools/valgrind/dhat/dh_view.html"

# ---
# vi / vim / nvim
# ---

alias v4="NVIM_APPNAME=AstroNvim nvim"

alias v='nvim-astro'
alias vi='v'
alias vim='v'

alias vimvi="vi ${HOME}/.vimrc.after"
alias vimvilocal="vi ${HOME}/.vimrc.local"
alias vimlocal="vi ${HOME}/.localrc"
alias vimcolor="vi ${HOME}/.vim/bundle/idearat/colors/idearat"
alias vimsyntax="vi ${HOME}/.vim/bundle/idearat/syntax/javascript.vim"

# ---
# mac stuff
# ---

alias show_hidden="defaults write com.apple.Finder AppleShowAllFiles YES && killall Finder"
alias hide_hidden="defaults write com.apple.Finder AppleShowAllFiles NO && killall Finder"

# ---
# utility aliases
# ---

alias finddir="find . -type d -maxdepth 1 | sort"

alias myip="curl ipv4.icanhazip.com"

# Show time/date in easy form.
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'
alias nowtime='now'

alias server="http-server" # npm install -g http-server

# Output decent size information
alias sizes='du -s *'

# NB: this relies on vim config to put temp files in ${HOME}/temporary
alias swapped='find ${HOME}/temporary/vimswap -name '"'*.sw[opnm]'"' -print'

alias unlock='rm -rf package-lock.json'

# ---
# other rc files
# ---

eval "$(zoxide init zsh)"

[[ -s ./windsurf.zsh ]] && source ./windsurf.zsh > /dev/null 2>&1

[[ -s ${HOME}/.tibetrc ]] && source ${HOME}/.tibetrc > /dev/null 2>&1
[[ -s ${HOME}/.localrc ]] && source ${HOME}/.localrc > /dev/null 2>&1

# Only show the current directory's name in the tab
export DISABLE_AUTO_TITLE="true"
function precmd() {
  print -Pn "\e]1;${PWD##*/}\a"
}

# ---
# autocompletion
# ---

ZSH_AUTOSUGGEST_STRATEGY=(history)

# NOTE: we do this late in the file to avoid conflicts with other settings.
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# bindkey '^w' autosuggest-execute    # originally backward-kill-word
bindkey '^e' autosuggest-accept     # originally end-of-line
bindkey '^j' down-line-or-search    # originally accept-line
bindkey '^k' up-line-or-search      # originally self-insert
bindkey '^l' vi-forward-word        # originally clear-screen

# NOTE: C-y is one of only a few keys that'll also work within vim for this.
# and using iTerm2 to map C-CR to send 0x19 means we can use C-CR to complete.
bindkey '^y' autosuggest-execute    # originally self-insert

# ---
# Databases
# ---

export MYSQL_HOME="/opt/homebrew/Cellar/mysql/9.0.1"
# export MYSQL_HOME="/opt/homebrew/Cellar/mysql@8.0/8.0.39_1"
export MYSQL_BIN="${MYSQL_HOME}/bin"

alias mysqlstart="${MYSQL_BIN}/mysql.server start"
alias mysqlstop="${MYSQL_BIN}/mysql.server stop"
alias mysqlrestart="${MYSQL_BIN}/mysql.server restart"
alias mysqlstatus="${MYSQL_BIN}/mysql.server status"

export PATH=${PATH}:${MYSQL_BIN}

# ---
# AI
# ---

# Claude Code - Using macOS Keychain (no fingerprint prompts!)
alias anthrokey='export ANTHROPIC_API_KEY=$(security find-generic-password -s anthropic-api -w 2>/dev/null)'
alias claudekey='export CLAUDE_CODE_OAUTH_TOKEN=$(security find-generic-password -s claude-oauth -w 2>/dev/null)'
anthrokey
claudekey

# Gemini CLI
export GOOGLE_CLOUD_PROJECT="coderats"

# mods (Charm)

if exists mods; then
  alias aikey='export OPENAI_API_KEY=$(security find-generic-password -s openai-api -w 2>/dev/null)'
  alias aikeyclear="unset OPENAI_API_KEY"
  alias openai="aikey && mods --model gpt-4"
else
  echo 'mods not found'
  echo 'install mods via:';echo
  echo 'brew install charmbracelet/tap/mods'
  echo '(see: https://github.com/charmbracelet/mods)'
fi

# ---
# if it's below this it's probably injected by some install script :)
# ---

