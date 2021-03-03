
#' Selection des installations d'une filiere electrique et d'un territoire avec jitter des coord geo et passage en CRS 4326
#'
#' @description  Selection des installations d'une filiere et d'un territoire avec jitter des coord geo et passage en CRS 4326
#' @param fil un motif de texte a retrouver dans le code typo des installations electrique qui permet d'identifier une unique filiere
#' @param code_ter le code geo du territoire a visualiser, au format texte
#' @param typ_exclus un motif de texte a retrouver dans le code typo des installations electrique pour exclure ce type d'installation de la liste
#'
#' @return un tibble sf
#' @importFrom dplyr filter
#' @importFrom sf st_set_crs st_transform st_jitter
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' mes_instal(fil = "eol", code_ter = "200060010")

mes_instal <- function(fil, code_ter, typ_exclus="xxxxxxxxx"){
  dplyr::filter(enr.reseaux::inst_reg, grepl(fil, .data$code_typo), !grepl(typ_exclus, .data$code_typo),
                .data$REG==code_ter|.data$DEP==code_ter|.data$EPCI==code_ter) %>%
    sf::st_set_crs(2154) %>% 
    sf::st_transform(crs = 4326) %>%
    sf::st_set_crs(4326) %>% 
    sf::st_jitter(factor = 0.008)
  
}


#' Carte mapview des installations d'une filiere electrique du territoire selectionne
#'
#' @param fil un motif de texte a retrouver dans le code typo des installations electrique qui permet d'identifier un unique type
#' @param code_ter le code geo du territoire a visualiser, au format texte
#' @param col un entier entre 1 et 6 qui designe la filiere dans la palette col_registre
#' @param leg un boleen pour afficher ou non la legende de la carte, FALSE par defaut
#'
#' @return une carte mapview
#' @importFrom dplyr mutate transmute
#' @importFrom leafpop popupTable
#' @importFrom mapview mapview
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' couche_fil(fil = "eol", code_ter = "200060010", col = 5)

couche_fil <- function(fil, code_ter, col, leg = FALSE) {
  if(nrow(mes_instal(fil, code_ter)) > 0) {
    dta <- mes_instal(fil, code_ter) %>%
      dplyr::mutate(typo=as.character(.data$typo))  %>%
      dplyr::transmute(commune = .data$NOM_DEPCOM,
                       installation = .data$nominstallation,
                       puissance_en_MW =.data$ puiss_MW,
                       type = .data$typo,
                       part_renouvelable = .data$part_EnR,
                       mise_en_service = .data$date_inst)
    nom_couche <- dta$type[1]
    tiquette <- paste0(dta$puissance_en_MW, " MW", " (", dta$type, ")")
    carte_fil <- mapview::mapview(dta, zcol="type", col.regions=enr.reseaux::col_registre[[col]], map.types = c("CartoDB.Positron"),
                                  legend=leg, label=tiquette,
                                  popup = leafpop::popupTable(dta, zcol=c("commune","installation","puissance_en_MW","type","part_renouvelable","mise_en_service")),
                                  cex="puissance_en_MW", alpha = 0, layer.name=dta$type[1],
                                  homebutton = FALSE)
  }  else { carte_fil <- NULL}
  carte_fil
}


