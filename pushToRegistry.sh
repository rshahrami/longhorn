#!/bin/bash

imagesList="$PWD/temp"


while IFS= read -r line
do
    echo "$line"
    image=$(sed 's/^[ \t]*//' | cut -d '/' -f 2 $line)
    docker tag $line nexus:32002/$image
    docker push nexus:32002/$image

    for i in {1..2}
    do
        echo " "
    done
done < "$imagesList"


rm $imagesList







