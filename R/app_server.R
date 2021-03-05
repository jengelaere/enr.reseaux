#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom dplyr filter mutate across everything
#' @importFrom sf st_geometry st_set_crs
#' @noRd

app_server <- function( input, output, session ) {
  
  zone_reg <- dplyr::filter(enr.reseaux::liste_zone_complete, .data$CodeZone == enr.reseaux::reg) %>% 
    dplyr::mutate(dplyr::across(dplyr::everything(), as.character))
  
  r <- reactiveValues(
    # on fixe les valeurs initiales des objets reactifs à la région
    mon_ter = enr.reseaux::reg,
    mon_dept = enr.reseaux::reg,
    liste_ter = zone_reg,
    maille_terr = zone_reg$TypeZone,
    lib_terr = zone_reg$Zone,
    ter_evol = zone_reg,
    leg_evol = "Source : ENEDIS jusque 2017 puis registre",
    leg_evol_MW = "MW - Source : ENEDIS jusque 2017 puis registre",
    cont = sf::st_geometry(enr.reseaux::carto_reg) %>% sf::st_set_crs(2154)
  )
  
  
  # List the first level callModules here
  mod_selection_server("selection_ui_1", r = r)
  mod_electr_server("electr_ui_1", r = r)
  mod_eol_server("eol_ui_1")
  mod_pv_server("pv_ui_1")
  mod_hydro_server("hydro_ui_1")
  mod_bio_server("bio_ui_1")
  mod_biogaz_server("biogaz_ui_1", r = r)
  mod_tel_server("tel_ui_1")
  mod_about_server("about_ui_1")
  
  }

