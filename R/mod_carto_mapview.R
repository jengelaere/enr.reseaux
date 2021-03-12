#' carto_mapview UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_carto_mapview_ui <- function(id){
  ns <- NS(id)
  tagList(
    box(status="primary", solidHeader = TRUE, width=6,
        title = span(textOutput(ns("titre")), style="color:white"),
        leaflet::leafletOutput(ns("carto_inst"), width = "95%", height = 370),
        downloadButton(ns("bouton_carto_inst"), "carte en png", icon = icon("download")),
        style="color:black",
        span(textOutput(ns("caption")), style="font-size: 12px")
    )
  )
}
    
#' carto_mapview Server Functions
#'
#' @noRd 
mod_carto_mapview_server <- function(id, r, obj_page){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
    
    css_titre <- tags$style(HTML("
    .leaflet-control.map-title {
      transform: translate(-50%,20%);
      position: fixed !important;
      left: 0%;
      text-align: left;
      padding-left: 10px;
      padding-right: 10px;
      background: rgba(255,255,255,0.75);
      font-weight: bold;
      font-size: 18px;
      font-family: 'Open Sans', Arial, sans-serif;
      color: #005ea7;
      }"))
    
    
    css_caption <- tags$style(HTML("
    .leaflet-control.map-legend {
      left: 0%;
      text-align: left;
      padding-left: 10px;
      padding-right: 10px;
      background: rgba(255,255,255,0.75);
      font-size: 10px;
      font-family: 'Open Sans', Arial, sans-serif;
      }"))
    
    titre_png <- tags$div(
      css_titre, HTML(obj_page$carto_inst_titre)
    )
    
    caption_png <- tags$div(
      css_caption, HTML(paste0(obj_page$carto_inst_caption), " - DREAL Pays de la Loire, TEO")
    )
    
    locale <- reactiveValues()
    
    observeEvent(
      r$mon_ter,{
        locale$m <- compose_carto(list = r, couches = obj_page$carto_couches)@map 
        locale$carto_inst <- locale$m %>%
          leaflet.extras::addFullscreenControl()
        locale$carto_inst_png <- locale$m %>%
          leaflet::addControl(titre_png, position = "topleft", className="map-title") %>% 
          leaflet::addControl(caption_png, position = "bottomleft", className="map-legend")
      })
    
      output$carto_inst <- leaflet::renderLeaflet({
        locale$carto_inst
      })
      
      output$bouton_carto_inst <- downloadHandler(
          filename = paste0(Sys.Date(), "_map_inst_", obj_page$fil, ".png"),
          content = function(file) {
            mapview::mapshot(locale$carto_inst_png,
                    file = file, cliprect = "viewport", selfcontained = FALSE)
          }) 
      
      output$caption <- renderText(obj_page$carto_inst_caption)
      output$titre <- renderText(obj_page$carto_inst_titre)
        

   
  })
}
    
## To be copied in the UI
# mod_carto_mapview_ui("carto_mapview_ui_1")
    
## To be copied in the server
# mod_carto_mapview_server("carto_mapview_ui_1", r, obj_page)
