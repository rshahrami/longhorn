#!/bin/bash

imagesList="$PWD/temp"

# sed -i -e 's/longhornio\//nexus:32002\//g' -e 's/k8s.gcr.io\//nexus:32002\//g' -e 's/alpine:3.12/nexus:32002\/alpine:3.12/g' $imagesList | cut -d '/' -f 2 > $imagesList
cut -d '/' -f 2 $imagesList >> $imagesList


while IFS= read -r line
do
    echo "$line"
    if [ -z  $(docker images -q longhornio/$line) ]; then

        imageId=$(docker images -q longhornio/$line)
        docker tag $imageId nexus:32002/$line
    fi

    if [ -z  $(docker images -q k8s.gcr.io/$line) ]; then

        imageId=$(docker images -q k8s.gcr.io/$line)
        docker tag $imageId nexus:32002/$line
    fi

    if [ -z  $(docker images -q $line) ]; then

        imageId=$(docker images -q $line)
        docker tag $imageId nexus:32002/$line
    fi

    #   docker push nexus:32002/$line

    for i in {1..2}
    do
        echo " "
    done
done < "$imagesList"







