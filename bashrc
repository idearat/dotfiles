#!/bin/bash

#	---
#	shell options
#	---

set -o noclobber
set -o ignoreeof
set -o vi
shopt -s checkwinsize
shopt -s histappend

#	---
#	exports
#	---

export IGNOREEOF=1

#	terminal type
export TERM=xterm-color

#	history
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTCONTROL=ignoredups:ignorespace

#	localization
export LC_TYPE="en_US.UTF-8"

#	ant
export ANT_HOME="/usr/local/ant"
export ANT_OPTS="-Xmx256m"

#	apache
export APACHE_HOME="/opt/local/apache2"

#	java
export JAVA_HOME="/Library/Java/Home"
export JAVA_OPTS="-Xmx256m"

#	mysql
export MYSQL_HOME="/opt/local/lib/mysql5/"

#	RAILS
export RAILS_ENV="development"

#	R
export R_HOME="/opt/local/bin/R"

#	vi(m) setup
export VISUAL=vim
export SVN_EDITOR=vim
export VIMRUNTIME="/opt/local/share/vim/vim73"

#	XML lint config
#	NB: This is a tab
export XMLLINT_INDENT="	"

#	paths
export MANPATH=".:$HOME/man:/usr/local/man:/usr/local/share/man:/usr/man:/usr/bin/man:/usr/share/man:/usr/share/locale/en/man:/usr/X11R6/man"
export PATH=".:$HOME/bin:$HOME/.rvm/rubies/default/bin:/usr/local/bin:/usr/bin:/opt/local/bin:/opt/local/sbin:${MYSQL_HOME}/bin:/usr/local/git/bin:/usr/local/node/bin:/opt/subversion/bin:/usr/local/bin:/usr/bin:/Applications:/Applications/Araxis/Utilities:/usr/local/ant/bin:/usr/local/jdk/bin:/bin:/usr/X11R6/bin:/usr/sbin:/sbin:/sw/bin"
export PYTHONPATH=".:/usr/local/lib/python:/usr/lib/python"

#	---
#	aliases
#	---

#	bash environment management
alias vimit="vi $HOME/.bashrc"
alias srcit="source $HOME/.bashrc"

#	cd directory aliases
alias cdbin="cd $HOME/bin"
alias cddev="cd /usr/local/src/claremont"
alias cdra="cd /usr/local/src/claremont/rails-app"
alias cddown="cd ${HOME}/Downloads"
alias cdsrc="cd /usr/local/src"
alias cdtmp="cd $HOME/tmp"

alias cdapache="cd ${APACHE_HOME}"
alias cdcgi="cd ${APACHE_HOME}/cgi-bin"
alias cdhtml="cd ${APACHE_HOME}/htdocs"

alias cdmysql="cd ${MYSQL_HOME}"

alias closure="cd /usr/local/src/closure-library/closure/goog"
alias jquery="cd /usr/local/src/jquery"

#	command alternatives
alias cls=clear
alias cp="cp -i"
alias cvs="cvs -z9"
alias ftp="ftp -i"
alias ifconfig="ifconfig -a"
alias jsc="/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc"
alias lynx="lynx -vikeys"
alias more=less
alias mv="mv -i"
alias psw="ps auxww"
alias rm="rm -i"
alias scp="scp -v"
alias ssh="ssh -v"

# vim coolness
alias v="mvim --remote-silent $@"
function vt {
	pushd ${TIBET_HOME} > /dev/null
	mvim $(ack -g "$@")
	popd > /dev/null
}
function vack {
	mvim $(ack -g "$@")
}

#	file cleanup/repair
alias fixcm="perl -ne 's/\cM/\n/g; print'"
alias fixdos="perl -ne 's/\cM\cJ/\n/g; print'"
alias fixmac="perl -ne 's/\cM/\n/g; print'"
alias swapped="find . -name '*.sw[op]' -print"
alias cleantilde="\rm *~"

#	listings etc
export LSCOLORS="gxfxcxdxbxegedabagacad"
alias l="ls -CFG"
alias la="ls -aFG"
alias ls="ls -FG"
alias ll="ls -lFG"
alias lla="ls -alFG"

alias env="env | sort"

#	sizing/counting
alias sizes="du -s *"

alias md5='md5 -r'
alias md5sum='md5 -r'

#	vi-related config management
alias vimcolor="vi $HOME/.vim/colors/ss.vim"
alias vimex="vi $HOME/.exrc"
alias vimscr="vi $HOME/.screenrc"
alias vimsyn="vi $HOME/.vim/syntax/javascript.vim"
alias vimvi="vi $HOME/.vimrc"

#	---
#	Clients/Servers
#	---

#	Chrome
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --enable-extension-timeline-api --enable-file-cookies --enable-local-storage --allow-file-access-from-files --user-data-dir=$HOME/nacl-chrome-profile"
alias chromium="/Applications/Chromium.app/Contents/MacOS/Chromium --enable-extension-timeline-api --enable-file-cookies --enable-local-storage --allow-file-access-from-files --user-data-dir=$HOME/nacl-chrome-profile"

#	EJabberd
alias estart="sudo /opt/local/sbin/ejabberdctl start"
alias estop="sudo /opt/local/sbin/ejabberdctl stop"
alias estat="sudo /opt/local/sbin/ejabberdctl status"

