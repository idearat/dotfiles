#!/bin/sh -e

# In the current dir, this script does: 
# - clones $gituri to $gitdir
# - tags release $relnum
# - updates package.json to $relnum (master & develop)
# - creates npm packages for both branches
#
# example: git-rel-pkg.sh 998bca1d 0.3.25

gitref=$1               # create a release off this ref, can be any branch
relnum=$2               # update release package.json version to this

ynpmbin=$(which ynpm npm 2>/dev/null | head -1)

gituri=git@github.com:yahoo/mojito.git  # authenticated read/write public
gitdir=./mojito-$relnum
int_br=rel-$relnum                      # temp integration branch
pkgjson=package.json
message=
oldver=
newver=

#
#   funcs
#

usg() {
    cat <<ERR >&2
* err: $2
usage: $(basename $0) gitref releasenum
  gitref      commit/ref to land on master; can be from any branch
  releasenum  version to assign to release & it's tag, i.e 1.2.3.
ERR
    exit $1
}

ref_exists() {
    test -n $1 && git show --oneline $1 > /dev/null 2>&1
}

read_json() {
    perl -ane "m/\"$1\":\s*\"([^\"]+)\"/ && print \$1" $2
}

stamp() {
    perl -p -i~ -e "s/\"version\":\s*\"$1\"/\"version\": \"$2\"/" $3
    diff $3~ $3 && usg 7 'version not updated'
    rm $3~
    echo "* package version changed from $1 to $2"
}

git_describe() {
    echo $(git describe $1) # a very computationally expensive trim()
}

npm_pack() {
	(cd .. && $ynpmbin pack $gitdir)
}

#
#   checks
#

which $ynpmbin git perl >/dev/null || usg 1 "missing executable"
[[ -n $gitref ]] || usg 3 "git ref not specified"
[[ -n $relnum ]] || usg 3 "no release number"
[[ -d $gitdir ]] && usg 5 "dest dir $gitdir exists, stopping"

#
#   main
#

echo "* cloning $gitdir"
git clone -q git@github.com:yahoo/mojito.git $gitdir

cd $gitdir

ref_exists $gitref || usg 5 "git ref doesn't exist: $gitref"

# branch
git checkout -b $int_br $gitref

# stamp version & merge $int_br onto master
echo "* updating master"
stamp $(read_json version $pkgjson) $relnum $pkgjson
git add $pkgjson
message="release $relnum (based on $(git_describe $gitref))"
git commit -m "$message"

echo "* tagging $message"
git tag -a -m "$message" $relnum
git checkout -q master

echo "* merging $int_br onto master"
git merge -m "merge $message" $int_br

# package master
echo "* packaging $gitdir.tgz from master"
npm_pack

# stamp and merge onto develop
echo "* updating develop"
git checkout develop
git merge -m "merge $message" $int_br

# cleanup
echo "* cleanup $int_br"
git branch -D $int_br

cat <<DONE | tee $gitdir-publish_notes.txt
* ok packaging complete. please verify, then:
  1. cd $gitdir && git push --all origin && git push --tags && cd ..
  2. npm cache clean && npm pub $gitdir.tgz
  (see also http://y.ahoo.it/qsHtF)
DONE
