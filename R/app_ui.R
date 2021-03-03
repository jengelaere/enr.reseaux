#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
    
    
    dashboardPage(title = "Enr de r\u00e9seaux en Pays de Loire", # personnalisation du thème
                  
                  dashboardHeader(title = tags$img(src='forme_TEO_blanc.svg', height="100px")),
                  
                  dashboardSidebar(
                    sidebarMenu(
                      id="selection",
                      mod_selection_ui("selection_ui_1")
                    )
                  ),
                  
                  dashboardBody(
                    tags$head(tags$script(src="https://cdnjs.cloudflare.com/ajax/libs/iframe-resizer/4.1.1/iframeResizer.contentWindow.min.js",
                                          type="text/javascript"),
                              tags$link(rel="stylesheet", type="text/css", href="www/style.css")
                    ),
                    # Contenu de chacun des onglets
                    tabItems(
                      tabItem("electr",
                              mod_electr_ui("electr_ui_1")
                              ),
                      tabItem("eol",
                              mod_eol_ui("eol_ui_1")
                      ),
                      tabItem("pv",
                              mod_pv_ui("pv_ui_1")
                      ),
                      tabItem("hydro",
                              mod_hydro_ui("hydro_ui_1")
                      ),
                      tabItem("bio",
                              mod_electr_ui("bio_ui_1")
                      ),
                      tabItem("biogaz",
                              mod_biogaz_ui("biogaz_ui_1")
                      ),
                      tabItem("tel",
                              mod_tel_ui("tel_ui_1")
                      ),
                      tabItem("about",
                              mod_about_ui("about_ui_1")
                      )
                    )
                  )
                  
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(ext = 'png'),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'enr.reseaux'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

