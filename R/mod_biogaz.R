#' biogaz UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_biogaz_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' biogaz Server Functions
#'
#' @noRd 
mod_biogaz_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_biogaz_ui("biogaz_ui_1")
    
## To be copied in the server
# mod_biogaz_server("biogaz_ui_1")
