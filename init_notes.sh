#!/bin/bash

set -e
set -o pipefail

# example of input
#a="git@github.com:brofu/notes-es.git"

cd ../noteset
folder=$(echo $1 | sed 's&git@github.com:brofu/&&g' | sed 's&.git&&g')
username=$(echo $1 | sed 's&git@github.com:&&g' | sed 's&/.*$&&g')

# clone repo
if [ -d $folder ]; then
    echo "repo cloned"
else
    echo "cloning repo"
    git clone $1
fi



cd $folder

# update local
git config --local user.name $username
git config --local user.email $2

# gitbook
gitbook init

# copy files
cp ../../brofu.github.io/.gitignore ./.gitignore
cp -r ../../brofu.github.io/.github ./.github
