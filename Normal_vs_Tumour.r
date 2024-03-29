# John @ Focyte created 17/05/2022 v.1.2
# Script performs a comparison of mean PSI for slected splicing event in Normal vs Tumour samples from TCGA splice-seq data
# Download your data from https://bioinformatics.mdanderson.org/public-software/tcgaspliceseq/

# Load required packages
library(dplyr)
library(tidyr) 
library(ggplot2) 
library(ggpubr)
library(readr)
library(data.table)

# add your config details:
# file name
# your favourite gene
# your favourite splicing event type e.g. ES for exon skipping
# number of exon/intron of interest

input = "PSI_download_LUSC.txt"
gene = "VAV3"
event_type = "AP"
location = "18.1"

# Import your file as a dataframe
df = read_tsv(input, col_names = TRUE)

# Choose a single splicing event
dfselect <- df %>% filter(symbol == gene & splice_type == event_type & exons == location)

#transpose
data_t <- setNames(data.frame(t(dfselect[ , - 1])), dfselect[ , 1])
setDT(data_t, keep.rownames = TRUE)[]

#remove unecessary rows
dfclean<-data_t[-c(1:9),]

#rename columns 
colnames(dfclean)<-c("Sample","PSI") 


#remove rows with null value 
dftemp<-dfclean[!(is.na(dfclean$"PSI") | dfclean$"PSI"=="null"),] 

#add a column to show if tissue is normal or tumour 
dftemp$Tissue_Type <- ifelse( 
  ( 
    (dftemp$Sample %like% c("Norm")) 
  ), 
  "Normal", 
  "Tumour"
) 

# Correct the data types 
dffinal<-transform(dftemp,Tissue_Type=as.character(Tissue_Type),PSI=as.numeric(PSI)) 

# DrawaViolinPlot 
title1 = sprintf("Gene : %s, Event Type : %s, Exon : %s", gene, event_type, location)
p<-ggplot(dffinal,aes(x=Tissue_Type,y=PSI,fill=Tissue_Type))+scale_fill_brewer(palette="Dark2")+labs(title= title1,x="Tissue Type",y="Percentage Spliced In (PSI)") + geom_violin() 

# perform a test comparing means  
# By default method = “wilcox.test” (non-parametric test). You can also specify method = “t.test” for a parametric t-test. 
compare_means(PSI~Tissue_Type,data=dffinal) 

# Print graph with points amd result of stats test
graph = p+stat_compare_means(method="wilcox.test", label.x = 1.5) + geom_jitter(shape=16, position=position_jitter(0.05)) + theme_light() + theme(legend.position="none")
graph
