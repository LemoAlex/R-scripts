library("ape")
library("ips")
library(tidyverse)
library(ggtree)
library(phytools)
library(ggrepel)
library(ggnewscale)
library(shadowtext)
#install.packages("devtools")
#devtools::install_github("TS404/AlignStat")
library("AlignStat")
library(bio3d)
library(pheatmap)
library(RColorBrewer)
library(dendsort)
library(monochromeR)

dna_align <- read.fasta("subset.fa")   ###import DNA alignment in fasta sequence from the MUSCLE alignment
dna_align <- read.alignment("subset.fa",format="fasta") 
pairwiseCount(x = ide.mat)
##dna<-read.fasta("LC_immunity.fasta")  If we want to do the alignment in R, we can import the fasta sequence



data_heat<-read.table("data_heatmap.txt",row.names=1 , header=TRUE)


###create the pdf

pdf("LC_heatmap_new2.pdf",width=24, height=10)
pheat
dev.off()





#filt.id<-filter.identity(aln=dna_align,cutoff=0.3)  ## hierarchical clustering, we can choose cutoff to give the number of families

#pheat<-pheatmap(filt.id$ide,cutree_rows=2, display_numbers = T,number_color = "black",color = hcl.colors(50, "Oranges"),number_format = "%.4f",border_color = "black") ##original heatmap

mm <- as.matrix(c(1:100))
breaks <- c(2,10,100,1000,10000)   ###create the limits of family / subfamily / identical


generate_palette("red", blend_colour = "black", 
                 n_colours = 6, view_palette = TRUE, view_labels = FALSE)

colors_group <- c("#FFFFFF","#FF7F7F","#FF0000","#7F0000","#000000") ## colors for each group

fun_color_range<-colorRampPalette(c("white","red","black")) 
fun_color_range(5)

colorRampPalette(c(rgb(0,0,1,1), rgb(0,0,1,0)), alpha = TRUE)(8)

fam<-read.table("Family.txt",header=T)
rownames(fam)<-colnames(data_heat)

colors<-list(Family=c("Drexlerviridae"="red","Dhillonvirus"="pink", "Queuovirinae"="yellow","Demerecviridae"="green","Tevenvirinae"="green4","Vequintavirinae"="cornflowerblue","Stephanstirmvirinae"="blue3","Autographiviridae"="darkorchid4","Other"="grey"),
            Subfam=c("D1"="red","D2"="red2","D3"="red3","DH1"="pink","Q1"="yellow","DE1"="green","T1"="green4","V1"="cornflowerblue","S1"="blue3","S2"="blue4","O1"="grey","A1"="darkorchid4"),
            Genus=c("GD1"="red","GD2"="red2","GD3"="red3","GD4"="red4","GD5"="firebrick","GD6"="firebrick3","GD13"="firebrick4","GDH1"="pink","GQ1"="yellow","GQ2"="yellow3","DM1"="green1","DM2"="green2","TE1"="green3","TE2"="green4","VE1"="cornflowerblue","ST1"="blue3","ST2"="blue3","AU1"="darkorchid4","AU2"="darkorchid3","AU3"="darkorchid2","OT1"="grey"))




pheat<-pheatmap(data_heat, breaks=breaks, color=colors_group,number_format = "%.4f",border_color = "black",legend=T,treeheight_row = 0,treeheight_col = 0, cluster_rows=F,cluster_cols = F, annotation_col = fam, annotation_colors =colors,gaps_col = c(9, 14,21,31,46,58,61,67),cellwidth=10,cellheight = 10,annotation_names_col = TRUE)


#pp<-pheatmap(mm,cluster_rows=FALSE, cluster_cols=FALSE,
#            breaks=breaks, color=colors, legend=T)
#changeLegend(breaks, colors)


###create the pdf

pdf("test_heatmap_red.pdf",width=14, height=8)
pheat
dev.off()

