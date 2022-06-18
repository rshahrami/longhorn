change all image to nexus:32002 repository with belowing command. for example:

sed -i 's/longhornio\//nexus:32002\//g' longhorn.yaml

change longhornio/ to nexus:32002/



run belowing script

download-images.sh
pushToRegistry.sh
