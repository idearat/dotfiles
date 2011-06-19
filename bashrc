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
export APACHE_HOME="/Applications/MAMP"

#	mamp
export MAMP_HOME="/Applications/MAMP"

#	mysql
export MYSQL_HOME="/Applications/MAMP/conf"

#	java
export JAVA_HOME="/Library/Java/Home"
export JAVA_OPTS="-Xmx256m"

#	tomcat
export TOMCAT_HOME="/usr/local/tomcat"
export BASEDIR="${TOMCAT_HOME}"
export CATALINA_HOME="${TOMCAT_HOME}"
export CATALINA_OPTS="-Xmx256m -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=1046 -Dgrails.env=development"

#	vi(m) setup
export VISUAL=vim
export SVN_EDITOR=vim
export VIMRUNTIME="/opt/local/share/vim/vim73"

#	XML lint config
#	NB: This is a tab
export XMLLINT_INDENT="	"

#	paths
export MANPATH=".:$HOME/man:/usr/local/man:/usr/local/share/man:/usr/man:/usr/bin/man:/usr/share/man:/usr/share/locale/en/man:/usr/local/apache/man:/usr/X11R6/man"
export PATH="$HOME/bin:${MAMP_HOME}/bin:${MAMP_HOME}/Library/bin:${MAMP_HOME}/bin/php5.2/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin:/opt/subversion/bin:/usr/bin:$HOME/bin/marin:/Applications:/AddOns:/usr/local/ant/bin:/usr/local/jdk/bin:/usr/local/apache/bin:/bin:/usr/bin:/usr/X11R6/bin:/usr/sbin:/sbin:/usr/local/jython:/usr/local/apache/bin:/sw/bin:/cygdrive/c/j2sdk1.4.2_07/bin:/usr/share/tla/bin:/usr/local/tomcat/bin"
export PYTHONPATH=".:/usr/local/lib/python:/usr/lib/python"

#	---
#	aliases
#	---

#	bash environment management
alias vimit="vi $HOME/.bashrc"
alias srcit="source $HOME/.bashrc"

#	cd directory aliases
alias cdbin="cd $HOME/bin"
alias cdcgi="cd ${APACHE_HOME}/cgi-bin"
alias cdconf="cd ${APACHE_HOME}/conf"
alias cddown="cd ${HOME}/Downloads"
alias cddev="cd $HOME/devl"
alias cdhtml="cd ${APACHE_HOME}/htdocs"
alias cdlog="cd ${APACHE_HOME}/logs"
alias cdmsql="cd ${MAMP_HOME}/db/mysql"
alias cdsrc="cd /usr/local/src"
alias cdtmp="cd $HOME/tmp"
alias cdwar="cd $TOMCAT_HOME/webapps"
alias cdwork="cd $HOME/workspace"

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
alias ruby="ruby -w"
alias scp="scp -v"

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
alias fixcm="perl -ne 's/\cM//g; print'"
alias fixdos="perl -ne 's/\cM\cJ/\n/g; print'"
alias fixmac="perl -ne 's/\cM/\n/g; print'"
alias swapped="find . -name '*.sw[op]' -print"

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
alias chrome="/AddOns/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --enable-extension-timeline-api --enable-file-cookies --enable-local-storage --allow-file-access-from-files --user-data-dir=$HOME/nacl-chrome-profile"
alias chromium="/AddOns/Chromium.app/Contents/MacOS/Chromium --enable-extension-timeline-api --enable-file-cookies --enable-local-storage --allow-file-access-from-files --user-data-dir=$HOME/nacl-chrome-profile"

#	EJabberd
alias estart="sudo /opt/local/sbin/ejabberdctl start"
alias estop="sudo /opt/local/sbin/ejabberdctl stop"
alias estat="sudo /opt/local/sbin/ejabberdctl status"

#	TIBET Development Server
alias tdsstart="cdtds; java TDS.TDS"
alias tdcstart="cdtds; java TDS.TDS -console"

#	Apache
alias aprestart="apstop; sleep 5; apstart"
alias apstart="sudo ${MAMP_HOME}/bin/startApache.sh"
alias apstop="sudo ${MAMP_HOME}/bin/stopApache.sh"

#	Tomcat
alias catlogs="cd ${CATALINA_HOME}/logs"
alias catrestart="catstop; sleep 5; catstart"
alias catstart="${CATALINA_HOME}/bin/startup.sh"
alias catstop="${CATALINA_HOME}/bin/shutdown.sh"

#	MySQL
alias myrestart="mystop; sleep 5; mystart"
alias mystart="${MAMP_HOME}/bin/startMysql.sh"
alias mystop="${MAMP_HOME}/bin/stopMysql.sh"

#	MAMP
alias mampcfg="cd ${MAMP_HOME}/conf"
alias mamplogs="cd ${MAMP_HOME}/logs"
alias mamprestart="mampstop; sleep 5; mampstart"
alias mampstart="mystart; apstart"
alias mampstop="apstop; mystop"

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
	find . -name .svn -prune -o -name deprecated -prune -o -name "*$1*" | grep -v '\.svn' | grep -v 'deprecated' | grep -v '__metadata__' | grep -v '\.sw[op]' | grep -v '\.class' | sed 's/\ /\\ /g'
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
function grepxml {
	findem '\.xml' | xargs -n 1 egrep -lZ -m 1 "$@" | xargs -0
}
function grepxsl {
	findem '\.xsl' | xargs -n 1 egrep -lZ -m 1 "$@" | xargs -0
}

function grepfe {
	pushd ${MARIN_CURRENT}/front_end > /dev/null
	grepall "$*"
}
function grepmarin {
	pushd > /dev/null
	grepall "$*"
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
#	eof
#	---
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
