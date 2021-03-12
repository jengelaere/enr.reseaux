#' tab_inst_elec, filtre et mise en forme de la table des installations de production electrique ENRR
#'
#' @param ter le territoire a visualiser
#'
#' @return un dataframe
#' @importFrom dplyr filter mutate arrange desc select select_if
#' @importFrom rlang .data
#' @importFrom lubridate year
#' @export
#'
#' @examples
#' tab_inst_elec("49")
#' 

tab_inst_elec <- function(ter) {
  dplyr::filter(enr.reseaux::inst_reg, .data$REG == ter | .data$DEP == ter | .data$EPCI == ter) %>% 
    as.data.frame() %>%
    dplyr::mutate(part_EnR = .data$part_EnR * 100, 
                  date_inst = lubridate::year(.data$date_inst)) %>%
    dplyr::arrange(dplyr::desc(.data$puiss_MW), .data$NOM_DEPCOM, .data$typo, .data$nominstallation) %>%
    dplyr::select(commune = .data$NOM_DEPCOM, Installation = .data$nominstallation, 'puissance (MW)'= .data$puiss_MW, type = .data$typo,
                  .data$combustible, 'combustible secondaire' = .data$combustiblessecondaires, 'nombre de m\u00e2ts' = .data$nbgroupes,
                  'production annuelle (MWh)' = .data$prod_MWh_an, 'part renouvelable (%)'= .data$part_EnR,
                  'mise en service' = .data$date_inst, -.data$geometry) %>%
    dplyr::select_if(enr.reseaux:::is_not_empty) %>% 
    dplyr::select_if(enr.reseaux:::is_pas_zero) 
}
