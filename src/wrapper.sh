#!/bin/bash
# this wrapper script allows us to assemble the genomes
# for the two species sequentially so we can launch one
# job after the other and each can max out the available
# resources

# tool is the first command line argument, e.g.
# "./velvet.sh"
TOOL=$1
if [ -x "$TOOL" ]; then
	echo "going to run $TOOL"
else
	echo "no executable $TOOL"
	exit
fi

# iterate over species list
SPECIESLIST="Rhagoletis_cerasi Gonioctena_quinquepunctata"
for SPECIES in $SPECIESLIST; do
	$TOOL $SPECIES
done
