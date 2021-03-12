#' get_carto recupérer une couche pa
#'
#' @param list la liste d'objets reactifs comprenant les différentes couches mapview des filieres
#' @param txt le nom d'une couche carto, au format texte
#'
#' @return l'objet mapview correspondant
#'
#' @examples 
#' \dontrun{
#' get_carto(list = r, "carte_PV")
#' }
#' @importFrom purrr pluck
get_carto <- function(list, txt = "carte_PV") {
         purrr::pluck(list, txt)
}

#' Title
#'
#' @param list la liste d'objets reactifs
#' @param couches vecteurs de nom(s) d'une couche carto, au format texte
#'
#' @return l'objet mapview multi-couches correspondant
#' @export
#'
#' @examples
#' \dontrun{
#' compose_carto(list = r, couches = c("carte_PV", "carte_hydro", "carte_eol"))
#' }
#' @importFrom purrr map reduce
compose_carto <- function(list, couches = c("carte_PV", "carte_hydro", "carte_eol")){
  
  a <- purrr::map(.x = c(couches, "contours"), .f = ~ get_carto(list = list, txt = .x)) %>% 
    purrr::discard(is.null)
  
  purrr::reduce(.x = a, .f = ~ .x + .y)
}

