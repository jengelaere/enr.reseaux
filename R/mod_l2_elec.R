#' l2_elec UI Function
#'
#' @description 2e ligne de la page toutes filieres elec, comprenant 2 graph de repartition
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom shinycssloaders withSpinner
#' @importFrom ggiraph girafeOutput
mod_l2_elec_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    fluidRow(   
      
      box(status="primary", solidHeader = TRUE, width=6,
          title = span("R\u00e9partition des puissances install\u00e9es", style="color:white"),
          ggiraph::girafeOutput(ns("pie_MW"),  width="100%", height = 370) %>% 
            shinycssloaders::withSpinner(type=4),
          style="color:black",
          span(paste0("au 31/12/", enr.reseaux::mil, " - Source : Registre"), style="font-size: 12px")
      ),
      
      box(status="primary", solidHeader = TRUE, width=6,
          title = span("R\u00e9partition de la production EnR&R", style="color:white"),
          ggiraph::girafeOutput(ns("pie_MWh"),  width="100%", height = 370),
          style="color:black",
          span(paste0("GWh produits en ", enr.reseaux::mil, " - Source : ENEDIS"), style="font-size: 12px")
      )
    ),
    
    
    
  )
}
    
#' l2_elec Server Functions
#'
#' @noRd 
#' @importFrom dplyr inner_join filter mutate
#' @importFrom rlang .data
#' @importFrom ggiraph geom_bar_interactive renderGirafe
#' @importFrom ggplot2 ggplot scale_fill_manual aes labs element_blank
mod_l2_elec_server <- function(id, r, obj_page){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    locale <- reactiveValues()
    
    observeEvent(
      r$mon_ter,{
        
        locale$pie_MW <- dplyr::inner_join(enr.reseaux::indic_registre, r$liste_ter) %>%
          dplyr::filter(grepl("puiss_MW", .data$variable)) %>%
          dplyr::mutate(code_typo=gsub("puiss_MW__", "", .data$variable)) %>%
          dplyr::inner_join(enr.reseaux::typo_registre) %>%
          ggplot2::ggplot() + ggplot2::scale_fill_manual(values = enr.reseaux::col_registre) +
          ggiraph::geom_bar_interactive(ggplot2::aes(x=.data$Zone, y=.data$valeur, fill=.data$typo,
                                   tooltip = paste0(.data$typo, " : ", prettyNum(round(.data$valeur, 1), decimal.mark = ","), " MW")),
                               stat="identity", position="fill") +
          ggplot2::labs(title=ggplot2::element_blank(), x=ggplot2::element_blank(), y=ggplot2::element_blank(), colour = NULL, fill=NULL)
        
        locale$pie_MWh <- dplyr::inner_join(enr.reseaux::Enedis_com_a_reg, r$liste_ter) %>%
          dplyr::filter(grepl("Energie", .data$indicateur), .data$annee==enr.reseaux::mil) %>%
          ggplot2::ggplot() + ggplot2::scale_fill_manual(values=enr.reseaux::col_enedis) +
          ggiraph::geom_bar_interactive(ggplot2::aes(.data$Zone, .data$valeur, fill=.data$Filiere.de.production,
                                   tooltip = paste0(.data$Filiere.de.production, " :\n", round(.data$valeur/1000000,1), " GWh")),
                               stat="identity", position="fill" ) +
          ggplot2::labs(title=ggplot2::element_blank(), x=ggplot2::element_blank(), y=ggplot2::element_blank(), colour = NULL, fill=NULL)
        
        
      })
    
    output$pie_MW <- ggiraph::renderGirafe ({
      girafeTEO_pie(locale$pie_MW, r$maille_terr)
      
    })
    
    output$pie_MWh <- ggiraph::renderGirafe ({ 
      girafeTEO_pie(locale$pie_MWh, r$maille_terr)
    })
 
  })
}
    
## To be copied in the UI
# mod_l2_elec_ui("l2_elec_ui_1")
    
## To be copied in the server
# mod_l2_elec_server("l2_elec_ui_1", r, obj_page)
