#' Amorce des graphiques ggplot
#'
#' @description Amorce des graphiques ggplot.
#' @param data le dataframe a visualiser
#' @importFrom ggplot2 ggplot labs element_blank
#'
#' @return un objet ggplot
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggteo(mpg) + geom_bar(aes(hwy))
ggteo <- function(data) {
  ggplot2::ggplot(data) + enr.reseaux::theme_TEO + 
    ggplot2::labs(title=ggplot2::element_blank(), x=ggplot2::element_blank(), y=ggplot2::element_blank(), colour = NULL, fill=NULL)
}