#' bio UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_bio_ui <- function(id){
  ns <- NS(id)
  tagList(
 
    mod_entete_ui(ns("entete_ui_1")), # en tete
    
    fluidRow(
      mod_carto_mapview_ui(ns("carto_mapview_ui_1"))
    ),
    
    HTML('<div data-iframe-height></div>')
  )
}
    
#' bio Server Functions
#'
#' @noRd 
mod_bio_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    obj_page <- list(
      titre = "Production d\'\u00e9lectricit\u00e9 \u00e0 partir de bio\u00e9nergie",
      fil = "bio",
      icone = "leaf",
      domaine = "--",
      millesime = enr.reseaux::mil,
      df_nb_inst_MWh = enr.reseaux::Enedis_com_a_reg,
      df_repart_MW = enr.reseaux::indic_registre,
      leg_box_prod = paste0("GWh produits en ", enr.reseaux::mil),
      fct_GWh = 1000000,
      carto_inst_titre = "Installations de cogen\u00e9ration bio\u00e9nergie raccord\u00e9es",
      carto_inst_caption = paste0("Source : registre au 31/12/", enr.reseaux::mil),
      carto_couches = c("carte_bois", "carte_dechet", "carte_metha")
    )
    
    mod_entete_server("entete_ui_1", r, obj_page)
    
    mod_carto_mapview_server("carto_mapview_ui_1", r, obj_page) 
    
    
    
    
  })
}
    
## To be copied in the UI
# mod_bio_ui("bio_ui_1")
    
## To be copied in the server
# mod_bio_server("bio_ui_1")
