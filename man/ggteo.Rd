% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fct_ggteo.R
\name{ggteo}
\alias{ggteo}
\title{Amorce des graphiques ggplot}
\usage{
ggteo(data)
}
\arguments{
\item{data}{le dataframe a visualiser}
}
\value{
un objet ggplot
}
\description{
Amorce des graphiques ggplot.
}
\examples{
library(ggplot2)
ggteo(mpg) + geom_bar(aes(hwy))
}
