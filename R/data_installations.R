#' inst_reg
#'
#' Un dataset rassemblant toutes les installations de production d'electricite renouvelable.
#'
#' @format A data frame with 2912 rows and 23 variables:
#' \describe{
  #'   \item{ nominstallation }{  character }
  #'   \item{ DEPCOM }{  character }
  #'   \item{ IRIS }{  character }
  #'   \item{ date_inst }{  Date }
  #'   \item{ puiss_MW }{  numeric }
  #'   \item{ code_typo }{  character }
  #'   \item{ typo }{  factor }
  #'   \item{ combustible }{  character }
  #'   \item{ combustiblessecondaires }{  character }
  #'   \item{ technologie }{  character }
  #'   \item{ nbgroupes }{  numeric }
  #'   \item{ prod_MWh_an }{  numeric }
  #'   \item{ part_EnR }{  numeric }
  #'   \item{ NOM_DEPCOM }{  character }
  #'   \item{ EPCI }{  character }
  #'   \item{ NOM_EPCI }{  character }
  #'   \item{ DEP }{  character }
  #'   \item{ NOM_DEP }{  character }
  #'   \item{ REG }{  character }
  #'   \item{ NOM_REG }{  character }
  #'   \item{ DEPARTEMENTS_DE_L_EPCI }{  list }
  #'   \item{ precision_geo }{  character }
  #'   \item{ geometry }{  sfc_POINT,sfc }
  #' }
  #' @source DREAL PdL - TEO
  "inst_reg"

  
  #' inst_biogaz_reg
  #'
  #' Un dataset rassemblant toutes les installations d'injection de biomethane.
  #'
  #' @format A data frame with 14 rows and 28 variables:
  #' \describe{
  #'   \item{ DEPCOM }{  character }
  #'   \item{ nom_du_projet }{  character }
  #'   \item{ site }{  character }
  #'   \item{ grx_demandeur }{  character }
  #'   \item{ date_de_mes }{  Date }
  #'   \item{ annee_mes }{  character }
  #'   \item{ capacite_de_production_gwh_an }{  numeric }
  #'   \item{ type_de_reseau }{  character }
  #'   \item{ NOM_DEPCOM }{  factor }
  #'   \item{ EPCI }{  factor }
  #'   \item{ NOM_EPCI }{  factor }
  #'   \item{ DEP }{  factor }
  #'   \item{ NOM_DEP }{  factor }
  #'   \item{ REG }{  factor }
  #'   \item{ NOM_REG }{  factor }
  #'   \item{ DEPARTEMENTS_DE_L_EPCI }{  list }
  #'   \item{ REGIONS_DE_L_EPCI }{  list }
  #'   \item{ lib_installation }{  character }
  #'   \item{ typologie }{  character }
  #'   \item{ date_de_premiere_injection }{  Date }
  #'   \item{ code_iris }{  character }
  #'   \item{ NOM_IRIS }{  character }
  #'   \item{ TYP_IRIS }{  factor }
  #'   \item{ capacite_d_injection_au_31_12_2019_en_nm3_h }{  integer }
  #'   \item{ data_annuelles }{  list }
  #'   \item{ type }{  character }
  #'   \item{ source }{  character }
  #'   \item{ geometry }{  sfc_POINT,sfc }
  #' }
  #' @source DREAL PdL - TEO
  "inst_biogaz_reg"