#!/bin/bash
# this script needs one command line argument: the species name
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

# read environment variables, same as abyss
source $PROJECT/conf/abyss/$SPECIES.sh

# optimal k-mer size was reconstructed using kmergenie, see
# kmergenie.sh and ../results/kmergenie/kmergenie_summary.ini
K=23

# make output dir and log file names
RESULTS=$PROJECT/results/velvet
OUT=$RESULTS/$SPECIES
mkdir -p $RESULTS
mkdir -p $OUT
LOG=$OUT.log
ERR=$OUT.err

# the data is longPaired
READTYPE="-longPaired"

# the type of the data input, which for us is fastq format
FORMAT="-fastq.gz"

# separate input files XXX is this needed?
S="-separate"

# minimum contig length
MINLENGTH=100

# same as SOAPdenovo
INSERTSIZE=200

# XXX not sure whether and  how multiple pairs of files can 
# be provided. Maybe -separate pair1-1 pair1-2 -separate pair2-1 pair2-2
INFILES=""
for PAIR in $PAIRS; do
        INFILES="$INFILES $S ${!PAIR} "        
done

# see http://www.ebi.ac.uk/~zerbino/velvet/Manual.pdf
/usr/bin/time --verbose velveth $OUT $K $READTYPE $FORMAT $INFILES > $OUT 2> $ERR
/usr/bin/time --verbose velvetg $OUT -ins_length $INSERTSIZE -min_contig_lgth $MINLENGTH -cov_cutoff auto >> $OUT 2>> $ERR


