% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fct_graph_evol.R
\name{graph_evol}
\alias{graph_evol}
\title{graph_evol une fonction pour les graphiques d'evolution des puissances installees et de nombre d'installations des filieres electriques}
\usage{
graph_evol(fil, indic, territoires)
}
\arguments{
\item{fil}{un motif de caractere contenu dans le libelle de la filiere Enedis (Filiere.de.production)}

\item{indic}{un motif de caractere pour indentifier l'indicateur Enedis}

\item{territoires}{une liste de territoires, structuree comme liste_zone_complete}
}
\value{
un graphique interactif ggiraph
}
\description{
graph_evol une fonction pour les graphiques d'evolution des puissances installees et de nombre d'installations des filieres electriques
}
\examples{
liste_ter <- dplyr::filter(liste_zone_complete, CodeZone \%in\% c("200060010", "49", "52"))
graph_evol(fil = "Eol", indic = "Puissance", liste_ter)

}
