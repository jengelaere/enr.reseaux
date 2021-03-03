#' selection UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_selection_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' selection Server Functions
#'
#' @noRd 
mod_selection_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_selection_ui("selection_ui_1")
    
## To be copied in the server
# mod_selection_server("selection_ui_1")
