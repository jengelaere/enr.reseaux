## code to prepare `themes_ggplot` dataset goes here

library(ggplot2)
theme_TEO <- theme_bw() %+replace% 
  theme(panel.grid = element_blank(), legend.position = "bottom", plot.margin = margin(0,0,0,0, unit="pt"),
        text = element_text(family = "sans", color = "black", face="plain", size = 15, hjust=0.5, vjust=0.5, angle=0, 
                            lineheight=1, margin=margin(0,0,0,0, unit="pt"), debug=F), 
        axis.text = element_text(size = 14),
        panel.background = element_blank(), legend.text = element_text(size = 14), legend.margin = margin(0,0,0,0, unit="pt"),
        legend.direction="horizontal") 

theme_TEO_carto <- theme_TEO %+replace% theme(axis.text = element_blank(), axis.ticks=element_blank(), axis.line=element_blank(),
                                              strip.background=element_blank(), panel.grid = element_blank(), panel.border = element_blank(),
                                              legend.position = "bottom")







usethis::use_data(theme_TEO, overwrite = TRUE)
usethis::use_data(theme_TEO_carto, overwrite = TRUE)
