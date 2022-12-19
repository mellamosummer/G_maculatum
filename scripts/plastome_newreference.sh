#!/bin/bash
#SBATCH --job-name=extract_reads                # Job name
#SBATCH --partition=batch                # Partition (queue) name
#SBATCH --cpus-per-task=1
#SBATCH --mem=50gb
#SBATCH --time=24:00:00		                            # Time limit hrs:min:sec
#SBATCH --output="/home/srb67793/G_maculatum_novogene/log.%j"			    # Location of standard output and error log files
#SBATCH --mail-user=srb67793@uga.edu                    # Where to send mail
#SBATCH --mail-type=END,FAIL

#Load modules
module load BWA/0.7.17-GCC-8.3.0
module load SAMtools/1.10-GCC-8.3.0
module load BCFtools/1.10.2-GCC-8.3.0

# Set the path to the input bam file
bam_file="/path/to/input.bam"

# Set the path to the output bed file
bed_file="/path/to/output.bed"

OUTDIR="/scratch/srb67793/G_maculatum/plastome_tests/mapping/"

# Set the path to the input bam file
bam_file="/scratch/srb67793/G_maculatum/plastome_tests/mapping/G_maculatum.sorted.bam"

# Set the path to the output bed file
bed_file="scratch/srb67793/G_maculatum/plastome_tests/mapping/Gmaculatumoutput.bed"

# Extract the reads with at most 100,000 counts from the bam file
samtools view -h $bam_file | awk '$10<=100000' | samtools view -b - > $bed_file

# Convert the bed file to a bam file
bedtools bamtobed -i $bed_file > $bed_file.bam

# Sort the bam file
samtools sort $bed_file.bam -o $bed_file.sorted.bam

# Index the sorted bam file
samtools index $bed_file.sorted.bam

# Extract the reference sequences from the bam file using bedtools
bedtools getfasta -fi /home/srb67793/G_maculatum_novogene/plastome/G_incanum_plastomesequence.fasta -bed $bed_file -fo $OUTDIR/G_incanum_new_reference.fasta

# Map the reads to the new reference using bwa
bwa index $OUTDIR/G_incanum_new_reference.fasta
bwa mem $OUTDIR/G_incanum_new_reference.fasta /scratch/srb67793/G_maculatum/rawreads/G_maculatum/OT1_CKDN220054653-1A_HF33VDSX5_L1_1.fq.gz /scratch/srb67793/G_maculatum/rawreads/G_maculatum/OT1_CKDN220054653-1A_HF33VDSX5_L1_2.fq.gz > $OUTDIR/mapped_reads_newreference.sam

# Convert the mapping results to a bam file and sort it
samtools view -bS $OUTDIR/mapped_reads_newreference.sam | samtools sort - > $OUTDIR/mapped_reads_newreference.sorted.bam

# Index the sorted bam file
samtools index $OUTDIR/mapped_reads_newreference.sorted.bam

# Call variants using bcftools
bcftools mpileup -Ou -f $OUTDIR/G_incanum_new_reference.fasta $OUTDIR/mapped_reads_newreference.sorted.bam | bcftools call -vmO z -o $OUTDIR/variants_newreference.vcf.gz

# Index the VCF file
bcftools index $OUTDIR/variants_newreference.vcf.gz
