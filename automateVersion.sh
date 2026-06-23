#!/bin/bash
file=$1
lines=$(cat $file)
for line in $lines
do
python3 versionFinder.py -i $line -o cli
done
