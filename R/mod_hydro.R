#' hydro UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_hydro_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' hydro Server Functions
#'
#' @noRd 
mod_hydro_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_hydro_ui("hydro_ui_1")
    
## To be copied in the server
# mod_hydro_server("hydro_ui_1")
