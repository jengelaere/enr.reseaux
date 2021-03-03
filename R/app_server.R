#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  
  r <- reactiveValues()
  
  # List the first level callModules here
  callModule(mod_selection_server, "selection_ui_1", r = r)
  callModule(mod_electr_server, "electr_ui_1", r = r)
  callModule(mod_eol_server, "eol_ui_1", r = r)
  callModule(mod_pv_server, "pv_ui_1", r = r)
  callModule(mod_hydro_server, "hydro_ui_1", r = r)
  callModule(mod_bio_server, "bio_ui_1", r = r)
  callModule(mod_biogaz_server, "biogaz_ui_1", r = r)
  callModule(mod_tel_server, "tel_ui_1", r = r)
  callModule(mod_about_server, "about_ui_1")
  
  }
