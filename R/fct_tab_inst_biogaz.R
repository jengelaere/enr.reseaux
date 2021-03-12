#' tab_inst_biogaz, filtre et mise en forme de la table des points d'injection biomethane
#'
#' @param ter le territoire a visualiser
#'
#' @return un dataframe
#' @importFrom dplyr filter arrange desc select
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' tab_inst_biogaz("49")

tab_inst_biogaz <- function(ter = "49") {
  dplyr::filter(enr.reseaux::inst_biogaz_reg, .data$REG == ter | .data$DEP == ter | .data$EPCI == ter) %>%
    as.data.frame() %>%
    dplyr::arrange(dplyr::desc(.data$capacite_de_production_gwh_an), .data$NOM_DEPCOM, .data$type, .data$nom_du_projet) %>%
    dplyr::select(commune = .data$NOM_DEPCOM, installation = .data$nom_du_projet, 'capacit\u00e9 (GWh/an)' = .data$capacite_de_production_gwh_an, 
                  .data$type, 'mise en service' = .data$date_de_mes, iris = .data$NOM_IRIS, -.data$geometry)
}
