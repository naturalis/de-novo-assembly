#!/bin/bash
# the species to analyse. this is the first
# command line argument, and can be either
# of the two binomial names, with underscores
# instead of spaces.
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
CONF=$PROJECT/conf/soapdenovo2/$SPECIES.ini

# Usage: SOAPdenovo <command> [option]
#    pregraph        construct kmer-graph
#    sparse_pregraph construct sparse kmer-graph
#    contig          eliminate errors and output contigs
#    map             map reads to contigs
#    scaff           construct scaffolds
#    all             do pregraph-contig-map-scaff in turn
COMMAND=all

# output locations
OUT=$PROJECT/results/soapdenovo2/$SPECIES
LOG=$OUT.log
ERR=$OUT.err

# we will track run time and memory usage using /usr/bin/time.
# all terminal output on STDOUT will be re-directed to $LOG,
# all terminal output on STDERR will be re-directed to $ERR
# the -R flag sets "resolve repeats by reads", according to
# http://soap.genomics.org.cn/soapdenovo.html
/usr/bin/time --verbose SOAPdenovo-63mer $COMMAND -s $CONF -K $K -R -o $OUT > $LOG 2> $ERR
