## code to prepare `couleurs` dataset goes here
library(enr.reseaux)

col_registre <- c("#A86137", "#BBD66B" , rgb(0, 163, 224, maxColorValue =255), rgb(72, 162, 63, maxColorValue =255),
                  rgb(0, 94, 184, maxColorValue =255), rgb(234, 170, 0, maxColorValue =255)) %>%
  setNames(levels(inst_reg$typo))

col_enedis <- c("Bio Energie"=col_registre[[4]], "Eolien"=col_registre[[5]], 
                "Hydraulique"=col_registre[[3]], "Photovoltaïque"=col_registre[[6]])

col_biogaz <- c("Déchets ménagers" = col_registre[[2]],
                "ISDND" = col_registre[[1]],
                "Station d'épuration" = col_registre[[3]],
                "Agricole" = col_registre[[4]],
                "Territorial" = col_registre[[6]],
                "Industriel" = col_registre[[5]])

col_ter <- "#01a2d9"

usethis::use_data(col_registre, col_enedis, col_ter, col_biogaz , overwrite = TRUE)
