#' l3_obj2_elec_gaz UI Function
#'
#' @description  2e box de la 3e ligne de la page biogaz et tout elec, comprenant la carto de l'indicateur part conso couverte par la prod ENR
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom ggiraph girafeOutput
mod_l3_obj2_elec_gaz_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    box(status="primary", solidHeader = TRUE, width=6,
        title = span(paste0("Part de la consommation couverte par les EnR&R en ", enr.reseaux::mil), style="color:white"),
        ggiraph::girafeOutput(ns("carto_part_enr"), width = "100%", height = 380),
        style="color:black",
        span("Source : Donn\u00e9es Enedis et SDES retravaill\u00e9es par la DREAL", style="font-size: 12px")
    )
 
  )
}
    
#' l3_obj2_elec_gaz Server Functions
#'
#' @noRd 
#' @importFrom dplyr filter
#' @importFrom rlang .data
#' @importFrom ggiraph renderGirafe geom_sf_interactive
#' @importFrom ggplot2 coord_sf ggplot aes scale_fill_brewer labs element_blank
#' @importFrom sf st_bbox
mod_l3_obj2_elec_gaz_server <- function(id, r, obj_page){
  moduleServer( id, function(input, output, session){
    
    ns <- session$ns
    
    locale <- reactiveValues(
      carto_maille = enr.reseaux::carto_epci,
      coord = ggplot2::coord_sf(crs = 2154, datum = NA)
    )
    
    observeEvent(
      r$mon_ter,{
        
        if (r$maille_terr == "Epci") {
         locale$carto_maille <- enr.reseaux::carto_epci
         locale$lim <- dplyr::filter(enr.reseaux::carto_epci, .data$EPCI == r$mon_ter) %>% 
           sf::st_bbox()
         locale$coord <- ggplot2::coord_sf(crs = 2154, datum = NA, expand = FALSE,
                                  xlim = c(locale$lim[[1]]-25000, locale$lim[[3]]+25000),
                                  ylim = c(locale$lim[[2]]-20000, locale$lim[[4]]+20000))
        }
        
        if (r$maille_terr == "R\u00e9gions") {
          locale$carto_maille <- enr.reseaux::carto_epci
          locale$coord <- ggplot2::coord_sf(crs = 2154, datum = NA)
          }
        
        if (r$maille_terr == "D\u00e9partements") {
          locale$carto_maille <- dplyr::filter(enr.reseaux::carto_epci, .data$EPCI %in% r$epci_dep)
          locale$coord <- ggplot2::coord_sf(crs = 2154, datum = NA)
        }
          
        locale$c <- ggplot2::ggplot(locale$carto_maille, ggplot2::aes(fill = .data[[obj_page$var_pct_enrr[2]]], 
                                                               tooltip = paste0(htmlEscape(.data$Zone, TRUE), " : ", 
                                                                                round(.data[[obj_page$var_pct_enrr[1]]], 1), " %"))) +
          ggiraph::geom_sf_interactive() + enr.reseaux::theme_TEO_carto +
          ggplot2::scale_fill_brewer(palette = "PuBuGn") +
          ggplot2::labs(title=ggplot2::element_blank(), x=ggplot2::element_blank(), y=ggplot2::element_blank(), fill=ggplot2::element_blank()) + 
          locale$coord
      })
    
      output$carto_part_enr <- ggiraph::renderGirafe({
        enr.reseaux::girafeTEO(locale$c, fill_tooltip = FALSE)
      })
    
  })
}
    
## To be copied in the UI
# mod_l3_obj2_elec_gaz_ui("l3_obj2_elec_gaz_ui_1")
    
## To be copied in the server
# mod_l3_obj2_elec_gaz_server("l3_obj2_elec_gaz_ui_1", r, obj_page)
