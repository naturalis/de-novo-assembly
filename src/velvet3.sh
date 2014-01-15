#!/bin/bash
# this script needs one command line argument: the species name


# location of project. all paths are constructed relative
# to this location
PROJECT=/home/assembly/de-novo-assembly

# read environment variables, same as abyss


# optimal k-mer size was reconstructed using kmergenie, see
# kmergenie.sh and ../results/kmergenie/kmergenie_summary.ini
K=23

# make output dir and log file names
RESULTS=$PROJECT/results/velvet
mkdir -p $RESULTS
mkdir -p $OUT
LOG=$OUT.log
ERR=$OUT.err


# minimum contig length
MINLENGTH=100

# same as SOAPdenovo
INSERTSIZE=200


# see http://www.ebi.ac.uk/~zerbino/velvet/Manual.pdf
/usr/bin/time --verbose velveth /home/assembly/de-novo-assembly/velvet_1.2.10/result/ $K -fastq -separate -shortPaired /home/assembly/data/schilthuizen/RawData/C0A7AACXX_101851-07_CAGATC_L001_R1.fastq.gz /home/assembly/data/schilthuizen/RawData/C0A7AACXX_101851-07_CAGATC_L001_R2.fastq.gz -shortPaired2 /home/assembly/data/schilthuizen/RawData/C0A7AACXX_101851-07_CAGATC_L002_R1.fastq.gz /home/assembly/data/schilthuizen/RawData/C0A7AACXX_101851-07_CAGATC_L002_R2.fastq.gz -shortPaired3 /home/assembly/data/schilthuizen/RawData/D0TRBACXX_101851-07_CAGATC_L004_R1.fastq.gz /home/assembly/data/schilthuizen/RawData/D0TRBACXX_101851-07_CAGATC_L004_R2.fastq.gz -shortPaired4 /home/assembly/data/schilthuizen/RawData/C0A7AACXX_101851-10_CTTGTA_L001_R1.fastq.gz /home/assembly/data/schilthuizen/RawData/C0A7AACXX_101851-10_CTTGTA_L001_R2.fastq.gz
-shortPaired5 /home/assembly/data/schilthuizen/RawData/C0A7AACXX_101851-10_CTTGTA_L002_R1.fastq.gz /home/assembly/data/schilthuizen/RawData/C0A7AACXX_101851-10_CTTGTA_L002_R2.fastq.gz -shortPaired6 /home/assembly/data/schilthuizen/RawData/D0TRBACXX_101851-10_CTTGTA_L004_R1.fastq.gz /home/assembly/data/schilthuizen/RawData/D0TRBACXX_101851-10_CTTGTA_L004_R2.fastq.gz > $LOG 2> $ERR


