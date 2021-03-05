#' biogaz UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_biogaz_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    mod_entete_ui(ns("entete_ui_1")), # en tete
    mod_l1_gaz_elec_ui(ns("l1_gaz_elec_ui_1")), #1ere ligne
    mod_l2_gaz_ui(ns("l2_gaz_ui_1"))

 
  )
}
    
#' biogaz Server Functions
#'
#' @noRd 
mod_biogaz_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    obj_page <- list(
      titre = "Injections de biom\u00e9thane sur les r\u00e9seaux de gaz naturel",
      icone = "burn",
      domaine = "*",
      millesime = enr.reseaux::mil_gaz,
      df_nb_inst_MWh = enr.reseaux::indic_biogaz_epci_a_reg_reg,
      var_pct_enrr = c("pourcent_bioch4", "cat_prct_bioch4"),
      df_repart_MW = enr.reseaux::indic_biogaz_epci_a_reg_reg,
      couche = enr.reseaux::couche_typ_gaz,
      leg_box_enr = paste0("consommation gaz couverte par les injections de biom\u00e9thane en ", enr.reseaux::mil_gaz),
      leg_box_prod = paste0("GWh inject\u00e9s sur le r\u00e9seau en ", enr.reseaux::mil_gaz),
      fct_GWh = 1000
    )
    
    locale <- reactiveValues(
      
    )
    
    observeEvent(
      r$go,{
        locale
        
      }) 
    
    mod_entete_server("entete_ui_1", r, obj_page)
    mod_l1_gaz_elec_server("l1_gaz_elec_ui_1", r, obj_page)
    mod_l2_gaz_server("l2_gaz_ui_1", r)
 
  })
}
    
## To be copied in the UI
# mod_biogaz_ui("biogaz_ui_1")
    
## To be copied in the server
# mod_biogaz_server("biogaz_ui_1")
