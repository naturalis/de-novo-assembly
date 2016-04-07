#!/bin/bash
# the species to analyse. this is the first
# command line argument, and can be either
# of the two binomial names, with underscores
# instead of spaces.

# location of project. all paths are constructed relative 
# to this location

# optimal k-mer size was reconstructed using kmergenie, see
# kmergenie.sh and ../results/kmergenie/kmergenie_summary.ini
K=23

# location of config file
CONF=conf_RC.ini

# Usage: SOAPdenovo <command> [option]
#    pregraph        construct kmer-graph
#    sparse_pregraph construct sparse kmer-graph
#    contig          eliminate errors and output contigs
#    map             map reads to contigs
#    scaff           construct scaffolds
#    all             do pregraph-contig-map-scaff in turn
COMMAND=all

# output locations
OUT=data2/Assembly2/RC_soap2
LOG=OUT.log
ERR=OUT.err

# we will track run time and memory usage using /usr/bin/time.
# all terminal output on STDOUT will be re-directed to $LOG,
# all terminal output on STDERR will be re-directed to $ERR
# the -R flag sets "resolve repeats by reads", according to
# http://soap.genomics.org.cn/soapdenovo.html
./SOAPdenovo-63mer $COMMAND -s $CONF -K $K -R -o $OUT > $LOG 2> $ERR
