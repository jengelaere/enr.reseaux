## code to prepare `indicateurs.RData` dataset goes here
library(sf)
library(purrr)
library(dplyr)

rm(list = ls())
# Chargement du RData produit par le script de collecte : 
# https://gitlab.com/dreal-datalab/enr_reseaux_teo/-/blob/master/collecte/indicateurs.Rmd
load("old/app/data_appli.RData")

# remove non ascii character in carto_iris
carto_iris <- st_transform(carto_iris, 2154)


# cure d'amaigrissement pouyr dvt

carto_com <- head(carto_com, 10)
carto_iris <- head(carto_iris, 10)
com_iris_csv_biogaz <- head(com_iris_csv_biogaz, 10)
com_iris_csv_elec <- head(com_iris_csv_elec, 10)
inst_reg <- head(inst_reg, 100)

Enedis_com_a_reg <- Enedis_com_a_reg %>% 
  filter(CodeZone %in% c("200060010", "49", "52")) 
indic_biogaz_epci_a_reg_reg <- indic_biogaz_epci_a_reg_reg %>% 
  filter(CodeZone %in% c("200060010", "49", "52")) 

indic_epci_a_reg <- indic_epci_a_reg %>% 
  filter(CodeZone %in% c("200060010", "49", "52")) 

indic_registre <- indic_registre %>% 
  filter(CodeZone %in% c("200060010", "49", "52")) 


usethis::use_data(carto_com, overwrite = TRUE)
usethis::use_data(carto_dep, overwrite = TRUE)
usethis::use_data(carto_epci, overwrite = TRUE)
usethis::use_data(carto_iris, overwrite = TRUE)
usethis::use_data(carto_reg, overwrite = TRUE)
usethis::use_data(com_iris_csv_biogaz, overwrite = TRUE)
usethis::use_data(com_iris_csv_elec, overwrite = TRUE)
usethis::use_data(date_registre_biogaz, overwrite = TRUE)
usethis::use_data(Enedis_com_a_reg, overwrite = TRUE)
usethis::use_data(indic_biogaz_epci_a_reg_reg, overwrite = TRUE)
usethis::use_data(indic_epci_a_reg, overwrite = TRUE)
usethis::use_data(indic_registre, overwrite = TRUE)
usethis::use_data(inst_biogaz_reg, overwrite = TRUE)
usethis::use_data(inst_reg, overwrite = TRUE)
usethis::use_data(lib_filiere, overwrite = TRUE)
usethis::use_data(liste_dep, overwrite = TRUE)
usethis::use_data(liste_zone_complete, overwrite = TRUE)
usethis::use_data(liste_zones, overwrite = TRUE)
usethis::use_data(liste_zones_dep, overwrite = TRUE)
usethis::use_data(metadatas, overwrite = TRUE)
usethis::use_data(mil, overwrite = TRUE)
usethis::use_data(mil_gaz, overwrite = TRUE)
usethis::use_data(obj_reg, overwrite = TRUE)
usethis::use_data(reg, overwrite = TRUE)
usethis::use_data(typo_registre, overwrite = TRUE)



data_name <- ls()
purrr::map(.x = data_name, .f = ~ utilitaires.ju::use_data_doc(name = .x, source = "DREAL PdL - TEO"))

