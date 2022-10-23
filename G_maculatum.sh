#!/bin/bash
#SBATCH --job-name=G_maculatum                   # Job name
#SBATCH --partition=batch                          # Partition (queue) name
#SBATCH --ntasks=1			                                # Single task job
#SBATCH --cpus-per-task=8	                            # Number of cores per taskT
#SBATCH --mem=250gb	                                # Total memory for job
#SBATCH --time=24:00:00  		                            # Time limit hrs:min:sec
#SBATCH --output="/home/srb67793/G_maculatum_novogene/log.%j"			    # Location of standard output and error log files
#SBATCH --mail-user=srb67793@uga.edu                    # Where to send mail
#SBATCH --mail-type=END,FAIL                          # Mail events (BEGIN, END, FAIL, ALL)

#set output directory variable
OUTDIR="/scratch/srb67793/G_maculatum"

#if output directory doesn't exist, create it

if [ ! -d $OUTDIR ]
then
    mkdir -p $OUTDIR
fi
#
#
# load modules
# module load FastQC/0.11.9-Java-11
# module load MultiQC/1.8-foss-2019b-Python-3.7.4
# module load ml Trimmomatic/0.39-Java-1.8.0_144
module load GetOrganelle/1.7.5.2-foss-2020b
# module load SPAdes/3.14.1-GCC-8.3.0-Python-3.7.4
# module load Jellyfish/2.3.0-GCC-8.3.0

# #QC pre-trim with FASTQC & MultiQC (took ~1 hr)
# mkdir $OUTDIR/FastQC
# mkdir $OUTDIR/FastQC/pretrim
# fastqc -o $OUTDIR/FastQC/pretrim/ /home/srb67793/G_maculatum/*.gz
# multiqc $OUTDIR/FastQC/pretrim/*.zip -o $OUTDIR/FastQC/pretrim/

#trim reads with trimmomatic
# java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar PE  -threads 4 \
# /home/srb67793/G_maculatum/OT1_CKDN220054653-1A_HF33VDSX5_L1_1.fq.gz \
# /home/srb67793/G_maculatum/OT1_CKDN220054653-1A_HF33VDSX5_L1_2.fq.gz \
# $OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R1_paired.fq.gz \
# $OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R1_unpaired.fq.gz \
# $OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R2_paired.fq.gz \
# $OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R2_unpaired.fq.gz \
# ILLUMINACLIP:$EBROOTTRIMMOMATIC/adapters/TruSeq3-PE-2.fa:2:30:10 \
# LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
#
# #QC post-trim with FASTQC & MultiQC
# mkdir $OUTDIR/FastQC/trimmed
# fastqc -o $OUTDIR/FastQC/trimmed/ $OUTDIR/trimmomatic/*paired.fq.gz
# multiqc $OUTDIR/FastQC/trimmed/*.zip

# assemble plastome
get_organelle_from_reads.py -t 8 -1 $OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R1_paired.fq.gz -2 $OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R2_paired.fq.gz -F embplant_pt -o $OUTDIR/plastome_GetOrganelle

# #assemble the  genome using Illumina short reads with SPAdes
# mkdir $OUTDIR/spades
# spades.py -t 6 -k 21,33,55,77 --isolate --memory 950 --pe1-1 $OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R1_paired.fq.gz --pe1-2 $OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R2_paired.fq.gz -o $OUTDIR/spades

# #kmer analysis with Jellyfish
# mkdir $OUTDIR/jellyfish
# jellyfish count -C -m 31 -s 1000000000 -t 10 *.fastq -o $OUTDIR/jellyfish/reads.jf
# jellyfish histo -t 10 $OUTDIR/jellyfish/reads.jf > reads.histo
#download to local computer and upload reads.hist to genome scope kmer analysis or with findGSE (https://github.com/schneebergerlab/findGSE) in R

#plastid assembly
#spades and then BLAST or mummer or use minimap to pull out plastome
  #to do search of similar plastid assembly
  #fethc those pieces
  #then use another tool for comparative scaffolding (RAGTAG)

# #get organelle
#   R01='trimmed_reads/Asparagus_nelsii_Norup_142_P_R1.fastq.gz'
#   # path to R2 reads
#   R02='trimmed_reads/Asparagus_nelsii_Norup_142_P_R2.fastq.gz'
#   # name of sample for output
#   sample_name='G_maculatum'
#
#   ​

#
# #related species -- map the reads to it
