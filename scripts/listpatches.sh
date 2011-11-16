#!/bin/sh

set -e

if ! [ -r layers.txt ]
then
	cd sources
fi

sed -e '/^#\|^$/d' -e 's/,/ /g' layers.txt | while read dir repo branch rev
do
	if [ $rev = "HEAD" ]
	then
		rev="origin/$branch"
	fi

	echo "Layer $dir"
	cd $dir
	git log --pretty=oneline $rev..HEAD
	git diff --stat HEAD
	cd - >/dev/null
done
