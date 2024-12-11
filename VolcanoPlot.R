
##### 1. set the correct working environment

setwd("/Users/lemopoul/Documents/R/VolcanoPlot")

#If needed, instal the needed libraries and then load them

install.packages("ggplot2")
install.packages("ggrepel")
library(ggplot2)
library(ggrepel)



####  2 Import the data

## the data needs to be a tab delimited text file in this format. Proteins that we don't want to label have empty cells instead of names

# Protein	logFC	p_value	Color	name
# AWB73894.1-A1552VC_01151-NC002505_VC1418	0.625886187	5.45E-09	blue	VC1418
# AWB73895.1-A1552VC_01152-NC002505_VC1419	0.680502596	4.32E-08	blue	VC1419
# AWB75475.1-A1552VC_A02811-NC002506_VCA0018	0.612750755	0.000143596	green	VCA0018
# AWB75477.1-A1552VC_A02813-NC002506_VCA0020	1.021975425	9.04E-12	green	VCA0020
# AWB73374.1-A1552VC_00613-NC002505_VC0855	0.264524879	0.014396849	grey50	
# AWB74884.1-A1552VC_02177-NC002505_VC2414	0.182480108	0.023065756	grey50	
# AWB74817.1-A1552VC_02104-NC002505_VC2342	0.096483585	0.131662082	grey50	




res <- read.table("data.txt", sep= "\t" , header=TRUE,na.strings=c("","NA")) #data.txt is your text file, you can change the name. the function replaces empty cells with NA value


#### 3. Draw the plot and save it


#create the plot using ggplot
#x,y and the labels correspond to the data headers
gg <- ggplot(data= res, aes(x= logFC, y= -log10(p_value), label= name,alpha=Color),size=5) +  ##alpha= Color will create the layers for the plot. it needs to be same size as the number of colors (4 = 4 colors)
  geom_point(col=res$Color)+
  scale_alpha_manual(values = c(1,1,0.3,1), guide = FALSE)+ ## here, we assign the transparency value (0=transparent, 1 = opaque). Here we have four colors, so four numbers. Order is alphabetical.
  geom_text_repel( data = subset(res,p_value < 0.01),  aes (label = name),max.overlaps=Inf,) +
  ## these 2 parameters (geom_vline and geom_hline) are for the significancy lines. remove them if you don't want lines, or change values to change the threshold
   geom_vline(xintercept = c(log2(0.5), log2(2)),
             linetype = "dashed")   + 
  geom_hline(yintercept = -log10(0.05),
             linetype = "dashed") + 
  ## Title. Change position by changing coordinates, and change text to change title  
  annotate("text", x = 0, y = 15,
           label = "Liquid pomAB vs WT", color = "Black",size=20)+ 
  theme_classic() 
gg

pdf(file=volcano)
