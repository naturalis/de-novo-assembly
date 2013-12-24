






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

# make output dir
RESULTS=$PROJECT/results/velvet
mkdir -p $RESULTS

# minimum number of pairs to join contigs,
# set to same as SOAPdenovo
N=3

#longpaid because the data is longPaired
LP="longPaired"

#The type of the data input
#Which for us is fastq format
T="-fastq"

# To Separate the files
S="-separate"

./velveth /home/assembly/velvet_1.2.10 $K $LP $T $S /home/assembly/data/schilthuizen/RawData/C0A7AACXX_101851-02_TGACCA_L001_R1.fastq.gz /home/assembly/data/schilthuizen/RawData/C0A7AACXX_101851-02_TGACCA_L001_R2.fastq.gz

###### Is nog niet af!######
# Er moet nog gekeken worden hoe meer dan 2 datasets ingelezen kunnen worden of dit gewoon toevoegen is of # # een aparte commando. Verder moet deze dan worden ingelezen in de terminal input. Ook moet velvetg nog #worden gerunned worden na dat velveth klaar is, met de parameters van dien.


