#!/bin/bash
# species name is provided on the command line
SPECIES=$1

# verify command line argument
if [ "$SPECIES" == "Rhagoletis_cerasi" ]; then
        echo "going to assemble Rhagoletis cerasi"
elif [ "$SPECIES" == "Gonioctena_quinquepunctata" ]; then
        echo "going to assemble Gonioctena quinquepunctata"
else 
        echo "Usage: $0 <Rhagoletis_cerasi or Gonioctena_quinquepunctata>"
        exit
fi

# location of project. all paths are constructed relative 
# to this location
PROJECT=/home/assembly/de-novo-assembly

# read in the environment variables from the config file
# containing the location of the reads
source $PROJECT/conf/abyss/$SPECIES.sh

# read in the environment variables from the config file
# containing the location of the reference
source $PROJECT/conf/bwa/$SPECIES.sh

# make output dir
RESULTS=$PROJECT/results/bwa/$SPECIES
mkdir -p $RESULTS

# log file from STDOUT
LOG=$RESULTS/$SPECIES.log

# error messages from STDERR
ERR=$RESULTS/$SPECIES.err

# number of cores to use
CORES=8

# recreate BWA index if not exists
if [ ! -e $REFERENCE.bwt ]; then
	echo "going to index $REFERENCE" >> $LOG

	# Warning: "-a bwtsw" does not work for short genomes, 
	# while "-a is" and "-a div" do not work not for long 
	# genomes. Please choose "-a" according to the length 
	# of the genome.
	bwa index -a bwtsw $REFERENCE >> $LOG 2>> $ERR
else 
	echo "$REFERENCE already indexed" >> $LOG
fi

# this will grow into a list of sorted BAM files to merge
BAMS=""

# iterate over mate pairs
for PAIR in $PAIRS; do
	echo "going to process $PAIR"

	# list the FASTQ files in this pair. this should be
	# two files (paired end)
	FASTQS=${!PAIR}

	# lists of produced files
	SAIS=""

	# iterate over FASTQ files
	for FASTQ in $FASTQS; do

		# create new names
		LOCALFASTA=`echo $REFERENCE | sed -e 's/.*\///'`
		LOCALFASTQ=`echo $FASTQ | sed -e 's/.*\///'`
		OUTFILE=$RESULTS/$LOCALFASTQ-$LOCALFASTA.sai
		SAIS="$SAIS $OUTFILE"

		# note: we don't do basic QC here, because that might mean
		# that the mate pairs in the FASTQ files go out of order,
		# which will result in the bwa sampe step taking an inordinate
		# amount of time

		# do bwa aln if needed
		if [ ! -e $OUTFILE ]; then
			echo "going to align $FASTQ against $REFERENCE" >> $LOG

			# use $CORES threads
			bwa aln -t $CORES $REFERENCE $FASTQ > $OUTFILE 2>> $ERR
		else
			echo "alignment $OUTFILE already created" >> $LOG
		fi
	done

        # name of the resulting SAM file for this pair
        SAM=$RESULTS/$SPECIES-$PAIR.sam

	# do bwa sampe if needed
	if [ ! -e $SAM ]; then

		# create paired-end SAM file
		echo "going to run bwa sampe $REFERENCE $SAIS $FASTQS > $SAM" >> $LOG
		bwa sampe $REFERENCE $SAIS $FASTQS > $SAM 2>> $ERR
	else
		echo "sam file $SAM already created" >> $LOG
	fi		

	# do samtools filter if needed
	if [ ! -e $SAM.filtered ]; then
		# -bS   = input is SAM, output is BAM
		# -F 4  = remove unmapped reads
		# -q 50 = remove reads with mapping qual < 50
		# XXX maybe increase -q?
		echo "going to run samtools view -bS -F 4 -q 50 $SAM > $SAM.filtered" >> $LOG
		samtools view -bS -F 4 -q 50 $SAM > $SAM.filtered 2>> $ERR
		gzip -9 $SAM
	else
		echo "sam file $SAM.filtered already created" >> $LOG
	fi

	# do samtools sorting if needed
	if [ ! -e $SAM.sorted.bam ]; then

		# sorting is needed for indexing
		echo "going to run samtools sort $SAM.filtered $SAM.sorted" >> $LOG
		samtools sort $SAM.filtered $SAM.sorted 2>> $ERR
	else
		echo "sam file $SAM.sorted already created" >> $LOG
	fi

	# created index for BAM file if needed
	if [ ! -e $SAM.sorted.bam.bai ]; then
	
		# this should result in faster processing
		echo "going to run samtools index $SAM.sorted.bam" >> $LOG
		samtools index $SAM.sorted.bam 2>> $ERR
	else
		echo "BAM file index $SAM.sorted.bam.bai already created" >> $LOG
	fi

	# grow the list, will merge these in the end
	BAMS="$BAMS $SAM.sorted.bam"
done

# now merge all the individuals
BAM=$RESULTS/$SPECIES-merged.bam
if [ ! -e $BAM ]; then
	echo "going to create merged BAM file $BAM" >> $LOG
	samtools merge $BAM $BAMS 2>> $ERR
else
	echo "merged BAM file $BAM already created" >> $LOG
fi
