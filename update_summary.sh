#!/bin/bash

update_string () {
    old="\[$1\].*md"
    #echo "$old"
    new="[$1]($2)"
    echo "$old --> $new"

    # in case "-i" doesn't work
    sed "s@$old@$new@g" "$3" > "$3.bak"
    mv -f "$3.bak" "$3"
}



echo "Updating SMMMARY.md with Parameters: env $1, port $2"

if [ "$1" == "live" ]; then
    echo "updating summary in live env"
    NEW="https://brofu.github.io/notes-golang/"
else
    echo "updating summary in test env"
    NEW="http://localhost:$2/"
fi

# list to update
# to avoid to use hashmap in shell
# update here
topics=( "Golang" )

for i in "${topics[@]}"
do
   update_string "$i" $NEW SUMMARY.md 
done