#	TIBET Development Server
alias tdsstart="cdtds; java TDS.TDS"
alias tdcstart="cdtds; java TDS.TDS -console"

#	Apache
alias aprestart="sudo /opt/local/etc/LaunchDaemons/org.macports.apache2/apache2.wrapper restart"
alias apstart="sudo /opt/local/etc/LaunchDaemons/org.macports.apache2/apache2.wrapper start"
alias apstop="sudo /opt/local/etc/LaunchDaemons/org.macports.apache2/apache2.wrapper stop"

#	MySQL
alias mystart="sudo /opt/local/etc/LaunchDaemons/org.macports.mysql5/mysql5.wrapper start"
alias mystop="sudo /opt/local/etc/LaunchDaemons/org.macports.mysql5/mysql5.wrapper stop"

#	---
#	Java
#	---

alias jess="java jess.Main"
alias rhino="java org.mozilla.javascript.tools.shell.Main"
alias xalan="java org.apache.xalan.xslt.Process"

#	---
#	Source Code Control
#	---

#	git
#alias git_added
#alias git_changed
#alias git_conflicted
#alias git_deleted
#alias git_diff
#alias git_missing
#alias git_modified
#	subversion
alias svn_added="svn status | grep '^A'"
alias svn_changed="svn status | grep '^[^\?]'"
alias svn_conflicted="svn status | grep '^C'"
alias svn_deleted="svn status | grep '^D'"
alias svn_diff="svn diff --diff-cmd araxissvndiff"
alias svn_missing="svn status | grep '^\?'"
alias svn_modified="svn status | grep '^M'"

#	---
#	functions
#	---

function findem {
	# Goal here is to get a list of files without all the junk from
	# subversion or similar directory trees. Prune them (to avoid descent)
	# and then remove the directory from the resulting file list via grep
	# -v. Note the trailing sed line which handles filenames with blanks.
	find . -name .git -prune -o -name deprecated -prune -o -name "*$1*" | grep -v '\.git' | grep -v 'deprecated' | grep -v '__metadata__' | grep -v '\.sw[op]' | grep -v '\.class' | sed 's/\ /\\ /g'
}

function grepall {
	findem | grep -v '\.gif' | grep -v '\.png' | grep -v '\.bmp' | xargs -n 1 egrep -l -m 1 "$@" | xargs -0
}
function grepcss {
	findem '\.css' | xargs -n 1 egrep -lZ -m 1 "$@" | xargs -0
}
function grephtml {
	findem '\.html' | xargs -n 1 egrep -lZ -m 1 "$@" | xargs -0
}
function grepini {
	findem '\.ini' | xargs -n 1 egrep -lZ -m 1 "$@" | xargs -0
}
function grepjar {
	findem '\.jar' | xargs -n 1 egrep -lZ -m 1 "$@" | xargs -0
}
function grepjava {
	findem '\.java' | xargs -n 1 egrep -lZ -m 1 "$@" | xargs -0
}
function grepjs {
	findem '\.js' | xargs -n 1 egrep -lZ -m 1 "$@" | xargs -0
}
function grepphp {
	findem '\.php' | xargs -n 1 egrep -lZ -m 1 "$@" | xargs -0
}
function greprb {
	findem '\.rb' | xargs -n 1 egrep -lZ -m 1 "$@" | xargs -0
}
function grepxml {
	findem '\.xml' | xargs -n 1 egrep -lZ -m 1 "$@" | xargs -0
}
function grepxsl {
	findem '\.xsl' | xargs -n 1 egrep -lZ -m 1 "$@" | xargs -0
}

function greptibet {
	pushd ${TIBET_HOME} > /dev/null
	grepall "$*"
}

function loc {
	find . -name "$*" -exec wc {} \; | wc.pl
}

#	---
#	tibet
#	---

source ~/.tibetrc

#	---
#	prompt
#	---

c_cyan=`tput setaf 6`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_sgr0=`tput sgr0`

trim_pwd ()
{
	#   How many characters of the $PWD should be kept
	local pwdmaxlen=20
	#   Indicator that there has been directory truncation:
	#trunc_symbol="<"
	local trunc_symbol="..."
	if [ ${#PWD} -gt $pwdmaxlen ]
	then
		local pwdoffset=$(( ${#PWD} - $pwdmaxlen ))
		newPWD="${trunc_symbol}${PWD:$pwdoffset:$pwdmaxlen}"
	else
		newPWD=${PWD}
	fi
	echo $newPWD
}

parse_git_branch ()
{
	if git rev-parse --git-dir >/dev/null 2>&1
	then
		gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
	else
		return 0
	fi
	echo -e $gitver
}

branch_color ()
{
	if git rev-parse --git-dir >/dev/null 2>&1
	then
		color=""
		if git diff --quiet 2>/dev/null >&2
		then
			color="${c_green}"
		else
			color=${c_red}
		fi
	else
		return 0
	fi
	echo -ne $color
}

export PS1='\h [\[$(branch_color)\]$(parse_git_branch)\[${c_sgr0}\]] \[${c_red}\]$(trim_pwd)\[${c_sgr0}\] $ '

#	---
#	final scripts
#	---

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

#	---
#	eof
#	---
