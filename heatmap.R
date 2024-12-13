## Script to make heatmaps based on protein / DNA identity. 

##Load the librarires needed
library("ape")
library("ips")
library(tidyverse)
library(ggtree)
library(phytools)
library(ggrepel)
library(ggnewscale)
library(shadowtext)
install.packages("devtools")
devtools::install_github("TS404/AlignStat")
library("AlignStat")
library(bio3d)
library(pheatmap)
library(RColorBrewer)
library(dendsort)
read.a

dna_align<- read.fasta("aux1_muscle.aln")   ###import DNA alignment in fasta sequence

##dna<-read.fasta("aux1_immunity.fasta")  If we want to do the alignment in R, we can import the unaligned fasta sequence


ide.mat<-seqidentity(dna_align)  ### create the identity matrix


filt.id<-filter.identity(aln=dna_align,cutoff=0.3)  ## hierarchical clustering, we can choose cutoff to give the number of families

pheat<-pheatmap(filt.id$ide,cutree_rows=2, display_numbers = T,number_color = "black",color = hcl.colors(50, "Oranges"),number_format = "%.4f",border_color = "black") ##original heatmap

mm <- as.matrix(c(1:100))
breaks <- c(0.01,0.30,0.999,1)   ###create the limits of family / subfamily / identical
colors <- c("indianred3","gold","olivedrab3") ## colors for each group

pp<-pheatmap(mm,cluster_rows=FALSE, cluster_cols=FALSE,
             breaks=breaks, color=colors, legend=T)
changeLegend(breaks, colors)
pheat<-pheatmap(filt.id$ide,cutree_rows=2, display_numbers = T,number_color = "black", breaks=breaks, color=colors,number_format = "%.4f",border_color = "black",legend=F,treeheight_row = 150,treeheight_col = 0) ##final heatmap


###create the pdf

pdf("heatmap.pdf",width=24, height=10)
pheat
dev.off()

