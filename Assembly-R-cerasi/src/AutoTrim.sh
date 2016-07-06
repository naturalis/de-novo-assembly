# #!/bin/bash
# This script is used to trim all the 18 fasta files in one go. These fasta files have to be paired end.
# The script used for trimming is TrimScript.py. To use this script do this: python TrimmingScript.py sequencefile1.fasta sequencefile2.fasta Trimmed_sequencefile1.fasta Trimmed_sequencefile2.fasta
# The temporary files are deleted after the command. The paths towards the files have to be correct for this script to run.
#
#Usage: bash AssembleSOAP2.sh
 
python TrimScript.py ../data/ruw_data/C0A7AACXX_101851-02_TGACCA_L001_R1.fastq ../data/ruw_data/C0A7AACXX_101851-02_TGACCA_L001_R2.fastq ../data/TrimmedC2L1R1.fastq ../data/TrimmedC2L1R2.fastq
rm verwijderen.txt
python TrimScript.py ../data/ruw_data/C0A7AACXX_101851-02_TGACCA_L002_R1.fastq ../data/ruw_data/C0A7AACXX_101851-02_TGACCA_L002_R2.fastq ../data/TrimmedC2L2R1.fastq ../data/TrimmedC2L2R2.fastq
rm verwijderen.txt
python TrimScript.py ../data/ruw_data/C0A7AACXX_101851-03_ACAGTG_L001_R1.fastq ../data/ruw_data/C0A7AACXX_101851-03_ACAGTG_L001_R2.fastq ../data/TrimmedC3L1R1.fastq ../data/TrimmedC3L1R2.fastq
rm verwijderen.txt
python TrimScript.py ../data/ruw_data/C0A7AACXX_101851-03_ACAGTG_L002_R1.fastq ../data/ruw_data/C0A7AACXX_101851-03_ACAGTG_L002_R2.fastq ../data/TrimmedC3L2R1.fastq ../data/TrimmedC3L2R2.fastq
rm verwijderen.txt
python TrimScript.py ../data/ruw_data/C0A7AACXX_101851-06_GCCAAT_L001_R1.fastq ../data/ruw_data/C0A7AACXX_101851-06_GCCAAT_L001_R2.fastq ../data/TrimmedC6L1R1.fastq ../data/TrimmedC6L1R2.fastq
rm verwijderen.txt
python TrimScript.py ../data/ruw_data/C0A7AACXX_101851-06_GCCAAT_L002_R1.fastq ../data/ruw_data/C0A7AACXX_101851-06_GCCAAT_L002_R2.fastq ../data/TrimmedC6L2R1.fastq ../data/TrimmedC6L2R2.fastq
rm verwijderen.txt
python TrimScript.py ../data/ruw_data/D0TRBACXX_101851-02_TGACCA_L004_R1.fastq ../data/ruw_data/D0TRBACXX_101851-02_TGACCA_L004_R2.fastq ../data/TrimmedD2L4R1.fastq ../data/TrimmedD2L4R2.fastq
rm verwijderen.txt
python TrimScript.py ../data/ruw_data/D0TRBACXX_101851-03_ACAGTG_L004_R1.fastq ../data/ruw_data/D0TRBACXX_101851-03_ACAGTG_L004_R2.fastq ../data/TrimmedD3L4R1.fastq ../data/TrimmedD3L4R2.fastq
rm verwijderen.txt
python TrimScript.py ../data/ruw_data/D0TRBACXX_101851-06_GCCAAT_L004_R1.fastq ../data/ruw_data/D0TRBACXX_101851-06_GCCAAT_L004_R2.fastq ../data/TrimmedD6L4R1.fastq ../data/TrimmedD6L4R2.fastq
rm verwijderen.txt
