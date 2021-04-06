#' pv UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_pv_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    mod_entete_ui(ns("entete_ui_1")), # en tete
    mod_l1_fil_elec_ui(ns("l1_fil_elec_ui_1")), # lignes 1, values box
    fluidRow(   #2e ligne
      column(width=8,
             mod_l2a_fil_elec_ui(ns("l2a_fil_elec_ui_1")),
             fluidRow(
               # #box(status="primary",
               #     solidHeader = TRUE, width=12,
               #     plotOutput("legende_evol_PV", inline = F, height="23px", width="100%")
             )
      ),
      column(width=4, fluidRow(
        box(status="primary",
            solidHeader = TRUE, width=12,
            title = span("Productions annuelles", style="color:white"),
            # girafeOutput("bar_prod_pv", width="100%", height=320),
            style="color:black",
            span("GWh - Source : ENEDIS", style="font-size: 12px")
        )
      )
      )
    ),
    fluidRow(
      mod_carto_mapview_ui(ns("carto_mapview_ui_1"))
    ),
    
    HTML('<div data-iframe-height></div>')
 
  )
}
    
#' pv Server Functions
#'
#' @noRd 
mod_pv_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
    obj_page <- list(
      titre = "Photovolta\u00efque",
      fil = "pv",
      fil_enedis = "Photovolta\u00efque",
      icone = "solar-panel",
      domaine = "--",
      millesime = enr.reseaux::mil,
      df_nb_inst_MWh = enr.reseaux::Enedis_com_a_reg,
      df_repart_MW = enr.reseaux::indic_registre,
      leg_box_prod = paste0("GWh produits en ", enr.reseaux::mil),
      fct_GWh = 1000000,
      carto_inst_titre = "Installations solaires photovolta\u00efques raccord\u00e9es",
      carto_inst_caption = paste0("Source : registre au 31/12/", enr.reseaux::mil),
      carto_couches = c("carte_PV")
    )
    
    mod_entete_server("entete_ui_1", r, obj_page)
    
    mod_l1_fil_elec_server("l1_fil_elec_ui_1", r, obj_page)
    
    mod_l2a_fil_elec_server("l2a_fil_elec_ui_1", r, obj_page)
    
    
    mod_carto_mapview_server("carto_mapview_ui_1", r, obj_page) 
    
    
  })
}
    
## To be copied in the UI
# mod_pv_ui("pv_ui_1")
    
## To be copied in the server
# mod_pv_server("pv_ui_1")
