#' Passage d'un graphique ggplot a un graphique ggirafe interactif avec options 
#'
#' @description Passage d'un graphique ggplot a un graphique ggiraph interactif avec options de mise en page
#' @param plot l'objet graphique ggplot
#' @param fill_tooltip boleen qui indique si on souhaite reprendre la couleur fill du graphique dans le tooltip
#' @importFrom ggiraph girafe girafe_options opts_tooltip opts_toolbar opts_sizing
#' @importFrom htmlwidgets sizingPolicy
#'  
#' @return un htmlwidget ggiraph
#' @export
#'
#' @examples
#' library(ggplot2)
#' girafeTEO(ggplot(mpg, aes(hwy)) + geom_bar(), FALSE)


girafeTEO <- function(plot, fill_tooltip = TRUE) {
  ggiraph::girafe(print(plot), width_svg = 9, height_svg = 6, pointsize=14)  %>% 
    ggiraph::girafe_options(ggiraph::opts_tooltip(use_fill = fill_tooltip, opacity = .8),
                            ggiraph::opts_toolbar(position = "bottomright", saveaspng = TRUE),
                            htmlwidgets::sizingPolicy(browser.defaultWidth = "100%", viewer.defaultWidth = "100%",
                                         browser.defaultHeight = 400, viewer.defaultHeight = 400, 
                                         browser.padding = 1, viewer.padding = 0,
                                         browser.fill = TRUE, viewer.fill = TRUE),
                            ggiraph::opts_sizing(rescale = T))
}
