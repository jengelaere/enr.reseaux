#' eol UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_eol_ui <- function(id){
  ns <- NS(id)
  tagList(
 
    mod_entete_ui(ns("entete_ui_1")), # en tete
    mod_l1_fil_elec_ui(ns("l1_fil_elec_ui_1")), # lignes 1, values box
    
    fluidRow(
      mod_carto_mapview_ui(ns("carto_mapview_ui_1"))
    ),
    
    span(tags$a(href="https://carto.sigloire.fr/1/n_sre_eolien_r52.map", 
                "Acc\u00e9der \u00e0 la carte d\u00e9taill\u00e9e du suivi du d\u00e9veloppement \u00e9olien de la DREAL sur SIGLoire", 
                target="_blank"), style="font-size: 18px"),
    
    
    HTML('<div data-iframe-height></div>')
    
  )
}
    
#' eol Server Functions
#'
#' @noRd 
mod_eol_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    obj_page <- list(
      titre = "Eolien",
      fil = "eol",
      fil_enedis = "Eolien",
      icone = "area-chart",
      domaine = "--",
      millesime = enr.reseaux::mil,
      df_nb_inst_MWh = enr.reseaux::Enedis_com_a_reg,
      # df_repart_MW = enr.reseaux::indic_registre,
      leg_box_prod = paste0("GWh produits en ", enr.reseaux::mil),
      fct_GWh = 1000000,
      carto_inst_titre = "Parcs \u00e9oliens raccord\u00e9s",
      carto_inst_caption = paste0("Source : registre au 31/12/", enr.reseaux::mil),
      carto_couches = c("carte_eol")
    )
    
    mod_entete_server("entete_ui_1", r, obj_page)
    
    mod_l1_fil_elec_server("l1_fil_elec_ui_1", r, obj_page)
   
    mod_carto_mapview_server("carto_mapview_ui_1", r, obj_page) 
    
 
  })
}
    
## To be copied in the UI
# mod_eol_ui("eol_ui_1")
    
## To be copied in the server
# mod_eol_server("eol_ui_1")
