library(reshape) # loads the library to rename the column names
library(ggplot2)
library(ggpubr)
library(viridis)
library(hrbrthemes)


# read in txt file
data <- read.table(file = "query.10kb_windows.read_DEPTH.txt")
# add column names for plotting easier
colnames(data) <- c("scaffold","start","stop","depth")

## get information for plotting (ie, xlim = Max. stop)
summary(data)

## make plot
t<-ggplot(data, aes(x=start, y=depth)) + 
  geom_line(data=data, color="#2c2a29", alpha=.8,size=.4) +
  theme_classic2() +
  labs(x="scaffold position", 
       y="mean read depth in 10kb windows",
       title="Depth of Illumina WGS reads mapping to ref") +
  scale_x_continuous(breaks = seq(0, 3300000, by=50000),expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(0, 50, by=5),expand = c(0, 0))
s<-t + coord_cartesian(default = FALSE, ylim = c(0, 50), xlim = c(0,3300000))
b<-s+grids(linetype = "dashed")
p1<- b + theme(axis.text=element_text(size=5), #change font size of axis text
               axis.title=element_text(size=15), #change font size of axis titles
               plot.title=element_text(size=18)) #change font size of plot title

## output plot to pdf
ggsave(p1, filename = "read_depth.pdf", width = 45, height = 5 )

