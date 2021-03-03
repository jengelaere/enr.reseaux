#' liste_zones
#'
#' Une liste nommee des 78 territoires visualisables dans l'application. 
#' Chaque element est nomme par un libelle de territoire et contient le code geographique du territoire.
#'
#' @format Une liste nommee de 78 elements
#' @source DREAL PdL - TEO
"liste_zones"


#' liste_zones_dep
#'
#' Un dataframe rassemblant cinq listes nommees departementales. 
#' Chaque element d'une liste departementale est nomme par un libelle de territoire et contient le code geographique du territoire.
#' 
#' @format A data frame with 5 rows and 2 variables:
#' \describe{
#'   \item{ dep }{  code departement, character }
#'   \item{ data }{  listes nommees des codes territoires relevant du departement, character }
#' }
#' @source DREAL PdL - TEO
"liste_zones_dep"

#' liste_zone_complete
#'
#' Un dataframe des territoires visualisables dans l'application : les 71 EPCI de la region + l'Ile d'Yeu, les 5 departements et la region.
#'
#' @format A data frame with 78 rows and 3 variables:
#' \describe{
#'   \item{ TypeZone }{  Epci, Départements ou Régions, factor }
#'   \item{ Zone }{  le libelle du territoire, factor }
#'   \item{ CodeZone }{  le code du territoire, factor }
#' }
#' @source DREAL PdL - TEO
"liste_zone_complete"


#' lib_filiere
#'
#' Nomenclature des filieres electriques et leur correspondance, source par source.
#'
#' @format A data frame with 12 rows and 7 variables:
#' \describe{
#'   \item{ Filiere_de_production }{ libelles sans accent des filieres visualisees, character }
#'   \item{ filiere }{  codes des filiere visualisee, character }
#'   \item{ fil_enedis_2017 }{ libelles des filieres Enedis, character }
#'   \item{ fil_registre }{ codes de filiere registre electricite, character }
#'   \item{ typo }{ libelles des filieres fines du registre electricite, factor }
#'   \item{ code_typo }{ codes des filieres fines du registre electricite, factor }
#'   \item{ filiere_registre }{ libelles des filiere du registre electricite, character }
#' }
#' @source DREAL PdL - TEO
"lib_filiere"

#' typo_registre
#'
#' Description.
#'
#' @format A data frame with 6 rows and 2 variables:
#' \describe{
#'   \item{ code_typo }{ codes des filieres fines du registre electricite, character }
#'   \item{ typo }{  libelles des filieres fines du registre electricite, factor }
#' }
#' @source DREAL PdL - TEO
"typo_registre"

#' obj_reg
#'
#' Un dataset qui rassemble les objectifs regionaux de developpement des filieres par epoque.
#'
#' @format A data frame with 9 rows and 8 variables:
#' \describe{
#'   \item{ TypeZone }{  Type de Zone, factor }
#'   \item{ CodeZone }{  Code de la Zone, factor }
#'   \item{ Filiere.de.production }{Filiere de production, factor }
#'   \item{ annee }{ les annees : 2014, annee d'adaption du SRCAE, 2020, 2050, character }
#'   \item{ indicateur }{ l'indicateur concerne : la puissance raccordee en kW, factor }
#'   \item{ valeur }{ valeur de l'indicateir, numeric }
#'   \item{ estimation }{ la valeur a t elle ete recalculee pour l'application, logical }
#'   \item{ type_estimation }{ origine de la valeur, character }
#' }
#' @source DREAL PdL - TEO
"obj_reg"

#' metadatas
#'
#' Metadonnees des datasets opendata collectes
#'
#' @format A data frame with 11 rows and 4 variables:
#' \describe{
#'   \item{ dataset }{  libelle du dataset, character }
#'   \item{ millesime }{ millesimes utilises, character }
#'   \item{ producteur }{ Organisme producteur du jeu de donnees, character }
#'   \item{ date_publication }{ Date de publication du datset, Date }
#' }
#' @source DREAL PdL - TEO
"metadatas"

#' carto_dep
#'
#' Description.
#'
#' @format A data frame with 5 rows and 3 variables:
#' \describe{
#'   \item{ DEP }{  factor }
#'   \item{ NOM_DEP }{  factor }
#'   \item{ geometry }{  sfc_GEOMETRY,sfc }
#' }
#' @source DREAL PdL - TEO
"carto_dep"