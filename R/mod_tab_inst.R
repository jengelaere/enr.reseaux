#' tab_inst UI Function
#'
#' @description Tableau listant les installations de la filiere et du territoire concernes.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom DT dataTableOutput
#' @importFrom shinycssloaders withSpinner
mod_tab_inst_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(   #5e ligne
      box(status="primary", solidHeader = TRUE, width=12,
          title = span(textOutput(ns("titre")), style="color:white"),
          DT::dataTableOutput(ns("tab_inst_gaz")) %>% shinycssloaders::withSpinner(type=1),
          style="color:black",
          span(textOutput(ns("caption")), style="font-size: 12px")
          )
      )
    )
}
    
#' tab_inst Server Functions
#'
#' @noRd 
#' @importFrom DT renderDataTable

mod_tab_inst_server <- function(id, r, obj_page){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    fct_inst <- base::get(obj_page$fct_inst)
    
    locale <- reactiveValues(
      tab_inst = fct_inst(ter = enr.reseaux::reg )
    )
    
    observeEvent(
      r$go,{
        locale$tab_inst <- fct_inst(ter = r$mon_ter)
      })
    
    output$tab_inst_gaz <- DT::renderDataTable(
      locale$tab_inst,
      extensions = 'Buttons', rownames = FALSE,
      options = list(dom = 'Bfrtip', pageLength = 10, language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/French.json'),
                     buttons = list(c(list(extend = 'csv', file=paste0(Sys.Date(), '-registre_', obj_page$fil, '.csv')))))
    )
    
    output$caption <- renderText(obj_page$carto_inst_caption)
    output$titre <- renderText(obj_page$carto_inst_titre)
 
  })
}
    
## To be copied in the UI
# mod_tab_inst_ui(ns("tab_inst_ui_1"))
    
## To be copied in the server
# mod_tab_inst_server("tab_inst_ui_1", r, obj_page)
