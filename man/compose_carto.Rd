% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fct_compose_carto.R
\name{compose_carto}
\alias{compose_carto}
\title{Title}
\usage{
compose_carto(list, couches = c("carte_PV", "carte_hydro", "carte_eol"))
}
\arguments{
\item{list}{la liste d'objets reactifs}

\item{couches}{vecteurs de nom(s) d'une couche carto, au format texte}
}
\value{
l'objet mapview multi-couches correspondant
}
\description{
Title
}
\examples{
\dontrun{
compose_carto(list = r, couches = c("carte_PV", "carte_hydro", "carte_eol"))
}
}
