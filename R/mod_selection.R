#' selection UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom rlang .data
#' @importFrom tidyr unnest
#' @importFrom dplyr filter pull
#' @importFrom stats setNames

mod_selection_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    sidebarMenu(
      id="selection",
      
      selectInput(inputId = ns("mon_dept"), 
                  label = "S\u00e9lectionner un d\u00e9partement",
                  choices = dplyr::filter(enr.reseaux::liste_zone_complete, .data$TypeZone!="Epci") %>% dplyr::pull(.data$CodeZone) %>% as.character() %>%
                    stats::setNames(dplyr::filter(enr.reseaux::liste_zone_complete, .data$TypeZone!="Epci") %>% dplyr::pull(.data$Zone) %>% as.character()),
                  selected = enr.reseaux::reg),  
      
      selectInput(inputId = ns("mon_ter"), label="s\u00e9lectionner un territoire",
                  choices = stats::setNames(enr.reseaux::reg, dplyr::filter(enr.reseaux::liste_zone_complete, .data$TypeZone=="R\u00e9gions") %>% dplyr::pull(.data$Zone) %>% as.character()),
                  selected = enr.reseaux::reg),
      
      div(actionButton(ns("go"), "Valider le territoire"), align="center"),
      
      tags$br()
    )
    
  )
}
    
#' selection Server Functions
#'
#' @noRd 
#' @importFrom dplyr filter pull mutate across everything arrange desc row_number bind_rows
#' @importFrom mapview mapview
#' @importFrom sf st_geometry st_set_crs
#' @importFrom stats setNames
#' @importFrom tidyr unnest

mod_selection_server <- function(id, r){
  
  moduleServer(id, function(input, output, session){
    ns <- session$ns
    
    ## intéractivité via requête URL
    observe({
      query <- parseQueryString(session$clientData$url_search)
      # if(!is.null(query$fil)) {
      #   updateTabItems(session, inputId = "selection", selected = as.character(query$fil)) 
      # }
      if(!is.null(query$dpt)) {
        updateSelectInput(session, inputId = "mon_dept", selected = query$dpt) 
      }
    })

    locale <- reactiveValues()
    
    # liste des territoires du menu deroulant
    observeEvent(
      c(input$mon_dept), {  
        if(input$mon_dept != enr.reseaux::reg) {
          r$epci_dep <- dplyr::filter(enr.reseaux::liste_zones_dep, .data$dep == input$mon_dept) %>% 
            tidyr::unnest(.data$data) %>% 
            dplyr::pull(.data$CodeZone) %>%
            stats::setNames(dplyr::filter(enr.reseaux::liste_zones_dep, .data$dep==input$mon_dept) %>% 
                       tidyr::unnest(cols = c(.data$data)) %>% dplyr::pull(.data$Zone))
        } else {
          r$epci_dep <- enr.reseaux::liste_zones
        }
        
        updateSelectInput(
          session = session,
          inputId = "mon_ter",
          choices = r$epci_dep,
          selected = input$mon_dept
        )
        
      })
    
    legende_enedis <- "Source : ENEDIS jusque 2017 puis registre"

    observeEvent(
      c(input$go), {
        r$mon_ter <- input$mon_ter
        r$mon_dept <- input$mon_dept
        r$go <- input$go

        locale$zone <- dplyr::filter(enr.reseaux::liste_zone_complete, .data$CodeZone == r$mon_ter) %>%
          dplyr::mutate(dplyr::across(dplyr::everything(), as.character))

        r$maille_terr <- locale$zone$TypeZone
        r$lib_terr <- locale$zone$Zone
        r$liste_ter <- dplyr::filter(enr.reseaux::liste_zone_complete, .data$CodeZone %in% c(enr.reseaux::reg, r$mon_dept, r$mon_ter)) %>%
          dplyr::arrange(dplyr::desc(dplyr::row_number()))
        
        if(r$maille_terr == "R\u00e9gions") {
          r$ter_evol <-r$liste_ter
          r$leg_evol <- legende_enedis
          r$leg_evol_MW <- paste0("MW - ", legende_enedis)
          r$cont <- sf::st_geometry(enr.reseaux::carto_reg) %>% sf::st_set_crs(2154)
        }
        
        if(r$maille_terr == "D\u00e9partements") {

          r$ter_evol <-filter(enr.reseaux::liste_zone_complete, .data$CodeZone %in% c(setdiff(enr.reseaux::liste_dep, r$mon_ter))) %>%
            dplyr::bind_rows(filter(enr.reseaux::liste_zone_complete, .data$CodeZone == r$mon_ter))

          r$leg_evol <- legende_enedis
          r$leg_evol_MW <- paste0("MW - ", legende_enedis)

          r$cont <- dplyr::filter(enr.reseaux::carto_dep, .data$DEP==r$mon_ter) %>% sf::st_geometry() %>% sf::st_set_crs(2154)
          }

        if(r$maille_terr == "Epci") {
          r$ter_evol <- r$liste_ter
          r$leg_evol <- paste0("indice 100 - ", legende_enedis)
          r$leg_evol_MW <- r$leg_evol
          r$cont <- dplyr::filter(enr.reseaux::carto_epci, .data$EPCI==r$mon_ter) %>% sf::st_geometry() %>% sf::st_set_crs(2154)
        }

        r$contours <- mapview::mapview(r$cont, legend=FALSE, map.types = c("CartoDB.Positron"), col="gray", alpha = 1,
                             col.regions="papayawhip", alpha.regions=0.15, homebutton=TRUE, label=NULL, layer.name="Contours")
      })

    

  }) #mod server
} # mod

    
## To be copied in the UI
# mod_selection_ui("selection_ui_1")
    
## To be copied in the server
# mod_selection_server("selection_ui_1")
