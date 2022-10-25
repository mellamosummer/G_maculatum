#!/bin/bash
#SBATCH --job-name=G_maculatum                   # Job name
#SBATCH --partition=highmem_p                        # Partition (queue) name
#SBATCH --ntasks=1			                                # Single task job
#SBATCH --cpus-per-task=10	                            # Number of cores per taskT
#SBATCH --mem=950gb	                                # Total memory for job
#SBATCH --time=96:00:00  		                            # Time limit hrs:min:sec
#SBATCH --output="/home/srb67793/G_maculatum_novogene/log.%j"			    # Location of standard output and error log files
#SBATCH --mail-user=srb67793@uga.edu                    # Where to send mail
#SBATCH --mail-type=END,FAIL                          # Mail events (BEGIN, END, FAIL, ALL)

##################################

#SUMMER BLANCO
#PHD STUDENT, PLANT BIOLOGY
#LEEBENS-MACK & CHANG LABS
#UNIVERSITY OF GEORGIA

#APPLIED GENOME ANALYSIS FALL 2022
#TERM PROJECT
#SAPELO2

##################################

#THIS SCRIPT:
#1) TRIMS G MACULATUM ILLUMINA SHORT READS -- DONE
#2) QC'S G MACULATUM ILLUMINA SHORT READS  -- DONE
#3) ASSEMBLES PLASTOME -- DONE
#4) ANNOTATES PLASTOME -- NEED TO FIGURE OUT WHAT SOFTWARE TO USE -- PHIL SUGGESTS PGA
#5) ANALYZES K-MER DISTRIBUTION -- DONE
#6) ASSEMBLES NUCLEAR GENOME -- TESTING SPADES & ABYSS CURRENTLY
#7) EVALUATES GENOME ASSEMBLY -- WAITING FOR GENOME ASSEMBLY, CODE WRITTEN THOUGH

# CODING QUESTIONS:
# WHAT IS THE RANGE OF KMERS THAT I SHOULD TEST WITH JELLYFISH?
# GENOMESCOPE ONLINE IS NOT WORKING FOR ME. I CAN'T GET IT WORKING ON THE CLUSTER EITHER.
# CAN YOU HELP TROUBLESHOOT THIS? I HAVE HISTOGRAMS FOR 19 21 23 25 27 29 31-MERS
# HOW DO I DETERMINE FROM THE KMER ANALYSES WHAT KMER SIZE TO USE FOR ASSEMBLY?

# RESEARCH QUESTIONS:
# WHAT DO YOU DO WITH AN ASSEMBLED PLASTOME? -- NOT SURE WHAT TO INTERPRET FROM THIS
  #CAN WE MAKE A PHYLOGENY INCLUDING G MACULATUM WITH AVAILABLE PLASTOMES NOW?
# HOW DO YOU INTERPRET THE KMER FIGURES?

##################################
# SET UP
##################################

#set output directory variable
# OUTDIR="/scratch/srb67793/G_maculatum"

#if output directory doesn't exist, create it

# if [ ! -d $OUTDIR ]
# then
#     mkdir -p $OUTDIR
# fi
#
# load modules
# module load FastQC/0.11.9-Java-11
# module load MultiQC/1.8-foss-2019b-Python-3.7.4
# module load ml Trimmomatic/0.39-Java-1.8.0_144
# module load GetOrganelle/1.7.5.2-foss-2020b
# module load ABySS/2.3.1-foss-2019b
# module load SPAdes/3.14.1-GCC-8.3.0-Python-3.7.4
# module load QUAST/5.0.2-foss-2019b-Python-3.7.4
# module load Jellyfish/2.3.0-GCC-8.3.0
# module load GenomeScope/1.0-foss-2019b-R-4.0.0

####################################################################
# 1) TRIMS G MACULATUM ILLUMINA SHORT READS
####################################################################

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

####################################################################
# 2) QC'S G MACULATUM ILLUMINA SHORT READS
####################################################################

# #QC post-trim with FASTQC & MultiQC
# mkdir $OUTDIR/FastQC/trimmed
# fastqc -o $OUTDIR/FastQC/trimmed/ $OUTDIR/trimmomatic/*paired.fq.gz
# multiqc $OUTDIR/FastQC/trimmed/*.zip

####################################################################
# 3) ASSEMBLES PLASTOME
####################################################################

# assemble plastome
# get_organelle_from_reads.py -t 8 -1 $OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R1_paired.fq.gz -2 $OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R2_paired.fq.gz -F embplant_pt -o $OUTDIR/plastome_GetOrganelle

####################################################################
# 4) NEED TO ANNOTATE PLASTOME
####################################################################

####################################################################
# 5) ANALYZES K-MER DISTRIBUTION
####################################################################

# # kmer analysis with Jellyfish for loop 19-32-mers
# mkdir $OUTDIR/jellyfish
# gunzip $OUTDIR/trimmomatic/*_paired.fq.gz
#
# for m in 19 21 23 25 27 29 31; do
#   jellyfish count -m $m -s 100M -t 10 -C -F 2 /$OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R1_paired.fq /$OUTDIR/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R2_paired.fq -o /$OUTDIR/jellyfish/k${m}test.jf
# done

# for m in 19 21 23 25 27 29 31; do
#   jellyfish histo -t 10 $OUTDIR/jellyfish/k${m}test.jf -o /$OUTDIR/jellyfish/k${m}test.histo
# done

#download to local computer and upload reads.hist to genome scope kmer analysis or with findGSE (https://github.com/schneebergerlab/findGSE) in R

################TESTING SECTION BELOW ################

####################################################################
# 6) ASSEMBLES NUCLEAR GENOME (testing spades & abyss)
####################################################################

# mkdir $OUTDIR/spades
#
# spades.py -t 10 -k 21,33,55,77 --isolate --memory 950 --pe1-1 /scratch/srb67793/G_maculatum/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R1_paired.fq --pe1-2 /scratch/srb67793/G_maculatum/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R2_paired.fq -o $OUTDIR/spades

#assemble the  genome using Illumina short reads with ABySS
# mkdir /scratch/srb67793/G_maculatum/abyss/

##Test k & c parameter range
# for kc in 2 3; do
# 	for k in `seq 50 8 90`; do
# 		mkdir $OUTDIR/abyss/k${k}-kc${kc}
# 		abyss-pe -C $OUTDIR/abyss/k${k}-kc${kc} name=g_maculatum B=2G k=$k kc=$kc in='/scratch/srb67793/G_maculatum/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R1_paired.fq /scratch/srb67793/G_maculatum/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R2_paired.fq'
# 	done
# done
# abyss-fac $OUTDIR/abyss/k*/g_maculatum-scaffolds.fa

#Run abyss with optimum kmer size
# abyss-pe k=# j=10 in='/scratch/srb67793/G_maculatum/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R1_paired.fq /scratch/srb67793/G_maculatum/trimmomatic/OT1_CKDN220054653-1A_HF33VDSX5_L1_R2_paired.fq'

####################################################################
# 7) EVALUATES GENOME ASSEMBLY
####################################################################

# QUAST Test script
# for file in $OUTDIR/abyss/k*/g_maculatum-scaffolds.fa; do
#   quast.py -o $OUTDIR/quast -t 10 $OUTDIR/abyss/k*/g_maculatum-scaffolds.fa
# done
