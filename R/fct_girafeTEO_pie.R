#' girafeTEO_pie finalise la mise en forme des graphiques de repartition d'un indicateur selon la maille observee.
#'
#' @param p un diagramme barres ggplot rprésentation une répartition
#' @param maille la maille du territoire a visualiser
#'
#' @return un objet ggiraph
#' @importFrom ggplot2 scale_y_continuous coord_polar
#' @export
#'
#' @examples
#' library(ggplot2)
#' p <- ggplot(mpg, aes(fl, fill=drv)) + geom_bar(position = "fill")
#' girafeTEO_pie(p, "Epci")
#' 
girafeTEO_pie <- function(p = p, maille) {
  if (maille != "R\u00e9gions") {
    enr.reseaux::girafeTEO( p +  enr.reseaux::theme_TEO + ggplot2::scale_y_continuous(labels = c("0 %", "25 %", "50 %", "75 %", "100 %")))
  }
  else {
    enr.reseaux::girafeTEO( p + enr.reseaux::theme_TEO_carto + ggplot2::coord_polar(theta = "y") )
  }
}
