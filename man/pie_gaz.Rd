% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fct_pie_gaz.R
\name{pie_gaz}
\alias{pie_gaz}
\title{Production des graphiques de repartition biogaz}
\usage{
pie_gaz(r = r, indic = "capaci", unite = " GWh/an", fct_unite = 1)
}
\arguments{
\item{r}{la liste des objets reactifs de l'application}

\item{indic}{un motif de texte designant l'indicateur concerne}

\item{unite}{l'unite de la legende}

\item{fct_unite}{facteur de conversion d'unite, 1000 pour les injections annuelles, 1 pour les capacites}
}
\value{
un graph ggiraph de repartition des installations biomethane par type
}
\description{
Production des graphiques de repartition biogaz
}
\examples{

r <- list(liste_ter = dplyr::filter(liste_zone_complete, CodeZone \%in\% c("200060010", "49", "52")),
          maille_terr = "Epci")
pie_gaz(r = r , indic = "capaci", unite = " GWh/an", fct_unite = 1)
}
