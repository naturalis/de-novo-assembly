de-novo-assembly
================

Contains shell scripts with example usage of NGS _de novo_ assembly tools for mid-size (insect) genomes.

* conf - configuration files for assembly tools
* doc - project documentation
* ref - background reference materials
* results - test data assemblies
* src - shell scripts to run assemblies and code for subsampling

Data 
====

The data used to develop this project were short reads of two phytophagous insect species (_Rhagoletis cerasi_ 
and _Gonioctena quinquepunctata_) for which, respectively, three and two individuals were sequenced on the Illumina
platform. The data for each species are pooled to obtain a composite assembly, (which will subsequently be used as a reference against which the individuals are mapped in order to identify regions that vary between host plant races).

Rhagoletis cerasi, individual 1, host plant 1
---------------------------------------------
* `C0A7AACXX_101851-02_TGACCA_L001_R1.fastq.gz`
* `C0A7AACXX_101851-02_TGACCA_L001_R2.fastq.gz`
* `C0A7AACXX_101851-02_TGACCA_L002_R1.fastq.gz`
* `C0A7AACXX_101851-02_TGACCA_L002_R2.fastq.gz`
* `D0TRBACXX_101851-02_TGACCA_L004_R1.fastq.gz`
* `D0TRBACXX_101851-02_TGACCA_L004_R2.fastq.gz`

Rhagoletis cerasi, individual 2, host plant 1
---------------------------------------------
* `C0A7AACXX_101851-03_ACAGTG_L001_R1.fastq.gz`
* `C0A7AACXX_101851-03_ACAGTG_L001_R2.fastq.gz`
* `C0A7AACXX_101851-03_ACAGTG_L002_R1.fastq.gz`
* `C0A7AACXX_101851-03_ACAGTG_L002_R2.fastq.gz`
* `D0TRBACXX_101851-03_ACAGTG_L004_R1.fastq.gz`
* `D0TRBACXX_101851-03_ACAGTG_L004_R2.fastq.gz`

Rhagoletis cerasi, individual 3, host plant 2
---------------------------------------------
* `C0A7AACXX_101851-06_GCCAAT_L001_R1.fastq.gz`
* `C0A7AACXX_101851-06_GCCAAT_L001_R2.fastq.gz`
* `C0A7AACXX_101851-06_GCCAAT_L002_R1.fastq.gz`
* `C0A7AACXX_101851-06_GCCAAT_L002_R2.fastq.gz`
* `D0TRBACXX_101851-06_GCCAAT_L004_R1.fastq.gz`
* `D0TRBACXX_101851-06_GCCAAT_L004_R2.fastq.gz`

Gonioctena quinquepunctata, individual 1, host plant 1
------------------------------------------------------
* `C0A7AACXX_101851-07_CAGATC_L001_R1.fastq.gz`
* `C0A7AACXX_101851-07_CAGATC_L001_R2.fastq.gz`
* `C0A7AACXX_101851-07_CAGATC_L002_R1.fastq.gz`
* `C0A7AACXX_101851-07_CAGATC_L002_R2.fastq.gz`
* `D0TRBACXX_101851-07_CAGATC_L004_R1.fastq.gz`
* `D0TRBACXX_101851-07_CAGATC_L004_R2.fastq.gz`

Gonioctena quinquepunctata, individual 2, host plant 2
------------------------------------------------------
* `C0A7AACXX_101851-10_CTTGTA_L001_R1.fastq.gz`
* `C0A7AACXX_101851-10_CTTGTA_L001_R2.fastq.gz`
* `C0A7AACXX_101851-10_CTTGTA_L002_R1.fastq.gz`
* `C0A7AACXX_101851-10_CTTGTA_L002_R2.fastq.gz`
* `D0TRBACXX_101851-10_CTTGTA_L004_R1.fastq.gz`
* `D0TRBACXX_101851-10_CTTGTA_L004_R2.fastq.gz`
