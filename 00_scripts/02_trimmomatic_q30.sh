#!/usr/bin/env bash

# trimmomatic version 0.39
# trimmomatic manual : http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf

WORKING_DIRECTORY=/home/fungi/Rhabdastrella_globostellata_transplant/01_raw_data/Original_reads
OUTPUT=/home/fungi/Rhabdastrella_globostellata_transplant/03_cleaned_data

# Make the directory (mkdir) only if not existe already(-p)
mkdir -p $OUTPUT

ADAPTERFILE=/home/fungi/Rhabdastrella_globostellata_transplant/99_softwares/adapters_sequences.fasta

# Arguments :
# ILLUMINACLIP:"$ADAPTERFILE":2:30:10 LEADING:30 TRAILING:30 SLIDINGWINDOW:26:30 MINLEN:150

eval "$(conda shell.bash hook)"
conda activate trimmomatic

cd $WORKING_DIRECTORY

####################################################
# Cleaning step
####################################################

for R1 in *R1*
do
   R2=${R1//R1.fastq/R2.fastq}
   R1paired=${R1//.fastq/_paired.fastq}
   R1unpaired=${R1//.fastq/_unpaired.fastq}	
   R2paired=${R2//.fastq/_paired.fastq}
   R2unpaired=${R2//.fastq/_unpaired.fastq}	

   trimmomatic PE -Xmx60G -threads 8 -phred33 $R1 $R2 $OUTPUT/$R1paired $OUTPUT/$R1unpaired $OUTPUT/$R2paired $OUTPUT/$R2unpaired ILLUMINACLIP:"$ADAPTERFILE":2:30:10 LEADING:30 TRAILING:30 SLIDINGWINDOW:26:30 MINLEN:150

done ;
