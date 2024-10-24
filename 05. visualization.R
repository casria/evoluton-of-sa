## line chart
library(ggalt)
library(ggplot2)
library(cowplot)

options(scipen = 200)

# Input files
indica.pi <- read.table("indica.chr01.20k.5k.windowed.pi",header = T)
japonica.pi <- read.table("japonica.chr01.20k.5k.windowed.pi",header = T)
SouthAsia_indica.pi <- read.table("SouthAsia_indica.chr01.20k.5k.windowed.pi",header = T)

Rufipogon_indica.fst <- read.table("Rufipogon-indica.20k.5k.windowed.weir.fst",header = T)
Rufipogon_japonica.fst <- read.table("Rufipogon-japonica.20k.5k.windowed.weir.fst",header = T)
SouthAsia_indica_Rufipogon.fst <- read.table("Rufipogon-SouthAsia_indica.20k.5k.windowed.weir.fst",header = T)

# Picture
indica.pi<-indica.pi[(indica.pi$BIN_START >= 21890001 & indica.pi$BIN_START <= 22890001), ]
japonica.pi<-japonica.pi[(japonica.pi$BIN_START >= 21890001 & japonica.pi$BIN_START <= 22890001), ]
SouthAsia_indica.pi<-SouthAsia_indica.pi[(SouthAsia_indica.pi$BIN_START >= 21890001 & SouthAsia_indica.pi$BIN_START <= 22890001), ]

indica.pi$middle <- (indica.pi$BIN_START + indica.pi$BIN_END) / 2
japonica.pi$middle <- (japonica.pi$BIN_START + japonica.pi$BIN_END) / 2
SouthAsia_indica.pi$middle <- (SouthAsia_indica.pi$BIN_START + SouthAsia_indica.pi$BIN_END) / 2

indica.pi$source <- "indica"
japonica.pi$source <- "japonica"

pi<-rbind(indica.pi,japonica.pi) 
pi_figure <- ggplot(pi, aes(x=middle, y = PI, color=source)) +
  labs(title = "pi",
       x = "Chr 1",
       y = "PI") +
  theme_classic()+
  theme(axis.text.x = element_text(color = "black"),
        axis.text.y = element_text(color = "black"))+
  scale_y_continuous(limits = c(0, 0.018), breaks = seq(0, 0.018, by = 0.001))+
  geom_xspline(spline_shape = -0.5)+
  geom_vline(xintercept = c(22370001, 22390000), linetype = "dashed", color = "black")

pi_figure
  
Rufipogon_indica.fst <- Rufipogon_indica.fst[(Rufipogon_indica.fst$BIN_START >= 21890001 & Rufipogon_indica.fst$BIN_START <= 22890001), ]
Rufipogon_japonica.fst <- Rufipogon_japonica.fst[(Rufipogon_japonica.fst$BIN_START >= 21890001 & Rufipogon_japonica.fst$BIN_START <= 22890001), ]

Rufipogon_indica.fst$middle <- (Rufipogon_indica.fst$BIN_START + Rufipogon_indica.fst$BIN_END) / 2
Rufipogon_japonica.fst$middle <- (Rufipogon_japonica.fst$BIN_START + Rufipogon_japonica.fst$BIN_END) / 2

Rufipogon_indica.fst$source <- "Rufipogon_indica"
Rufipogon_japonica.fst$source <- "Rufipogon_japonica"

fst<-rbind(Rufipogon_indica.fst,Rufipogon_japonica.fst) 
fst_figure <- ggplot(fst, aes(x =middle, y = WEIGHTED_FST, color=source)) +
  labs(title = "fst",
       x = "Chr 1",
       y = "fst") +
  theme_classic()+
  theme(axis.text.x = element_text(color = "black"),
        axis.text.y = element_text(color = "black"))+
  scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.1))+
  geom_xspline(spline_shape = -0.5)+
  geom_vline(xintercept = c(22370001, 22390000), linetype = "dashed", color = "black")
