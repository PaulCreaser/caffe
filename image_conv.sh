#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Command line contains $# arguments"
else
    echo "Required arguments"
    echo "$0 1:[image_dir] 2:[out_dir]"
    exit
fi

rel_path=$1
full_path=$(readlink -f $rel_path)
echo $full_path

out_rel_path=$2
out_full_path=$(readlink -f $out_rel_path)
echo $out_full_path

mkdir -p $out_full_path
rm $out_full_path/*

COUNTER=0
echo " $COUNTER "

for file in "$full_path"/*
do
    if [[ -f $file ]]; then
	# Format file name, label
	# Label is set to 1, you need to manually set this :(

	echo "-------------------------------->>>>"
	basefile="${file##*/}"
	file_noext="${basefile%.*}"
	doe="_"
	file_cnt="$file_noext$doe$COUNTER"
	echo $file_cnt
	file_jpg="$file_cnt.jpeg"
	full_file_jpg="$out_full_path/$file_jpg"
	echo $full_file_jpg
	if [[ -f $full_file_jpg ]]; then
		rm $file_jpg
	fi
	convert $file $full_file_jpg
	COUNTER=$[$COUNTER +1]
	echo "<<<<--------------------------------"
    fi
done
