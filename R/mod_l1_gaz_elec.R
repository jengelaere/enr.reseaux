#' l1_gaz_elec UI Function
#'
#' @description 1ere ligne des pages toutes filieres elect et biomgaz, comprenant 3 boites de valeurs
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_l1_gaz_elec_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    fluidRow(   #1e ligne
      valueBoxOutput(ns("box_inst")),
      valueBoxOutput(ns("box_enr")),
      valueBoxOutput(ns("box_prod"))
    )
 
  )
}
    
#' l1_gaz_elec Server Functions
#'
#' @noRd 
#' @importFrom dplyr filter summarise
#' @importFrom rlang .data
mod_l1_gaz_elec_server <- function(id, r, obj_page){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    locale <- reactiveValues()
    
    observeEvent(
      r$mon_ter,{
        
        locale$box_inst <- dplyr::filter(obj_page$df_nb_inst_MWh, .data$CodeZone==r$mon_ter, .data$annee==obj_page$millesime, 
                                  grepl("Nombre|nb_instal", .data$indicateur)) %>%
          dplyr::summarise(valeur=sum(.data$valeur)) %>%
          prettyNum(big.mark=" ", decimal.mark=",")
        
        locale$box_enr <- dplyr::filter(enr.reseaux::indic_epci_a_reg, .data$CodeZone==r$mon_ter) %>%
          dplyr::summarise(valeur=round(.data[[obj_page$var_pct_enrr[1]]], 1)) %>%
          prettyNum(big.mark=" ", decimal.mark=",") %>%
          paste0(" %")
        
        locale$box_prod <- dplyr::filter(obj_page$df_nb_inst_MWh, .data$CodeZone==r$mon_ter, .data$annee==obj_page$millesime, 
                                         grepl("Energie|_inject", .data$indicateur)) %>%
          dplyr::summarise(valeur=sum(.data$valeur)/obj_page$fct_GWh) %>% round(digits=1) %>% 
          prettyNum(big.mark=" ", decimal.mark=",") %>%
          paste0(" GWh")
        
      })
    
    output$box_inst <- renderValueBox({
      valueBox(
        value=locale$box_inst,
        subtitle=paste0("installations en fonctionnement en ", obj_page$millesime), 
        color="blue", icon = icon(obj_page$icone)
      )
    })
    
    output$box_enr <- renderValueBox({
      valueBox(
        value=locale$box_enr,
        subtitle=obj_page$leg_box_enr, 
        color="blue", icon = icon(obj_page$icone)
      )
    })
    
    output$box_prod <- renderValueBox({
      valueBox(
        value=locale$box_prod,
        subtitle=obj_page$leg_box_prod,  width=100,
        color="blue", icon = icon(obj_page$icone)
      )
    })
    
 
  })
}
    
## To be copied in the UI
# mod_l1_gaz_elec_ui("l1_gaz_elec_ui_1")
    
## To be copied in the server
# mod_l1_gaz_elec_server("l1_gaz_elec_ui_1", r, obj_page)
