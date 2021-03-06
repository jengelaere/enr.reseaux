% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fct_girafeTEO_pie.R
\name{girafeTEO_pie}
\alias{girafeTEO_pie}
\title{girafeTEO_pie finalise la mise en forme des graphiques de repartition d'un indicateur selon la maille observee.}
\usage{
girafeTEO_pie(p = p, maille)
}
\arguments{
\item{p}{un diagramme barres ggplot rprésentation une répartition}

\item{maille}{la maille du territoire a visualiser}
}
\value{
un objet ggiraph
}
\description{
girafeTEO_pie finalise la mise en forme des graphiques de repartition d'un indicateur selon la maille observee.
}
\examples{
library(ggplot2)
p <- ggplot(mpg, aes(fl, fill=drv)) + geom_bar(position = "fill")
girafeTEO_pie(p, "Epci")

}
