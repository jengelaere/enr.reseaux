#' about UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_about_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$h5("A propos", align="center"),
    tags$hr(),
    tags$style(HTML("hr {border-top: 3px solid #f4b943;}")),
    
    fluidRow(tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "style.css")),
             column(width=12, includeMarkdown(app_sys("app/www/a_propos.md")))
    ),
    
    HTML('<div data-iframe-height></div>')
 
  )
}
    
#' about Server Functions
#'
#' @noRd 
mod_about_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_about_ui("about_ui_1")
    
## To be copied in the server
# mod_about_server("about_ui_1")
