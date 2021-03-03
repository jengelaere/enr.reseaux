#' com_iris_csv_biogaz
#'
#' Un dataset au format long contenant tous les indicateurs lies au biogaz, pour toutes les echelles.
#'
#' @format A data frame with 415926 rows and 10 variables:
#' \describe{
  #'   \item{ CodeZone }{  factor }
  #'   \item{ type }{  character }
  #'   \item{ annee }{  character }
  #'   \item{ source }{  list }
  #'   \item{ indicateur }{  character }
  #'   \item{ valeur }{  numeric }
  #'   \item{ Zone }{  factor }
  #'   \item{ EPCI }{  factor }
  #'   \item{ DEP }{  factor }
  #'   \item{ TypeZone }{  character }
  #' }
  #' @source DREAL PdL - TEO
  "com_iris_csv_biogaz"
  
  
  #' com_iris_csv_elec
  #'
  #' Un dataset au format long contenant tous les indicateurs lies a l'electricite, pour toutes les echelles.
  #'
  #' @format A data frame with 182148 rows and 11 variables:
  #' \describe{
  #'   \item{ CodeZone }{  factor }
  #'   \item{ Zone }{  factor }
  #'   \item{ EPCI }{  factor }
  #'   \item{ Filiere.de.production }{  factor }
  #'   \item{ estimation }{  logical }
  #'   \item{ type_estimation }{  factor }
  #'   \item{ annee }{  factor }
  #'   \item{ indicateur }{  factor }
  #'   \item{ valeur }{  numeric }
  #'   \item{ DEP }{  factor }
  #'   \item{ TypeZone }{  character }
  #' }
  #' @source DREAL PdL - TEO
  "com_iris_csv_elec"