# Building a Prod-Ready, Robust Shiny Application.
# 
# README: each step of the dev files is optional, and you don't have to 
# fill every dev scripts before getting started. 
# 01_start.R should be filled at start. 
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
# 
# 
########################################
#### CURRENT FILE: ON START SCRIPT #####
########################################

## Fill the DESCRIPTION ----
## Add meta data about your application
## 
## /!\ Note: if you want to change the name of your app during development, 
## either re-run this function, call golem::set_golem_name(), or don't forget
## to change the name in the app_sys() function in app_config.R /!\
## 
golem::fill_desc(
  pkg_name = "enr.reseaux", # The Name of the package containing the App 
  pkg_title = "EnR de reseaux en Pays de la Loire - TEO", # The Title of the package containing the App 
  pkg_description = "Visualisation territoriale d'indicateurs sur l'electricite renouvelable et le biomethane produits en Pays de la Loire.", # The Description of the package containing the App 
  author_first_name = "Juliette", # Your First Name
  author_last_name = "ENGELAERE-LEFEBVRE", # Your Last Name
  author_email = "juliette.engelaere@developpement-durable.gouv.fr", # Your Email
  repo_url = "https://gitlab.com/dreal-datalab/enr_reseaux_teo" # The URL of the GitHub Repo (optional) 
)       

## Set {golem} options ----
golem::set_golem_options()

## Create Common Files ----
## See ?usethis for more information
utilitaires.ju::use_lo.ol_license()  # You can set another license here
usethis::use_readme_rmd( open = FALSE )
usethis::use_code_of_conduct()
usethis::use_lifecycle_badge( "Experimental" )
usethis::use_news_md( open = FALSE )

## Use git ----
usethis::use_git()

## Init Testing Infrastructure ----
## Create a template for tests
golem::use_recommended_tests()

## Use Recommended Packages ----
golem::use_recommended_deps()

## Favicon ----
# If you want to change the favicon (default is golem's one)
golem::use_favicon("inst/app/www/favicon.png") # path = "path/to/ico". Can be an online file. 
golem::remove_favicon()

## Add helper functions ----
golem::use_utils_ui()
golem::use_utils_server()

# You're now set! ----

# go to dev/02_dev.R
rstudioapi::navigateToFile( "dev/02_dev.R" )

