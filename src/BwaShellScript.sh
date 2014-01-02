#!/bin/bash
#This script needs no commandline input

#Location of the project. All paths are constructed relative
#to this location
PROJECT=/home/carla/Documents/ABySS_Mapping

#No results directory is made, because BWA saves all output files in the
#directory containing the input

#Path to the directory containing the input. Made seperate because of 
#frequently used.
INPUT=$PROJECT/Input

#Path to the directory containing BWA.
BWA=/home/carla/Downloads/BWA/bwa-0.7.5a

#Log file from STDOUT for indexing
LOG=$INPUT/index.log
#Error messages from STDERR for indexing
ERR=$INPUT/index.err

#Execute the command for indexing the fasta file. Creating a log file and 
#an error file.
/usr/bin/time --verbose $BWA/./bwa index $INPUT/ABySS_Output-contigs.fa  > $LOG > $ERR

#Log file from STDOUT for mapping
LOG2=$INPUT/align.log
#Error messages from STDERR for mapping
ERR2=$INPUT/align.err

#Execute the command for mapping. Creating a log file and an error file.
/usr/bin/time --verbose $BWA/./bwa mem -x $INPUT/ABySS_Output-contigs.fa $INPUT/C0A7AACXX_101851-02_TGACCA_L001_R1.fastq.gz $INPUT/C0A7AACXX_101851-02_TGACCA_L001_R2.fastq.gz > aln-pe.sam > $LOG2 > $ERR2




