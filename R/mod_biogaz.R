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
    mod_l2_gaz_ui(ns("l2_gaz_ui_1")),
    
    fluidRow(
      mod_carto_mapview_ui(ns("carto_mapview_ui_2")),
      mod_carto_part_enr_ui(ns("carto_part_enr_ui_1"))),
    mod_tab_inst_ui(ns("tab_inst_ui_1")),
    
    HTML('<div data-iframe-height></div>')

  )
}
    
#' biogaz Server Functions
#'
#' @noRd 
mod_biogaz_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    # liste d'objets non reactifs propres a la page a propager dans les sous modules
    obj_page <- list(
      titre = "Injections de biom\u00e9thane sur les r\u00e9seaux de gaz naturel",
      fil = "biogaz",
      icone = "burn",
      millesime = enr.reseaux::mil_gaz,
      df_nb_inst_MWh = enr.reseaux::indic_biogaz_epci_a_reg_reg,
      var_pct_enrr = c("pourcent_bioch4", "cat_prct_bioch4"),
      caption_pct_enrr = "Source : Donn\u00e9es GRDF, SDES et estimations DREAL", 
      df_repart_MW = enr.reseaux::indic_biogaz_epci_a_reg_reg,
      leg_box_enr = paste0("consommation gaz couverte par les injections de biom\u00e9thane en ", enr.reseaux::mil_gaz),
      leg_box_prod = paste0("GWh inject\u00e9s sur le r\u00e9seau en ", enr.reseaux::mil_gaz),
      fct_GWh = 1000,
      carto_inst_titre = "Points d\'injection de biom\u00e9thane",
      carto_inst_caption = paste0("Source : registre biom\u00e9thane ODRE au ", enr.reseaux::date_registre_biogaz),
      carto_couches = c("contours", "carte_agri", "carte_dechet", "carte_indust", "carte_isdnd", "carte_step", "carte_terri"),
      fct_inst = "tab_inst_biogaz"
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
    mod_carto_mapview_server("carto_mapview_ui_2", r, obj_page) 
    mod_carto_part_enr_server("carto_part_enr_ui_1", r, obj_page)
    mod_tab_inst_server("tab_inst_ui_1", r, obj_page)                # 5e ligne

 
  })
}
    
## To be copied in the UI
# mod_biogaz_ui("biogaz_ui_1")
    
## To be copied in the server
# mod_biogaz_server("biogaz_ui_1")
