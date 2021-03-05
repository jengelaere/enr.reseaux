#' l2_gaz UI Function
#'
#' @description 2e ligne de la page biogaz, comprenant 2 graph de repartition
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom shinycssloaders withSpinner
#' @importFrom ggiraph girafeOutput
mod_l2_gaz_ui <- function(id){
  ns <- NS(id)
  tagList(
 
    fluidRow(   #2e ligne
      
      box(status="primary", solidHeader = TRUE, width=6,
          title = span("Capacit\u00e9s install\u00e9es selon le type", style="color:white"),
          ggiraph::girafeOutput(ns("pie_MW"),  width="100%", height = 370) %>% 
            shinycssloaders::withSpinner(type=4),
          style="color:black",
          span(paste0("au ", enr.reseaux::date_registre_biogaz, " - Source : registre biom\u00e9thane ODRE"), style="font-size: 12px")
      ),
      
      box(status="primary", solidHeader = TRUE, width=6,
          title = span("Injections de biom\u00e9thane par type d\'installations", style="color:white"),
          ggiraph::girafeOutput(ns("pie_MWh"),  width="100%", height = 370),
          style="color:black",
          span(paste0("GWh inject\u00e9s en ", enr.reseaux::mil_gaz, " - Source : GRDF et estimations DREAL"), style="font-size: 12px")
      )
    ),
    
    
  )
}
    
#' l2_gaz Server Functions
#'
#' @noRd 
#' @importFrom dplyr inner_join filter mutate
#' @importFrom rlang .data
#' @importFrom ggiraph geom_bar_interactive renderGirafe
#' @importFrom ggplot2 ggplot scale_fill_manual aes labs element_blank

mod_l2_gaz_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    locale <- reactiveValues()
    
    observeEvent(
      r$mon_ter,{
        locale$pie_MW <- pie_gaz(r = r , indic = "capaci", unite = " GWh/an", fct_unite = 1)
        locale$pie_MWh <- pie_gaz(r = r , indic = "_inject", unite = " GWh", fct_unite = 1000)
      })
    
    output$pie_MW <- ggiraph::renderGirafe ({
      locale$pie_MW
    })
    
    output$pie_MWh <- ggiraph::renderGirafe ({ 
      locale$pie_MWh
    })
 
  })
}
    
## To be copied in the UI
# mod_l2_gaz_ui("l2_gaz_ui_1")
    
## To be copied in the server
# mod_l2_gaz_server("l2_gaz_ui_1", r)
