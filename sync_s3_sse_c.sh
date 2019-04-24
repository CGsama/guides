#!/bin/sh
#Sync local file with aws s3 by customized server side encryption key
#Tested in MINGW64
s3path="s3://xxx"
keyhash="xxxxxxxx"
echo -n "Enter the encryption key:"
read -s enckey
currpath=$(pwd)
sha=$(echo $enckey | sha256sum)
hex=${sha::64}
pw=${sha::32}
pwhash=$(echo $pw | sha256sum)
echo ${pwhash::8}
if [[ ${pwhash::8} == $keyhash ]]
then
echo "Correct passeword!"
hexpath=$(mktemp)
binpath=$(mktemp)
echo $hex > $hexpath
xxd -ps -r $hexpath $binpath
rm -f $hexpath
#(echo $pw && cat) > $path
#echo $(realpath $binpath)
#od -x $binpath
#realpath = "$(cd /tmp && pwd -W)/$(basename "$binpath")"
keybin=$(basename "$binpath")
cd $(dirname $binpath)
aws s3 sync $currpath $s3path --sse-c AES256 --sse-c-key fileb://$keybin
echo "Sync finish"
rm -f $binpath
else
echo "Wrong passeword!"
fi
