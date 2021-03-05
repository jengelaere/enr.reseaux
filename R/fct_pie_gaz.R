#' Production des graphiques de repartition biogaz
#'
#' @param r la liste des objets reactifs de l'application
#' @param indic un motif de texte designant l'indicateur concerne
#' @param unite l'unite de la legende
#' @param fct_unite facteur de conversion d'unite, 1000 pour les injections annuelles, 1 pour les capacites
#' @return un graph ggiraph de repartition des installations biomethane par type
#' 
#' @importFrom dplyr arrange desc row_number inner_join filter
#' @importFrom rlang .data
#' @importFrom htmltools htmlEscape
#' @importFrom ggiraph geom_bar_interactive
#' @importFrom ggplot2 ggplot scale_fill_manual aes labs element_blank
#' @export
#'
#' @examples
#' 
#' r <- list(liste_ter = dplyr::filter(liste_zone_complete, CodeZone %in% c("200060010", "49", "52")),
#'           maille_terr = "Epci")
#' pie_gaz(r = r , indic = "capaci", unite = " GWh/an", fct_unite = 1)

pie_gaz <- function(r = r , indic = "capaci", unite = " GWh/an", fct_unite = 1) {
  
p <- dplyr::arrange(r$liste_ter, dplyr::desc(dplyr::row_number())) %>%
  dplyr::inner_join(enr.reseaux::indic_biogaz_epci_a_reg_reg) %>%
  dplyr::filter(grepl(indic, .data$indicateur), .data$annee==enr.reseaux::mil_gaz) %>%
  ggplot2::ggplot() + ggplot2::scale_fill_manual(values=enr.reseaux::col_biogaz)+
  ggiraph::geom_bar_interactive(ggplot2::aes(x=.data$Zone, y=.data$valeur, fill=.data$type,
                           tooltip = paste0(.data$type, " : ", prettyNum(round(.data$valeur/fct_unite, 1), decimal.mark = ","), unite) %>% enc2utf8() %>%
                             htmltools::htmlEscape(TRUE)) ,
                       stat="identity", position="fill") +
  ggplot2::labs(title=ggplot2::element_blank(), x=ggplot2::element_blank(), y=ggplot2::element_blank(), colour = NULL, fill=NULL)

enr.reseaux::girafeTEO_pie(p, r$maille_terr)
}
