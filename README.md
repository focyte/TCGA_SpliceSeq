# TCGA_SpliceSeq

Splicing of nascent pre-mRNA is a fundamental process in gene expression; involving the removal of intronic mRNA and the joining together of exonic mRNA.
This process is important for generation of a mature mRNA transcript from genes during transcription.
Alternative splicing (AS) occurs when there is a differential selection of exons and/or introns in the final mature mRNA transcript. The inclusion or exclusion of specific mRNA elements through AS can have a significant impact on the protein translated from the mRNA.
In diseases such as cancer, disruption to the sequence of a given gene, and/or changes to the expression levels, activation status, or localisation of the proteins involved in splicing of that gene can cause changes to AS.

TCGA SpliceSeq contains useful data for splicing events in Cancer:

> TCGA SpliceSeq is a resource for investigation of cross-tumor and tumor-normal alterations in mRNA splicing patterns of The Cancer Genome Atlas project (TCGA) RNASeq data.

Whilst the [TCGA SpliceSeq website](https://bioinformatics.mdanderson.org/TCGASpliceSeq/index.jsp) and [Java based program](https://bioinformatics.mdanderson.org/public-software/spliceseq/methods/) provides some useful visualisation tools, I have generated some scripts to analyse and visualise these data in R.

## Normal_vs_tumour 

Comparison of Percentage Spliced In (PSI) values for Normal versus Tumour tissue in samples from TCGA SpliceSeq data.

Example: For this example, I have generated a plot to show the different usage of an alternative promoter (AP) exon in the VAV3 gene in Squamous Cell Lung Cancer (LUSC). You can see that this AP exon 18.1 is significantly more included in VAV3 mRNA in tumour samples compared to normal tissue.

![VAV3](https://user-images.githubusercontent.com/18528125/171668239-1c0c3a70-d610-4bc3-b1b1-700b28abe651.png)

