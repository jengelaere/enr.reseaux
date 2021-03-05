#' eol UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_eol_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' eol Server Functions
#'
#' @noRd 
mod_eol_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_eol_ui("eol_ui_1")
    
## To be copied in the server
# mod_eol_server("eol_ui_1")
