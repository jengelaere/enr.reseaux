#' entete UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_entete_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$h1(textOutput(ns("nom_terr"))),
    tags$h5(textOutput(ns("titre")), align="center"),
    tags$hr(),
    tags$style(HTML("hr {border-top: 3px solid #f4b943;margin:0 0 12px 0;}"))
  )
}
    
#' entete Server Functions
#'
#' @noRd 
mod_entete_server <- function(id, r, obj_page){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    output$nom_terr <- renderText({
      r$lib_terr
    })   
    
    output$titre <- renderText({
      obj_page$titre
    })  
 
  })
}
    
## To be copied in the UI
# mod_entete_ui("entete_ui_1")
    
## To be copied in the server
# mod_entete_server("entete_ui_1", r, obj_page)
