#' Enedis_com_a_reg
#'
#' Les indicateurs electricite renouvelable de la source Enedis, de la commune a la region.
#'
#' @format A data frame with 139620 rows and 8 variables:
#' \describe{
#'   \item{ TypeZone }{  factor }
#'   \item{ CodeZone }{  factor }
#'   \item{ Filiere.de.production }{  factor }
#'   \item{ annee }{  factor }
#'   \item{ indicateur }{  factor }
#'   \item{ valeur }{  numeric }
#'   \item{ estimation }{  logical }
#'   \item{ type_estimation }{  factor }
#' }
#' @source DREAL PdL - TEO
"Enedis_com_a_reg"

#' indic_biogaz_epci_a_reg_reg
#'
#' Les indicateurs biomethane, de l'epci a la region.
#'
#' @format A data frame with 9828 rows and 8 variables:
#' \describe{
#'   \item{ CodeZone }{  factor }
#'   \item{ Zone }{  factor }
#'   \item{ type }{  factor }
#'   \item{ annee }{  factor }
#'   \item{ source }{  list }
#'   \item{ TypeZone }{  factor }
#'   \item{ indicateur }{  character }
#'   \item{ valeur }{  numeric }
#' }
#' @source DREAL PdL - TEO
"indic_biogaz_epci_a_reg_reg"

#' indic_epci_a_reg
#'
#' Indicateurs de production/consommation de l'epci à la region, au format large.
#'
#' @format A data frame with 78 rows and 12 variables:
#' \describe{
#'   \item{ TypeZone }{  factor }
#'   \item{ CodeZone }{  factor }
#'   \item{ Zone }{  factor }
#'   \item{ prod_GWh }{  numeric }
#'   \item{ CONSO_GWH }{  numeric }
#'   \item{ pourcent_enrr }{  numeric }
#'   \item{ injections_GWh }{  numeric }
#'   \item{ conso_gaz_GWh }{  numeric }
#'   \item{ pourcent_bioch4 }{  numeric }
#'   \item{ source_inject }{  list }
#'   \item{ source_conso_gaz }{  list }
#'   \item{ Sources }{  factor }
#' }
#' @source DREAL PdL - TEO
"indic_epci_a_reg"

#' indic_registre
#'
#' Les indicateurs electricite renouvelable de la source registre, de la commune a la region.
#'
#' @format A data frame with 62810 rows and 4 variables:
#' \describe{
#'   \item{ CodeZone }{  factor }
#'   \item{ variable }{  factor }
#'   \item{ valeur }{  numeric }
#'   \item{ TypeZone }{  factor }
#' }
#' @source DREAL PdL - TEO
"indic_registre"


