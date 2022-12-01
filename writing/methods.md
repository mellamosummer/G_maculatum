## Methods

## Sample Preparation and Whole Genome Sequencing

Leaf tissue was collected from _Geranium maculatum_ grown in the greenhouses at the Unviserity of Georgia, Athens. Genomic DNA was extracted from _G. maculatum_ leaf tissue using a DNeasy Plant Kit (Qiagen) according to manufacturer's instructions and quantified using a Qubit fluorometer (Thermo Fisher Scientific). Samples were sent to Novogene for library preparation and whole genome shotgun sequencing using an Illumina NovaSeq 6000 Sequencing platform.

## QC

Raw Illumina reads were trimmed for quality and Illumina adapters were removed using Trimmomatic (citation). Quality was assesed with FastQC/MultiQC (citation). 

## K-mer frequency analysis

K-mer frequencies from k=19 to k=31 in the paired end reads were counted with JELLYFISH (citation). Genome size and heterozygosity were estimated using GenomeScope (citation).


## Whole-genome assembly
Raw Illumina reads from _G. maculatum_ were used as input for whole genome assembly with Meraculous (v2.2.6).

## Plastome assembly

The chloroplast genome was assembled using NOVOPlasty (citation) using the _G. incanum_ chloroplast genome (KT760575.1) as a reference and the _Zea mays_ chloroplast gene for the large subunit of RUBP as a seed.

Raw reads wrere mapped to the _G. incanum_ chloroplast genome using SAMtools/BCFtools (citation) and visualized in IGV (citation).

## Data access

All shotgun reads (will be) depostited into the Short Read Archive (accession #). Scripts and results of this analysis can be found at https://github.com/mellamosummer/G_maculatum_novogene. 
