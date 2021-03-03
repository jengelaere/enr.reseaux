#' bio UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_bio_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' bio Server Functions
#'
#' @noRd 
mod_bio_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_bio_ui("bio_ui_1")
    
## To be copied in the server
# mod_bio_server("bio_ui_1")
