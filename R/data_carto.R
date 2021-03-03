#' carto_com
#'
#' Un dataset comprenant la geographie des communes de la region et quelques indicateurs des millesimes les plus recents à cartographier.
#'
#' @format A data frame with 1292 rows and 16 variables:
#' \describe{
#'   \item{ DEPCOM }{ code commune, factor }
#'   \item{ AREA }{ surface de la commune, units }
#'   \item{ geometry }{ contours de la commune, sfc_MULTIPOLYGON,sfc }
#'   \item{ Zone }{ Libelle de la commune, factor }
#'   \item{ CONSO_GWH }{ consommation electrique annuelle de la commune en GWh, numeric }
#'   \item{ EPCI }{ EPCI auquel appartient la commune, factor }
#'   \item{ prod_GWh }{ production electrique renouvelable annuelle de la commune, numeric }
#'   \item{ pourcent_enrr }{ part de la consommation electrique couverte par la production renouvelable, numeric }
#'   \item{ cat_prct_enrr }{ classe de l'indicateur part de la consommation electrique couverte par la production renouvelable, factor }
#'   \item{ injections_GWh }{ injections annuelles de biomethane de la commune, numeric }
#'   \item{ conso_gaz_GWh }{ consommation de gaz annuelle de la commune en GWh, numeric }
#'   \item{ pourcent_bioch4 }{ part de la consommation de gaz couverte par la production renouvelable, numeric }
#'   \item{ cat_prct_bioch4 }{ classe de l'indicateur part de la consommation de gaz couverte par la production renouvelable, factor }
#'   \item{ Sources }{ operateurs electriques competents sur la commune, factor }
#'   \item{ source_inject }{ source du volume annuel injecte de la commune : GRDF ou estimation DREAL, list }
#'   \item{ source_conso_gaz }{ operateurs gaziers competents sur la commune, list }
#' }
#' @source DREAL PdL - TEO
"carto_com"


#' carto_iris
#'
#' Un dataset comprenant la geographie des IRIS de la region et quelques indicateurs à cartographier.
#' Les IRIS, ou Ilots Regroupes pour l'Information Statistique, sont un zonage infracommunal defini par l'INSEE et l'IGN.
#'
#' @format A data frame with 2009 rows and 19 variables:
#' \describe{
#'   \item{ CODE_IRIS }{ Code IRIS, factor }
#'   \item{ CONSO_GWH }{ Consommation electrique annuelle de l'IRIS en GWh, numeric }
#'   \item{ Sources }{ operateurs electriques competents sur l'IRIS, factor }
#'   \item{ sce_estim }{ origine de la consommation electrique : donnee SDES brute ou estimation DREAL d'un agregat secretise, factor }
#'   \item{ geometry }{ contours de l'iris, sfc_MULTIPOLYGON,sfc }
#'   \item{ prod_GWh }{ production electrique renouvelable annuelle de l'IRIS, numeric }
#'   \item{ pourcent_enrr }{ part de la consommation electrique couverte par la production renouvelable, numeric }
#'   \item{ cat_prct_enrr }{ classe de l'indicateur part de la consommation electrique couverte par la production renouvelable, factor }
#'   \item{ NOM_IRIS }{ Nom de l'IRIS, factor }
#'   \item{ TYP_IRIS }{ Type de l'IRIS : habitat (H), activités économiques (A), divers (D) et commune non irisee (Z) plus d'info sur https://www.insee.fr/fr/information/2438155, factor }
#'   \item{ DEPCOM }{ code de la commune à laquelle appartient l'IRIS, factor }
#'   \item{ source_inject }{ source du volume annuel injecte de l'IRIS : GRDF ou estimation DREAL, list }
#'   \item{ injections_GWh }{ injections annuelles de biomethane de l'IRIS, numeric }
#'   \item{ conso_gaz_GWh }{ consommation de gaz annuelle de l'IRIS en GWh, numeric }
#'   \item{ source_conso_gaz }{ operateurs gaziers competents sur l'IRIS, list }
#'   \item{ pourcent_bioch4 }{ part de la consommation de gaz couverte par la production renouvelable, numeric }
#'   \item{ cat_prct_bioch4 }{ classe de l'indicateur part de la consommation de gaz couverte par la production renouvelable, factor }
#'   \item{ EPCI }{ code de l'EPCI d'appartenance de l'IRIS, factor }
#'   \item{ DEP }{ code du departement d'appartenance de l'IRIS, factor }
#' }
#' @source DREAL PdL - TEO
"carto_iris"


#' carto_epci
#'
#' Un dataset comprenant la geographie des EPCI de la region et quelques indicateurs à cartographier.
#'
#' @format A data frame with 72 rows and 9 variables:
#' \describe{
#'   \item{ EPCI }{ code de l'EPCI, factor }
#'   \item{ AREA }{ surface de l'EPCI, units }
#'   \item{ geometry }{ contours geographiques de l'EPCI, sfc_GEOMETRY,sfc }
#'   \item{ Echelle }{ echelle du dataset, factor }
#'   \item{ Zone }{ libelle de l'EPCI, factor }
#'   \item{ pourcent_enrr }{ part de la consommation electrique par la production renouvelable, numeric }
#'   \item{ cat_prct_enrr }{ classe de l'indicateur part de la consommation electrique par la production renouvelable, factor }
#'   \item{ pourcent_bioch4 }{ part de la consommation de gaz couverte par la production renouvelable numeric }
#'   \item{ cat_prct_bioch4 }{ classe de l'indicateur part de la consommation de gaz couverte par la production renouvelable, factor }
#' }
#' @source DREAL PdL - TEO
"carto_epci"


#' carto_dep
#'
#' Un dataset comprenant la geographie des departements de la region.
#'
#' @format A data frame with 5 rows and 3 variables:
#' \describe{
#'   \item{ DEP }{  factor }
#'   \item{ NOM_DEP }{  factor }
#'   \item{ geometry }{  sfc_GEOMETRY,sfc }
#' }
#' @source DREAL PdL - TEO
"carto_dep"


#' carto_reg
#'
#' Un dataset comprenant la geographie de la region.
#'
#' @format A data frame with 1 rows and 3 variables:
#' \describe{
#'   \item{ REG }{  factor }
#'   \item{ NOM_REG }{  factor }
#'   \item{ geometry }{  sfc_MULTIPOLYGON,sfc }
#' }
#' @source DREAL PdL - TEO
"carto_reg"
