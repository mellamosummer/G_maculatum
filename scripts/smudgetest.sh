#!/bin/bash
#SBATCH --job-name=smudgeplot                # Job name
#SBATCH --partition=batch                # Partition (queue) name
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=300gb
#SBATCH --time=48:00:00		                            # Time limit hrs:min:sec
#SBATCH --output="/home/srb67793/G_maculatum_novogene/log.%j"			    # Location of standard output and error log files
#SBATCH --mail-user=srb67793@uga.edu                    # Where to send mail
#SBATCH --mail-type=END,FAIL                          # Mail events (BEGIN, END, FAIL, ALL)

conda activate smudgeplot

#mkdir tmp

#ls /scratch/srb67793/G_maculatum/rawreads/G_maculatum/OT1_CKDN220054653-1A_HF33VDSX5_L1_1.fq /scratch/srb67793/G_maculatum/rawreads/G_maculatum/OT1_CKDN220054653-1A_HF33VDSX5_L1_2.fq > FILES

#kmc -k21 -t10 -m300 -ci1 -cs10000 @FILES kmer_counts tmp

#kmc_tools transform kmer_counts histogram kmer_k21.hist

# genomescope.R -i kmer_k21.hist -k 21 -p 2 -o . -n Gmaculatum_genomescope

# L=$(smudgeplot.py cutoff kmer_k21.hist L) # 26

#
# U=1200
#
# kmc_dump -ci$L -cx$U kmer_counts /dev/stdout | smudgeplot.py hetkmers -o kmer_pairs
#
# kmc_dump -ci100 -cx3000 kmer_counts kmer_k21.dump
#
# head kmer_k21.dump # just to see how the file looks like
# wc -l kmer_k21.dump # count number of kmers are in the dump file
#
# smudgeplot.py hetkmers -o kmer_pairs < kmer_k21.dump
#
# smudgeplot.py plot -o G_maculatum -t "Geranium maculatum" -q 0.99 kmer_pairs_coverages.tsv
#
# conda deactivate smudgeplot
