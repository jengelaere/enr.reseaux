#' carto_part_enr UI Function
#'
#' @description  2e box de la 4e ligne de la page biogaz et de la 3e ligne de la page tout elec, comprenant la carto de l'indicateur part conso couverte par la prod ENR
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom ggiraph girafeOutput
mod_carto_part_enr_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    box(status="primary", solidHeader = TRUE, width=6,
        title = span(paste0("Part de la consommation couverte par les EnR&R en ", enr.reseaux::mil), style="color:white"),
        ggiraph::girafeOutput(ns("carto_part_enr"), width = "100%", height = 380),
        style="color:black",
        span(textOutput(ns("caption")), style="font-size: 12px")
    )
 
  )
}
    
#' carto_part_enr Server Functions
#'
#' @noRd 
#' @importFrom dplyr filter
#' @importFrom rlang .data
#' @importFrom ggiraph renderGirafe geom_sf_interactive
#' @importFrom ggplot2 coord_sf ggplot aes scale_fill_brewer labs element_blank
#' @importFrom sf st_bbox
mod_carto_part_enr_server <- function(id, r, obj_page){
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
      
      output$caption <- renderText(obj_page$caption_pct_enrr)
      
    
  })
}
    
## To be copied in the UI
# mod_carto_part_enr_ui("carto_part_enr_ui_1")
    
## To be copied in the server
# mod_carto_part_enr_server("carto_part_enr_ui_1", r, obj_page)
