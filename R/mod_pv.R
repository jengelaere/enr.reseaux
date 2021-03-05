#' pv UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_pv_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' pv Server Functions
#'
#' @noRd 
mod_pv_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_pv_ui("pv_ui_1")
    
## To be copied in the server
# mod_pv_server("pv_ui_1")
