% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fct_couche_typ_gaz.R
\name{couche_typ_gaz}
\alias{couche_typ_gaz}
\title{Carte mapview d'un type d'installations biomethane du territoire selectionne}
\usage{
couche_typ_gaz(typ, code_ter, col = 1, leg = FALSE)
}
\arguments{
\item{typ}{un motif de texte a retrouver dans le type des installations biomethane qui permet d'identifier un unique type}

\item{code_ter}{le code geo du territoire a visualiser, au format texte}

\item{col}{un entier entre 1 et 6 qui designe le type d'installation dans la palette col_biogaz}

\item{leg}{un boleen pour afficher ou non la legende de la carte, FALSE par defaut}
}
\value{
une carte mapview
}
\description{
Carte mapview d'un type d'installations biomethane du territoire selectionne
}
\examples{
couche_typ_gaz(typ = "Agricole", code_ter = "52", col = 4)
}
