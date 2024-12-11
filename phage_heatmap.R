#load the needed libraries (if not present, install them with install.packages"")
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


#load the data. heare data_heatmap is a matrix with phage as column and strain as lines.)
data_heat<-read.table("data_heatmap.txt",row.names=1 , header=TRUE)

#load the taxonomiy for each phage and match with the colnames of the previous matrix
fam<-read.table("Family.txt",header=T)
rownames(fam)<-colnames(data_heat)

##create the boundaries for the heatmap
mm <- as.matrix(c(1:100))
breaks <- c(2,10,100,1000,10000)   ###create the limits of family / subfamily / identical


generate_palette("red", blend_colour = "black", 
                 n_colours = 6, view_palette = TRUE, view_labels = FALSE)

colors_group <- c("#FFFFFF","#FF7F7F","#FF0000","#7F0000","#000000") ## colors for each group

fun_color_range<-colorRampPalette(c("white","red","black")) 
fun_color_range(5)

colorRampPalette(c(rgb(0,0,1,1), rgb(0,0,1,0)), alpha = TRUE)(8)


#set colors for taxonomy
colors<-list(Family=c("Drexlerviridae"="red","Dhillonvirus"="pink", "Queuovirinae"="yellow","Demerecviridae"="green","Tevenvirinae"="green4","Vequintavirinae"="cornflowerblue","Stephanstirmvirinae"="blue3","Autographiviridae"="darkorchid4","Other"="grey"),
            Subfam=c("D1"="red","D2"="red2","D3"="red3","DH1"="pink","Q1"="yellow","DE1"="green","T1"="green4","V1"="cornflowerblue","S1"="blue3","S2"="blue4","O1"="grey","A1"="darkorchid4"),
            Genus=c("GD1"="red","GD2"="red2","GD3"="red3","GD4"="red4","GD5"="firebrick","GD6"="firebrick3","GD13"="firebrick4","GDH1"="pink","GQ1"="yellow","GQ2"="yellow3","DM1"="green1","DM2"="green2","TE1"="green3","TE2"="green4","VE1"="cornflowerblue","ST1"="blue3","ST2"="blue3","AU1"="darkorchid4","AU2"="darkorchid3","AU3"="darkorchid2","OT1"="grey"))



#create the heatmap. breaks correspond to the wanted threshold of fold protection
pheat<-pheatmap(data_heat, breaks=breaks, color=colors_group,number_format = "%.4f",border_color = "black",legend=T,treeheight_row = 0,treeheight_col = 0, cluster_rows=F,cluster_cols = F, annotation_col = fam, annotation_colors =colors,gaps_col = c(9, 14,21,31,46,58,61,67),cellwidth=10,cellheight = 10,annotation_names_col = TRUE)



###create the pdf

pdf("test_heatmap_red.pdf",width=14, height=8)
pheat
dev.off()

