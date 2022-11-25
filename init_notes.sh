#!/bin/bash

set -e
set -o pipefail

# example of input
# init_notes.sh git@github.com:brofu/notes-es.git brofu.talk@gmail.com

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



pushd $folder

# update local
git config --local user.name $username
git config --local user.email $2

# gitbook
gitbook init

# copy git files 
cp ../../brofu.github.io/.gitignore ./.gitignore
cp -r ../../brofu.github.io/.github ./.github
cp -r ../../brofu.github.io/.git/hooks/pre-commit ./.git/hooks/pre-commit

# copy tools. 
cp ../../brofu.github.io/update_summary.sh ./update_summary.sh

# copy book tools
cp ../../brofu.github.io/book.json ./book.json

git add .
git commit -m "init version"

popd
