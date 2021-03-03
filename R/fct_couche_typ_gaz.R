#' Carte mapview d'un type d'installations biomethane du territoire selectionne
#'
#' @param typ un motif de texte a retrouver dans le type des installations biomethane qui permet d'identifier un unique type
#' @param code_ter le code geo du territoire a visualiser, au format texte
#' @param col un entier entre 1 et 6 qui designe le type d'installation dans la palette col_biogaz
#' @param leg un boleen pour afficher ou non la legende de la carte, FALSE par defaut
#'
#' @return une carte mapview
#' @importFrom dplyr filter transmute mutate
#' @importFrom leafpop popupTable
#' @importFrom sf st_set_crs st_transform st_jitter
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' couche_typ_gaz(typ = "Agricole", code_ter = "52", col = 4)

couche_typ_gaz <- function(typ, code_ter, col=1, leg = FALSE) {
  
  inst <- dplyr::filter(enr.reseaux::inst_biogaz_reg, grepl(typ, .data$type), 
                        .data$REG==code_ter|.data$DEP==code_ter|.data$EPCI==code_ter) %>% 
    dplyr::transmute(commune = .data$NOM_DEPCOM,
                     installation = .data$nom_du_projet,
                     capacite_en_GWh_par_an = .data$capacite_de_production_gwh_an,
                     type = as.character(.data$type) %>% enc2utf8(),
                     mise_en_service = .data$date_de_mes,
                     iris = .data$NOM_IRIS) 
  
  
  if(nrow(inst)!=0) {
    inst <-  inst %>% 
      sf::st_set_crs(2154) %>% 
      sf::st_transform(4326) %>%
      sf::st_set_crs(4326) %>% 
      sf::st_jitter(factor = 0.008)
    
    tiquette = paste0("Capacit\u00e9 : ", inst$capacite_en_GWh_par_an, " GWh/an", " (", inst$type, ")") %>%
      enc2utf8()
    
    nom_couche <- inst$type[1] %>% enc2utf8()
    
    carte_fil <- mapview(inst, col.regions=enr.reseaux::col_biogaz[[col]], map.types = c("CartoDB.Positron"),
                         legend=leg, label=tiquette, 
                         popup = leafpop::popupTable(inst, zcol=c("commune","installation","capacite_en_GWh_par_an","type","mise_en_service","iris")),
                         cex="capacite_en_GWh_par_an", alpha = 0,
                         layer.name=nom_couche,
                         homebutton = FALSE)
  }  else { 
    carte_fil <- NULL
  }
  
  carte_fil
}

