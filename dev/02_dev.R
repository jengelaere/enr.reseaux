# Building a Prod-Ready, Robust Shiny Application.
# 
# README: each step of the dev files is optional, and you don't have to 
# fill every dev scripts before getting started. 
# 01_start.R should be filled at start. 
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
# 
# 
###################################
#### CURRENT FILE: DEV SCRIPT #####
###################################

# Engineering

## Dependencies ----
## Add one line by package you want to add as dependency
usethis::use_pipe()
usethis::use_package("rlang")
usethis::use_package("htmlwidgets")
usethis::use_package("ggplot2")
usethis::use_package("ggiraph")
usethis::use_package("dplyr")
usethis::use_package("forcats")
usethis::use_package("lubridate")
usethis::use_package("ggthemes")
usethis::use_package("sf")
usethis::use_package("mapview")
usethis::use_package("leafpop")
usethis::use_package("shinydashboard")
usethis::use_package("tidyr")
usethis::use_package("shinycssloaders")
usethis::use_package("htmltools")
usethis::use_package("purrr")
usethis::use_package("leaflet")
usethis::use_package("leaflet.extras")
usethis::use_package()
usethis::use_package()
usethis::use_package()
usethis::use_package()
usethis::use_package()
usethis::use_package()

## Add modules ----
## Create a module infrastructure in R/
golem::add_module( name = "selection" ) # selection territoriale
golem::add_module( name = "electr" ) # onglet toutes filieres elec
golem::add_module( name = "eol" )  # onglet eolien
golem::add_module( name = "pv" ) # onglet solaire pv
golem::add_module( name = "hydro" ) # onglet hydroelectricite
golem::add_module( name = "bio" ) # onglet cogeneration biomasse
golem::add_module( name = "biogaz" ) # onglet injection biomethane
golem::add_module( name = "tel" ) # onglet telechargement
golem::add_module( name = "about" ) # onglet A propos
## sous-modules
golem::add_module( name = "entete" ) # entete de chaque onglet
golem::add_module( name = "l1_gaz_elec" ) # 1ere ligne des onglets tout electr et biomethane
golem::add_module( name = "l2_elec" ) # 2e ligne de l'onglet tout electr
golem::add_module( name = "l2_gaz" ) # 2e ligne de l'onglet biomethane
golem::add_module( name = "carto_part_enr" ) # 2e box de la 3e ligne des onglets tout electr et biomethane - carto part EnR
golem::add_module( name = "carto_mapview" ) # carte des installations, module commun à toutes les pages
golem::add_module( name = "tab_inst" ) # tableau des installations, commun onglets tout electr et biomethane
golem::add_module( name = "l1_fil_elec") # 1ere ligne des onglets des filieres electriques
golem::add_module( name = "l2a_fil_elec" ) # debut de la 2 ligne des onglets des filieres electriques
golem::add_module( name = "" )
golem::add_module( name = "" )
golem::add_module( name = "" )
golem::add_module( name = "" )
golem::add_module( name = "" )
golem::add_module( name = "" )



## Add helper functions ----
## Creates ftc_* and utils_*
golem::add_fct( "helpers" ) 
golem::add_utils( "helpers" )

## Add metier functions
golem::add_fct( "ggteo" ) 
usethis::use_test( "ggteo" )
golem::add_fct( "girafeTEO" ) 
usethis::use_test( "girafeTEO" )
golem::add_fct( "graph_evol" ) 
usethis::use_test( "graph_evol" )
golem::add_fct( "cartes_inst_elec" ) 
usethis::use_test( "cartes_inst_elec" )
golem::add_fct( "couche_typ_gaz" ) 
usethis::use_test( "couche_typ_gaz" )
golem::add_fct( "girafeTEO_pie" ) 
usethis::use_test( "girafeTEO_pie" )
golem::add_fct( "pie_gaz" ) 
usethis::use_test( "pie_gaz" )
golem::add_fct( "compose_carto" ) 
usethis::use_test( "compose_carto" )
golem::add_fct( "tab_inst_elec" ) 
usethis::use_test( "tab_inst_elec" )
golem::add_fct( "tab_inst_biogaz" ) 
usethis::use_test( "tab_inst_biogaz" )
golem::add_fct( "" ) 
usethis::use_test( "" )
golem::add_fct( "" ) 
usethis::use_test( "" )
golem::add_fct( "" ) 
usethis::use_test( "" )
golem::add_fct( "" ) 
usethis::use_test( "" )

golem::add_fct( "" ) 
usethis::use_test( "" )


## External resources
## Creates .js and .css files at inst/app/www
golem::add_js_file( "script" )
golem::add_js_handler( "handlers" )
golem::add_css_file( "style.css" )

## Add internal datasets ----
## If you have data in your package
usethis::use_data_raw( name = "indicateurs.RData", open = FALSE ) 
usethis::use_data_raw( name = "themes_ggplot", open = TRUE ) 
usethis::use_data_raw( name = "couleurs", open = TRUE ) 


## Tests ----
## Add one line by test you want to create
usethis::use_test( "app" )

# Documentation

## Vignette ----
usethis::use_vignette("enr.reseaux")
devtools::build_vignettes()

## Code Coverage----
## Set the code coverage service ("codecov" or "coveralls")
usethis::use_coverage()

# Create a summary readme for the testthat subdirectory
covrpage::covrpage()

## CI ----
## Use this part of the script if you need to set up a CI
## service for your application
## 
## (You'll need GitHub there)
usethis::use_github()

# GitHub Actions
usethis::use_github_action() 
# Chose one of the three
# See https://usethis.r-lib.org/reference/use_github_action.html
usethis::use_github_action_check_release() 
usethis::use_github_action_check_standard() 
usethis::use_github_action_check_full() 
# Add action for PR
usethis::use_github_action_pr_commands()

# Travis CI
usethis::use_travis() 
usethis::use_travis_badge() 

# AppVeyor 
usethis::use_appveyor() 
usethis::use_appveyor_badge()

# Circle CI
usethis::use_circleci()
usethis::use_circleci_badge()

# Jenkins
usethis::use_jenkins()

# GitLab CI
usethis::use_gitlab_ci()

# You're now set! ----
# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")

