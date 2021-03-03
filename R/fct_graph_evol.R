
#' graph_evol une fonction pour les graphiques d'evolution des puissances installees et de nombre d'installations des filieres electriques
#'
#' @param fil un motif de caractere contenu dans le libelle de la filiere Enedis (Filiere.de.production)
#' @param indic un motif de caractere pour indentifier l'indicateur Enedis
#' @param territoires une liste de territoires, structuree comme liste_zone_complete
#' 
#' @return un graphique interactif ggiraph 
#' 
#' @importFrom dplyr mutate bind_rows inner_join filter group_by arrange if_else ungroup
#' @importFrom ggiraph geom_line_interactive geom_point_interactive
#' @importFrom ggplot2 aes scale_colour_manual
#' @importFrom ggthemes scale_color_economist
#' @importFrom htmltools htmlEscape
#' @importFrom lubridate year
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' liste_ter <- dplyr::filter(liste_zone_complete, CodeZone %in% c("200060010", "49", "52"))
#' graph_evol(fil = "Eol", indic = "Puissance", liste_ter)
#' 

graph_evol <- function(fil, indic, territoires) {
  
  data_evol <- enr.reseaux::Enedis_com_a_reg %>% 
    dplyr::mutate(type_estimation = "0_realise") %>% 
    dplyr::bind_rows(enr.reseaux::obj_reg) %>%
    dplyr::inner_join(territoires, .data, by = c("TypeZone", "CodeZone")) %>%
    dplyr::filter(grepl(fil, .data$Filiere.de.production), grepl(indic, .data$indicateur)) %>%
    dplyr::mutate(annee = as.Date(paste0(.data$annee, "-12-31")),
                  Zone = forcats::fct_inorder(as.character(.data$Zone)), 
                  CodeZone = forcats::fct_inorder(as.character(.data$CodeZone)),
                  valeur = ifelse(grepl("Nombre", .data$indicateur), .data$valeur, .data$valeur/1000),
                  tooltip = ifelse(grepl("Nombre", .data$indicateur), prettyNum(.data$valeur, big.mark = " "),
                                   paste0(round(.data$valeur, 1), " MW")))
  
  if("Epci" %in% territoires$TypeZone) { # pour choix d'un epci
    
    data_evol <- data_evol %>%
      dplyr::filter(lubridate::year(.data$annee) <= enr.reseaux::mil) %>% 
      dplyr::group_by(.data$Filiere.de.production, .data$CodeZone) %>%
      dplyr::arrange(.data$annee) %>%
      dplyr::mutate(valeur_cor = dplyr::if_else(.data$valeur < 0.5 & grepl("Puissance", .data$indicateur), 0.5, .data$valeur),
                    valeur_indiciee=dplyr::if_else(.data$valeur_cor/.data$valeur_cor[1]*100 > 500, 500, .data$valeur_cor/.data$valeur_cor[1]*100)) %>%
      dplyr::ungroup()
    
    ggteo(data_evol) +
      ggiraph::geom_line_interactive(ggplot2::aes(x=.data$annee, y=.data$valeur_indiciee, color=.data$Zone,
                                                  tooltip=paste0(htmltools::htmlEscape(.data$Zone, TRUE))), size=2 ) +
      ggiraph::geom_point_interactive(ggplot2::aes(x=.data$annee, y=.data$valeur_indiciee, color=.data$Zone, 
                                                   tooltip=.data$tooltip), size=1 ) +
      ggthemes::scale_color_economist()
    
  } else { # pour choix de la région ou d'un département
    
    if("D\u00e9partements" %in% territoires$TypeZone) {
        ggteo(data_evol) + 
        ggiraph::geom_line_interactive(ggplot2::aes(x=.data$annee, y=.data$valeur, color=.data$Zone,
                                                    tooltip=paste0(htmltools::htmlEscape(.data$Zone, TRUE))), size=2 ) +
        ggiraph::geom_point_interactive(ggplot2::aes(x=.data$annee, y=.data$valeur, color=.data$Zone, 
                                                     tooltip=.data$tooltip), size=1 ) + 
        ggplot2::scale_colour_manual(values = c(rep("#6794a7", nrow(territoires)-1), enr.reseaux::col_ter),
                                     label= c(rep("autres d\u00e9partements", nrow(territoires)-1), 
                                              as.character(territoires$Zone[nrow(territoires)])))
    } else {
      
      ggteo(data_evol) + ggiraph::geom_line_interactive(ggplot2::aes(x=.data$annee, y=.data$valeur, color=.data$type_estimation,
                                                                     tooltip=paste0(htmltools::htmlEscape(.data$Zone, TRUE))), size=2 ) +
        ggiraph::geom_point_interactive(ggplot2::aes(x=.data$annee, y=.data$valeur, color=.data$type_estimation, 
                                                     tooltip=.data$tooltip), size=1 ) +
        ggplot2::scale_colour_manual(values = c(enr.reseaux::col_ter, "ivory3"), label= c("r\u00e9alis\u00e9", "objectifs SRCAE")) # 
    }
  }
  
}
# exemple usage
# graph_evol(fil = "Eol", indic = "Puissance", liste_ter) + guides(colour="none")