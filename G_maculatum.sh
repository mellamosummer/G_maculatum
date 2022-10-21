#!/bin/bash
#SBATCH --job-name=homework_3		                        # Job name
#SBATCH --partition=batch		                            # Partition (queue) name
#SBATCH --ntasks=1			                                # Single task job
#SBATCH --cpus-per-task=6		                            # Number of cores per task - match this to the num_threads used by BLAST
#SBATCH --mem=24gb			                                # Total memory for job
#SBATCH --time=6:00:00  		                            # Time limit hrs:min:sec
#SBATCH --output=/work/gene8940/srb67793/log.%j			    # Location of standard output and error log files (replace cbergman with your myid)
#SBATCH --mail-user=srb67793@uga.edu                    # Where to send mail
#SBATCH --mail-type=END,FAIL                          # Mail events (BEGIN, END, FAIL, ALL)

#set output directory variable
OUTDIR="/work/jlmlab/G_maculatum

#if output directory doesn't exist, create it
if [ ! -d $OUTDIR ]
then
    mkdir -p $OUTDIR
fi
