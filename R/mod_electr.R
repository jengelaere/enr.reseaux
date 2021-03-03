#' electr UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_electr_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' electr Server Functions
#'
#' @noRd 
mod_electr_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_electr_ui("electr_ui_1")
    
## To be copied in the server
# mod_electr_server("electr_ui_1")