fst_figure

SouthAsia_indica.pi_figure <- ggplot(SouthAsia_indica.pi, aes(x =middle, y = PI)) +
  labs(title = "SouthAsia_indica.pi",
       x = "Chr 1",
       y = "PI") +
  theme_classic()+
  theme(axis.text.x = element_text(color = "black"),
        axis.text.y = element_text(color = "black"))+
  scale_y_continuous(limits = c(0, 0.018), breaks = seq(0, 0.018, by = 0.001))+
  geom_xspline(spline_shape = -0.5)+
  geom_vline(xintercept = c(22370001, 22390000), linetype = "dashed", color = "black")
SouthAsia_indica.pi_figure

SouthAsia_indica_Rufipogon.fst <-SouthAsia_indica_Rufipogon.fst [(SouthAsia_indica_Rufipogon.fst $BIN_START >= 21890001 & SouthAsia_indica_Rufipogon.fst $BIN_START <= 22890001), ]
SouthAsia_indica_Rufipogon.fst$middle <- (SouthAsia_indica_Rufipogon.fst$BIN_START + SouthAsia_indica_Rufipogon.fst$BIN_END) / 2

SouthAsia_indica_Rufipogon.fst_figure <- ggplot(SouthAsia_indica_Rufipogon.fst, aes(x =middle, y = WEIGHTED_FST)) +
  labs(title = "SouthAsia_indica_Rufipogon.fst",
       x = "Chr 1",
       y = "SouthAsia_indica_Rufipogon.fst") +
  theme_classic()+
  theme(axis.text.x = element_text(color = "black"),
        axis.text.y = element_text(color = "black"))+
  scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.1))+
  geom_xspline(spline_shape = -0.5)+
  geom_vline(xintercept = c(22370001, 22390000), linetype = "dashed", color = "black")
SouthAsia_indica_Rufipogon.fst_figure

ggsave("fst.pdf", plot = fst_figure, width = 12, height = 6, limitsize = FALSE)
ggsave("pi.pdf", plot = pi_figure, width = 12, height = 6, limitsize = FALSE)

# heatmap
library(reshape2)
library(ggplot2)
library (dplyr)

haplotype <- read.table("hap17.txt",header = T,sep="\t",fill = TRUE,na.strings = "")
haplotype_convert <- melt(haplotype,id.vars=c("Species"))


haplotype_percentage <- haplotype_convert %>%
  group_by(Species) %>%
  mutate(percent = paste0(format(round(value/sum(value)*100, 1), nsmall = 1), "%"),
         count = paste0(format(round(value/sum(value)*100, 1), nsmall = 1)))

haplotype_percentage$Species <- factor(haplotype_percentage$Species, levels = rev(unique(haplotype_percentage$Species)))
haplotype_figure <- ggplot(haplotype_percentage, aes(x = variable, y = Species)) +
  geom_tile(aes(fill = as.numeric(count))) +
  geom_text(aes(label = percent), vjust = 1) +
  scale_fill_gradient(low = "white", high = "red") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),panel.background = element_blank())
haplotype_figure
ggsave("heatmap.pdf", plot = haplotype_figure, width = 9, height = 6, limitsize = FALSE)

# Geographical distribution visualization
library(xlsx)
library(ggplot2)
library(maps)

data <- read.xlsx("wild Group2.xlsx",1)
country_data <- read.xlsx("wild Group2.xlsx",2)

country_names <- data$Region

country_counts <- table(country_names)

world_map <- map_data("world")

map_plot <- ggplot() +
  geom_polygon(data = world_map, aes(x = long, y = lat, group = group), fill = "lightblue") +
  geom_point(data = country_data, aes(x = long, y = lati, color = country, size = counts), shape = 16) +
  coord_fixed() +
  theme_minimal()

map_plot
# 显示交互式地图
print(interactive_map)
