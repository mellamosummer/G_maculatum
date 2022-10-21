#!/bin/bash
#SBATCH --job-name=G_maculatum                   # Job name
#SBATCH --partition=batch		                            # Partition (queue) name
#SBATCH --ntasks=1			                                # Single task job
#SBATCH --cpus-per-task=6		                            # Number of cores per task - match this to the num_threads used by BLAST
#SBATCH --mem=24gb			                                # Total memory for job
#SBATCH --time=6:00:00  		                            # Time limit hrs:min:sec
#SBATCH --output="/home/srb67793/G_maculatum_novogene/log.%j"			    # Location of standard output and error log files (replace cbergman with your myid)
#SBATCH --mail-user=srb67793@uga.edu                    # Where to send mail
#SBATCH --mail-type=END,FAIL                          # Mail events (BEGIN, END, FAIL, ALL)

#set output directory variable
OUTDIR="/scratch/srb67793/G_maculatum"

#if output directory doesn't exist, create it

if [ ! -d $OUTDIR ]
then
    mkdir -p $OUTDIR
fi


# #load modules
# module load FastQC/0.11.9-Java-11
# module load MultiQC/1.8-foss-2019b-Python-3.7.4
# module load Trimmomatic/0.39-Java-1.8.0_144
# module load SPAdes/3.14.1-GCC-8.3.0-Python-3.7.4
# module load QUAST/5.0.2-foss-2019b-Python-3.7.4
# module load Jellyfish/2.3.0-GCC-8.3.0

#QC pre-trim with FASTQC & MultiQC
mkdir "$OUTDIR/FastQC/pretrim/"
# fastqc -o $OUTDIR/FastQC/pretrim/ /home/srb67793/G_maculatum/*.gz
# multiqc $OUTDIR/FastQC/pretrim/*.zip

# #trim reads with trimmomatic
# java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar PE  -threads 4 \
# /home/srb67793/G_maculatum/OT1_CKDN220054653-1A_HF33VDSX5_L1_1.fq.gz /home/srb67793/G_maculatum/OT1_CKDN220054653-1A_HF33VDSX5_L1_2.fq.gz \
# $OUTDIR/trimmomatic/R1_paired.fastq.gz \
# $OUTDIR/trimmomatic/R1_unpaired.fastq.gz \
# $OUTDIR/trimmomatic/R2_paired.fastq.gz \
# $OUTDIR/trimmomatic/R2_unpaired.fastq.gz \
# ILLUMINACLIP:$EBROOTTRIMMOMATIC/adapters/TruSeq3-PE-2.fa:2:30:10 \
# LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
#
# #QC post-trim with FASTQC & MultiQC
# fastqc -o $OUTDIR/FastQC/trimmed $OUTDIR/trimmomatic/*.gz
# multiqc $OUTDIR/FastQC/trimmed/*.zip
#
# #assemble the  genome using Illumina short reads with SPAdes
# spades.py -t 6 -k 21,33,55,77 --isolate --memory 24 --pe1-1 $OUTDIR/trimmomatic/R1_paired.fastq.gz --pe1-2 /$OUTDIR/trimmomatic/R2_paired.fastq.gz -o $OUTDIR/spades

# #can i do quast or mummer?
#
# #kmer analysis with Jellyfish
# jellyfish count -m 31 -s 100M -t 10 -C reads.fasta -o $OUTDIR/jellyfish

#genome scope for analysis of kmers & findGSE https://github.com/schneebergerlab/findGSE

#kmer analysis & plastid assembly
#spades and then BLAST or mummer or use minimap to pull out plastome
  #to do search of similar plastid assembly
  #fethc those pieces
  #then use another tool for comparative scaffolding

#related species -- map the reads to it
