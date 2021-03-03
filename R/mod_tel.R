#' tel UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_tel_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' tel Server Functions
#'
#' @noRd 
mod_tel_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_tel_ui("tel_ui_1")
    
## To be copied in the server
# mod_tel_server("tel_ui_1")
