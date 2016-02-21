#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Command line contains $# arguments"
else
    echo "Required arguments"
    echo "$0 1:[image_dir] 2:[output_filename]"
    exit
fi

out_file=$2
echo $out_file

rm $out_file

rel_path=$1
full_path=$(readlink -f $rel_path)
echo $full_path

for file in "$full_path"/*
do
    if [[ -f $file ]]; then
	# Format file name, label
	# Label is set to 1, you need to manually set this :(
	line="$file 1"
	echo $line >> $out_file
    fi
done
