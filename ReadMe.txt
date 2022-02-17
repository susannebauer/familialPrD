Information on Metadata file

metadata.csv


-nfcore_id: sample_id provided by Nextflow nfcore/rnaseq pipeline based on input file
-sample_id: sample_id based on in-house mouse ID and a single letter identifying the fraction and region of sample, separated by point. Options for Id letters are (A = Cerebrum RiboTag IP; B = Cerebrum total RNA; D = Cerebellum RiboTag IP; E = Cerebellum total RNA)
-sample_set: structure: <Group>_<Cell_typeRegion>_<Fraction>
-Group: Disease genotype of mouse, options: "FFI", "CJD" or "Control"
-Cell_type: Neuronal subtype targeted by Cre; options: "Gad2", "Vglut2", "PV, "SST"
-Fraction: Method of RNA purification; options: "IP" or "total"
-Region: Brain region from which sample was obtained; options: "Cerebellum" or "Cerebrum"
-Gender: options: Male "M" or Female "F"
-Age: Age of mice at sacrifice in weeks
-Prep_date: Date on which RNA samples were purified; structure: YYMMDD
-Death_day: Date on which mouse was scarified and tissue frozen; structure: YYMMDD
-seq_lane: Lane on Illumina NovaSeq S4 flow cell on which sample was run; options: 1 to 4
-seq_run: sequencing run; options 1 (original run) or 2 (re-sequenced samples)
-Mapped_reads_samtools_mio: Number of mapped reads (in millions) as determined by s
-Percent_rRNA:
-Per_Unique_mapped_Star: Percentage of uniquely mapped reads
-Aligned_Star: Number of aligned reads (in millions)



1. Alignment and Mapping
Alignment, mapping and counting of reads was performed using the Nextflow pipeline nf-core rnaseq 3.0 pipeline with STAR and Salmon for alignment and read mapping. The command used to start the run including all running parameters can be found in the ./nf_core/run_rnaseq.txt file. This folder also includes the input files in .csv format required for running nf-core rnaseq 3.0. These files include sample ID, replicate number and path to fastq files for reads 1 and 2 and information on strandedness of libraries. 

For convenience, .bam files and salmon pseudo count files (.sf) are provided in the raw_data folder. The nf-core rnaseq pipeline provides a MultiQC report which can be found in the ./nf-core folder.



3. Running provided R scripts

All R scripts used to perform the bioinformatic analysis can be found in the Prion_project/code folder. The scripts are meant to be run in the same order as specified below. Further information on input files, specification of run parameters and location of output files can also be found in the annotations.


3.1 QC script
Generates plots in 


3.2 DESeq2_analysis.Rmd

To run this script, the sample sets and disease for which the analysis should be performed has to be specified in the header under params. The parameters defines by params$disease_samples and params$control_samples take input as character strings identical to options in metadata$sample_set. params$disease requires the input "FFI" or "CJD" and is used for correct labelling and locating of output files. For convenience, a short overview of sample_set options is also provided in the script annotations.

Gene level statistics obtained from DESeq2 analysis are saved in a .csv file located in the ./result_files/<disease> subfolder. PCA and volcano plots are saved in the ./figures/DESeq2/<disease> subfolder. A txt-file with session info and an overview of analysed samples and DESeq2 run parameters is saved in the ./documentation subfolder.


3.3 plots_DESeq2_analysis.Rmd

This script is used to concatenate DESeq2_analysis.Rmd output files by disease and generates plots comparing the DESeq2 results by cell type and disease (Violinplots). 


3.4 GSEA_piano.Rmd
Uses the piano package 

Saves .csv 

3.5 GSEA_summary_plots.Rmd
Takes 

3.6 Topological_Network_analysis.Rmd

