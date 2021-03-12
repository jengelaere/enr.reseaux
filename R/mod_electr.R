#' electr UI Function
#'
#' @description Onglet toute filiere electrique.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_electr_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    mod_entete_ui(ns("entete_ui_1")), # en tete
    
    mod_l1_gaz_elec_ui(ns("l1_gaz_elec_ui_1")), #1ere ligne
    
    mod_l2_elec_ui(ns("l2_elec_ui_1")), # 2e ligne
    
    fluidRow(
      mod_carto_mapview_ui(ns("carto_mapview_ui_1")),
      mod_carto_part_enr_ui(ns("carto_part_enr_ui_1"))
      ),
    mod_tab_inst_ui(ns("tab_inst_ui_1")),

    HTML('<div data-iframe-height></div>')
    
    
  )
  

}
    
#' electr Server Functions -----------------------------------------------------
#'
#' @noRd 
mod_electr_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    # liste d'objets non reactifs propres a la page, a propager dans les sous modules
    obj_page <- list(
      titre = "Toutes fili\u00e8res \u00e9lectriques renouvelables et de r\u00e9cup\u00e9ration",
      fil = "elect",
      icone = "bolt",
      domaine = "*",
      millesime = enr.reseaux::mil,
      df_nb_inst_MWh = enr.reseaux::Enedis_com_a_reg,
      var_pct_enrr = c("pourcent_enrr", "cat_prct_enrr"),
      caption_pct_enrr = "Source : Donn\u00e9es Enedis et SDES retravaill\u00e9es par la DREAL",
      df_repart_MW = enr.reseaux::indic_registre,
      leg_box_enr = paste0("consommation \u00e9lectrique couverte par la production EnR&R en ", enr.reseaux::mil),
      leg_box_prod = paste0("GWh produits en ", enr.reseaux::mil),
      fct_GWh = 1000000,
      carto_inst_titre = "Installations de production \u00e9lectrique EnR&R",
      carto_inst_caption = paste0("Source : registre au 31/12/", enr.reseaux::mil),
      carto_couches = c("carte_PV", "carte_bois", "carte_dechet", "carte_hydro", "carte_metha", "carte_eol"),
      fct_inst = "tab_inst_elec"
      )
    
    mod_entete_server("entete_ui_1", r, obj_page)
    mod_l1_gaz_elec_server("l1_gaz_elec_ui_1", r, obj_page)       # 1ere ligne
    mod_l2_elec_server("l2_elec_ui_1", r, obj_page)               # 2e ligne
    mod_carto_mapview_server("carto_mapview_ui_1", r, obj_page)   # 3e ligne, 1e objet
    mod_carto_part_enr_server("carto_part_enr_ui_1", r, obj_page) # 3e ligne, 2e objet
    mod_tab_inst_server("tab_inst_ui_1", r, obj_page)             # 4e ligne
    

  })
}
    
## To be copied in the UI
# mod_electr_ui("electr_ui_1")
    
## To be copied in the server
# mod_electr_server("electr_ui_1")
