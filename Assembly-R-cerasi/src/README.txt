This is the readme-file for the source directory.
This directory contains all scripts and configuration files used in this project.

The files:

AssembleSOAP2.sh:
This script is used to do a 63-mer SOAPdenovo assembly. For this assembly the conf_RC.ini file is used.
Usage: bash AssembleSOAP2.sh

AutoTrim.sh:
This script is used to trim all the read files at once. To trim the TrimmingScript.py is used.
Usage: bash AutoTrim.sh

conf_RC.ini:
This is the configuration file used by SOAPdenovo for an assembly.

kmergenie.sh:
This script is used to run kmergenie on all the files in one go.
Usage: bash kmergenie.sh

TrimmingScript.py:
This script trims two paired read files and generates two trimmed paired read files.
Usage: python TrimmingScript.py sequencefile1.fasta sequencefile2.fasta Trimmed_sequencefile1.fasta Trimmed_sequencefile2.fasta 