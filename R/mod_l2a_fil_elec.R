#' l2a_fil_elec UI Function
#'
#' @description debut de la 2 ligne des onglets des filieres electriques, deux graph d'evolution des puissance et du nb d'installation.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_l2a_fil_elec_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      box(status="primary",
          solidHeader = TRUE, width=6,
          title = span("Evolution des puissances install\u00e9es", style="color:white"),
          girafeOutput(ns("evol_MW"),  width="100%", height=275) %>% withSpinner(type=4),
          style="color:black",
          span(textOutput(ns("leg_evol_1")), style="font-size: 12px")
      ),
      box(status="primary",
          solidHeader = TRUE, width=6,
          title = span("Evolution du nombre d\'installations", style="color:white"),
          girafeOutput(ns("evol_nb"),  width="100%", height=275),
          style="color:black",
          span(textOutput(ns("leg_evol_2")), style="font-size: 12px")
      )
    )
    
  )
}
    
#' l2a_fil_elec Server Functions
#'
#' @importFrom ggplot2 guides
#' @noRd 
mod_l2a_fil_elec_server <- function(id, r, obj_page){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    locale <- reactiveValues()
    
    observeEvent(
      r$mon_ter,{
        
        locale$evol_MW <- graph_evol(obj_page$fil_enedis, "Puissance", r$ter_evol) + 
          ggplot2::guides(colour="none")
        
        locale$evol_nb <- graph_evol(obj_page$fil_enedis, "Nombre", r$ter_evol) +
          ggplot2::guides(colour="none")
        
      })
    
    output$evol_MW <- renderGirafe ({
      girafeTEO(locale$evol_MW)
    })
    
    output$evol_nb <- renderGirafe ({
      girafeTEO(locale$evol_nb)
    })
    
    output$leg_evol_1 <- renderText({ r$leg_evol_MW })
    
    output$leg_evol_2 <- renderText({ r$leg_evol })
 
  })
}
    
## To be copied in the UI
# mod_l2a_fil_elec_ui("l2a_fil_elec_ui_1")
    
## To be copied in the server
# mod_l2a_fil_elec_server("l2a_fil_elec_ui_1")
