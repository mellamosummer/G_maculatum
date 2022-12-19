## Methods ##
## Sample Preparation and Whole Genome Sequencing
Leaf tissue was collected from G. maculatum grown in the greenhouses at the University of Georgia, Athens. Genomic DNA was extracted from leaf tissue using a DNeasy Plant Kit (Qiagen) according to manufacturer's instructions and quantified using a Qubit fluorometer (Thermo Fisher Scientific). Samples were sent to Novogene for library preparation and whole genome shotgun sequencing using an Illumina NovaSeq 6000 Sequencing platform.

## Bioinformatics analysis
Raw Illumina reads were trimmed for quality and Illumina adapters were removed using Trimmomatic (Bolger et. al., 2014). Quality was assessed with FastQC/MultiQC (Andrews, 2010; Ewels et. al., 2016). K-mer frequencies from k=19 to k=31 in the paired end reads were counted with JELLYFISH (Marcais & Kingsford, 2011). Genome size and heterozygosity were then estimated using GenomeScope (Vurture et. al., 2017). 

Raw Illumina reads from G. maculatum were used as input for whole genome assembly with Meraculous v2.2.6 (genome_size=2.15, mer_size=31, diploid_mode=2, num_prefix_blocks=4, min_depth_cutoff=3) (Goltsman et. al., 2017). I attempted to assemble the chloroplast genome using GetOrganelle, NOVOPlasty, and Fast-Plast (Jian-Jun et. al., 2020; Dierckxsens et. al., 2016; McKain et. al., 2017). For the plastome assembly with GetOrganelle, I used the G. incanum chloroplast genome (KT760575.1) as a seed. Since this did not result in a complete plastome assembly, I used NOVOPlasty with Zea mays chloroplast gene for the large subunit of RUBP as a seed and the G. incanum chloroplast genome as a reference. Lastly, I ran Fast-Plast (default settings) using the Geraniales bowtie_index. Reads were then mapped to the G. incanum chloroplast genome using SAMtools/BCFtools (Danecek et. al., 2021) and visualized in IGV (Robinson et. al., 2011) to assess gaps and coverage.

## Data availability
Raw reads are located on Sapelo2 in the following directory: /scratch/srb67793/G_maculatum/rawreads/G_maculatum
The script used for all analyses is located on Github at: https://github.com/mellamosummer/G_maculatum_novogene/blob/main/scripts/G_maculatum.sh (git revision: 3c4d041).
