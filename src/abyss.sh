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

# optimal k-mer size was reconstructed using kmergenie, see
# kmergenie.sh and ../results/kmergenie/kmergenie_summary.ini
K=23

# location of config file
CONF=$PROJECT/conf/abyss/$SPECIES.sh

# read in the environment variables from the config file
source $CONF

# make output dir
RESULTS=$PROJECT/results/abyss
mkdir -p $RESULTS

# log file from STDOUT
LOG=$RESULTS/$SPECIES.log

# error messages from STDERR
ERR=$RESULTS/$SPECIES.err

# stem of the contigs
NAME=$RESULTS/$SPECIES

# grow the list of paired ends
PAIRLIST=""
for PAIR in $PAIRS; do
        PAIRLIST="$PAIRLIST $PAIR='${!PAIR}'"
done

/usr/bin/time --verbose abyss-pe k=$K lib="$PAIRS" $PAIRLIST name=$NAME > $LOG 2> $ERR

