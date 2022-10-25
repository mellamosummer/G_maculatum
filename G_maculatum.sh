#!/bin/bash
#SBATCH --job-name=G_maculatum                   # Job name
#SBATCH --partition=batch                         # Partition (queue) name
#SBATCH --ntasks=1			                                # Single task job
#SBATCH --cpus-per-task=10	                            # Number of cores per taskT
#SBATCH --mem=250gb	                                # Total memory for job
#SBATCH --time=96:00:00  		                            # Time limit hrs:min:sec
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
# module load GetOrganelle/1.7.5.2-foss-2020b
# module load ABySS/2.3.1-foss-2019b
# module load QUAST/5.0.2-foss-2019b-Python-3.7.4
module load Jellyfish/2.3.0-GCC-8.3.0

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
# get_organelle_from_reads.py -t 8 -1 $OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R1_paired.fq.gz -2 $OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R2_paired.fq.gz -F embplant_pt -o $OUTDIR/plastome_GetOrganelle

################NEED TO ANNOTATE PLASTOME##################################

################currently working on this chunk of code################

# # kmer analysis with Jellyfish for loop 19-32-mers
# mkdir $OUTDIR/jellyfish
# gunzip $OUTDIR/trimmomatic/*_paired.fq.gz
#
# for m in 19 21 23 25 27 29 31; do
#   jellyfish count -m $m -s 100M -t 10 -C -F 2 /$OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R1_paired.fq /$OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R2_paired.fq -o /$OUTDIR/jellyfish/k${m}test.jf
# done

for m in 19 21 23 25 27 29 31; do
  jellyfish histo -t 10 $OUTDIR/jellyfish/k${m}test.jf -o /$OUTDIR/jellyfish/k${m}test.histo
done

#download to local computer and upload reads.hist to genome scope kmer analysis or with findGSE (https://github.com/schneebergerlab/findGSE) in R

################TESTING SECTION ABOVE################

################SECTION BELOW IS BROKEN################

#assemble the  genome using Illumina short reads with ABySS
# mkdir /scratch/srb67793/G_maculatum/abyss/

# abyss-pe name=g_maculatum k=96 B=2G /$OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R1_paired.fq /$OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R2_paired.fq'
#
# for kc in 2 3; do
# 	for k in `seq 50 8 90`; do
		# mkdir $OUTDIR/abyss/k${k}-kc${kc}
# 		abyss-pe -C $OUTDIR/abyss/k${k}-kc${kc} name=g_maculatum B=2G k=$k kc=$kc /$OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R1_paired.fq /$OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R2_paired.fq
# 	done
# done
# abyss-fac $OUTDIR/abyss/k*/g_maculatum-scaffolds.fa

#QUAST Test script
#quast.py -o $OUTDIR/quast -t 10 $OUTDIR/canu/ecoli.contigs.fasta 
