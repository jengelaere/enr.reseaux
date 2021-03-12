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
    cont = sf::st_geometry(enr.reseaux::carto_reg) %>% sf::st_set_crs(2154),
    # couches composant les cartes d'installations electriques
    carte_PV = enr.reseaux::couche_fil("pvq", enr.reseaux::reg, 6),
    carte_bois = enr.reseaux::couche_fil("bois", enr.reseaux::reg, 1),
    carte_dechet = enr.reseaux::couche_fil("dechet", enr.reseaux::reg, 2),
    carte_hydro = enr.reseaux::couche_fil("hydro", enr.reseaux::reg, 3),
    carte_metha = enr.reseaux::couche_fil("metha", enr.reseaux::reg, 4),
    carte_eol = enr.reseaux::couche_fil("eol", enr.reseaux::reg, 5),
    # couches composant les cartes d'installations biomethane
    carte_agri = enr.reseaux::couche_typ_gaz("Agricole", enr.reseaux::reg, 4),
    carte_dechet = enr.reseaux::couche_typ_gaz("D\u00e9chets m\u00e9nagers", enr.reseaux::reg, 1),
    carte_indust = enr.reseaux::couche_typ_gaz("Industriel", enr.reseaux::reg, 6),
    carte_isdnd = enr.reseaux::couche_typ_gaz("ISDND", enr.reseaux::reg, 2),
    carte_step = enr.reseaux::couche_typ_gaz("Station d\'\u00e9puration", enr.reseaux::reg, 3),
    carte_terri = enr.reseaux::couche_typ_gaz("Territorial", enr.reseaux::reg, 5),
    contours = mapview::mapview(sf::st_geometry(enr.reseaux::carto_reg) %>% sf::st_set_crs(2154),
                                legend=FALSE, map.types = c("CartoDB.Positron"), col="gray", alpha = 1,
                                col.regions="papayawhip", alpha.regions=0.15, homebutton=TRUE, label=NULL, layer.name="Contours")
    
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

