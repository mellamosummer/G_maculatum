# Course Info
Applied Genome Analysis  
Fall Semester 2022 (10/2022)  
Term Project  
UGA GACRC - Sapelo2 

# Contact info
Summer Blanco (summer.blanco@uga.edu)  
PhD Student, Department of Plant Biology  
Leebens-Mack & Chang Labs  
University of Georgia  

# About
This repository contains the scripts & results for analyzing Illumina shotgun sequencing data for Geranium maculatum. Leaf tissue was collected by Dr.Shu-Mei Chang (SMC). DNA was extracted using a Qiagen kit by Summer Blanco (SB) & SMC. Library preparation & sequencing was done by Novogene. Bioinformatics analyses were conducted by SB with guidance from Dr. Jim Leebens-Mack, Dr. Casey Bergman, and Jingxuan Chen.

# Pipeline:
1) FastQC & MultiQC pre-trim
2) Trimmomatic
3) FastQC & MultiQC post-trim
4) Jellyfish & GenomeScope
5) GetOrganelle & NOVOPlasty
6) SAMtools/BCFtools & IGV
7) Meraculous
8) QUAST

# File structure
**genomescope**

Contains 7 folders: k19,	k21, k23, k25, k27, k29, k31  
Each folder contains:  
-model.txt  
-plot.log.png (GenomeScope visualization)  
-plot.png (GenomeScope visualization)  
-progress.txt  
-summary.txt  

**jellyfish_histograms**  

Contains 7 files:  
-19test.histo  
-k21test.histo  
-k23test.histo  
-k25test.histo  
-k27test.histo  
-k29test.histo  
-k31test.histo  

Each file used with GenomeScope to generate kmer visualization.

**plastome** 

Contains 1 file:  
embplant_pt.K115.scaffolds.graph1.1.path_sequence.fasta

File contains sequences for scaffolds.

**pretrimQC**

Contains 5 files:  
-OT1_CKDN220054653-1A_HF33VDSX5_L1_1_fastqc.html  
-OT1_CKDN220054653-1A_HF33VDSX5_L1_2_fastqc.html  
-multiqc_report.html  
-OT1_CKDN220054653-1A_HF33VDSX5_L1_1_fastqc.zip  
-OT1_CKDN220054653-1A_HF33VDSX5_L1_2_fastqc.zip  

MultiQC report contains summary for 2 raw read files.

**scripts**

Contains 1 file:  
-G_maculatum.sh

**trimmedQC**  

Contains 5 files:  
-OT1_CKDN220054653-1A_HF33VDSX5_L1_R1_paired_fastqc.html  
-OT1_CKDN220054653-1A_HF33VDSX5_L1_R2_unpaired_fastqc.html  
-OT1_CKDN220054653-1A_HF33VDSX5_L1_R1_unpaired_fastqc.html  
-multiqc_report.html  
-OT1_CKDN220054653-1A_HF33VDSX5_L1_R2_paired_fastqc.html  

MultiQC report contains summary for 2 trimmed read files. 
