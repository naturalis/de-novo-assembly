#!/bin/bash

# this is a directory inside the git repository
RESULTS=/home/assembly/de-novo-assembly/results/

# these are the raw reads stored elsewhere
DATA=/home/assembly/data/schilthuizen/RawData
cd $DATA

# make a list of all the reads
READS=`ls *.gz`

# iterate over the list
for READ in $READS; do

	# make a folder name for each reads file
	STEM=`echo $READ | sed -e 's/.fastq.gz//'`
	OUT=$RESULTS/kmergenie/$STEM

	# run kmergenie
	kmergenie $READ -o $OUT/histograms > $OUT.log 2> $OUT.err
done
cd -
git add $RESULTS/kmergenie
git commit -m "adding kmergenie results"
git push
