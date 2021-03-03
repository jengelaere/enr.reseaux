## code to prepare `indicateurs.RData` dataset goes here
library(sf)
library(purrr)
library(dplyr)

rm(list = ls())
# Chargement du RData produit par le script de collecte : 
# https://gitlab.com/dreal-datalab/enr_reseaux_teo/-/blob/master/collecte/indicateurs.Rmd
load("old/app/data_appli.RData")
data_name <- ls()

# data_list <- lapply(X = data_name, FUN = get) %>% 
#   set_names(data_name)
# lapply(X = data_list, FUN = usethis::use_data, overwrite = TRUE) 
# 
# purrr:: map(.x = data_name, .f = ~ usethis::use_data(get(.x), overwrite = TRUE))
# 
# for (x in data_list) {
#   usethis::use_data(x, overwrite = TRUE)
# }
# paste0("usethis::use_data(", data_name, ", overwrite = TRUE)  ", collapse = " ")
  

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

purrr::map(.x = data_name, .f = ~ utilitaires.ju::use_data_doc(name = .x, source = "DREAL PdL - TEO"))

