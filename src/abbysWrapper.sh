#!/bin/bash

# this wrapper script allows us to assemble the genomes
# for the two species sequentially so we can launch one
# job after the other and each can max out the available
# resources
SPECIESLIST="Rhagoletis_cerasi Gonioctena_quinquepunctata"
for SPECIES in $SPECIESLIST; do
	./abyss.sh $SPECIES
done
