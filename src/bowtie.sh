#!/bin/bash
#This script needs no commandline input

#Location of the project. All paths are constructed relative
#to this location
PROJECT=/home/carla/Documents/ABySS_Mapping

#A directory for the output is made. 
RESULTS=$PROJECT/resultsBowtie2
mkdir -p $RESULTS

#Path to the directory containing the input. Made seperate because of 
#frequently used.
INPUT=$PROJECT/Input

#Path to the directory containing Bowtie2
BOWTIE2=/home/carla/Downloads/Bowtie2/bowtie2-2.1.0

#Log file from STDOUT for indexing
LOG=$RESULTS/BowtieBuild.log
#Error messages from STDERR for indexing
ERR=$RESULTS/BowtieBuild.err

#Execute the command for indexing the fasta file. Creating a log file
#and an error file.
/usr/bin/time --verbose $BOWTIE2/./bowtie2-build $INPUT/ABySS_Output-contigs.fa $RESULTS/Output_Build > $LOG > $ERR

#Log file from STDOUT for mapping
LOG2=$RESULTS/BowtieAlign.log
#Error messages from STDERR for mapping
ERR2=$RESULTS/BowtieAlign.err

#Execute the command for mapping. Creating a log file and an error file.
/usr/bin/time --verbose $BOWTIE2/./bowtie2 -x $RESULTS/Output_Build -1 $INPUT/C0A7AACXX_101851-02_TGACCA_L001_R1.fastq.gz -2 $INPUT/C0A7AACXX_101851-02_TGACCA_L001_R2.fastq.gz -S $RESULTS/Output_Align > $LOG2 > $ERR2

