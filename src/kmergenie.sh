#!/bin/bash

# run me from inside my folder

# this is a directory inside the git repository
RESULTS=/home/assembly/de-novo-assembly/results/kmergenie
mkdir -p $RESULTS

# these are the raw reads stored elsewhere
DATA=/home/assembly/data/schilthuizen/RawData
cd $DATA

# make a list of all the reads
READS=`ls *.gz`

# iterate over the list
for READ in $READS; do

	# make a folder name for each reads file
	STEM=`echo $READ | sed -e 's/.fastq.gz//'`
	OUT=$RESULTS/$STEM

	# run kmergenie
	kmergenie $READ -o $OUT/histograms > $OUT.log 2> $OUT.err
done

# return to current working directory
cd -

# commit the results (which are small-ish) to github
git pull
git add $RESULTS
git commit -m "adding kmergenie results"
git push
