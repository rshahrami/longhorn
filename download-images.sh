#!/bin/bash


input="$PWD/roles/longhorn/files"
imagesList="$PWD/temp"

wget -O $input/longhorn-iscsi-installation.yaml https://raw.githubusercontent.com/longhorn/longhorn/v1.3.0/deploy/prerequisite/longhorn-iscsi-installation.yaml
wget -O $input/longhorn-nfs-installation.yaml https://raw.githubusercontent.com/longhorn/longhorn/v1.3.0/deploy/prerequisite/longhorn-nfs-installation.yaml
wget -O $input/longhorn.yaml https://raw.githubusercontent.com/longhorn/longhorn/v1.3.0/deploy/longhorn.yaml


cat $input/longhorn-iscsi-installation.yaml | grep image: | cut -d ':' -f2,3 > temp
cat $input/longhorn-nfs-installation.yaml | grep image: | cut -d ':' -f2,3 >> temp
cat $input/longhorn.yaml | grep longhornio/ | sed 's/image://g' | sed 's/value://g' | sed 's/"//g' | sed 's/- //g' >> temp


while IFS= read -r line
do
  echo "$line"
  docker pull "$line"
done < "$imagesList"

for i in {1..2}
do
    echo " "
done
echo "download all images success"

sed -i -e 's/longhornio\//nexus:32002\//g' -e 's/k8s.gcr.io\//nexus:32002\//g' -e 's/alpine:3.12/nexus:32002\/alpine:3.12/g' $input/*.yaml
