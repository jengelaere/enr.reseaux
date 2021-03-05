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
                  
                  header = dashboardHeader(title = tags$img(src='www/forme_TEO_blanc.svg', height="100px")),
                  
                  sidebar = dashboardSidebar(
                    mod_selection_ui("selection_ui_1"),
                    
                    tags$h3(HTML(paste("Fili\u00e8re")), style="color:white", align="center"),	
                    
                    sidebarMenu(
                      menuItem("R\u00e9seaux \u00e9lectriques", tabName = "electr", icon = icon("bolt"),
                               menuItem("Toutes fili\u00e8res \u00e9lectriques", tabName = "onglet1", icon = icon("bolt")),
                               menuItem(HTML(paste(tags$img(src='www/si-glyph-wind-turbines.svg', width = "18px", height = "18px"),"   Eolien terrestre")), tabName = "eol"),
                               menuItem("Photovolta\u00efque", tabName = "pv", icon = icon("solar-panel")),
                               menuItem(HTML(paste(tags$img(src='www/iconfinder_sea1_216717.svg', width = "16px", height = "16px"),"Hydro\u00e9lectricit\u00e9")), tabName = "hydro"),
                               menuItem("Bio\u00e9nergie", tabName = "bio", icon = icon("leaf", lib = "font-awesome"))
                      ),
                      menuItem("R\u00e9seaux gaz", tabName = "biogaz", icon = icon("burn")),
                      menuItem("T\u00e9l\u00e9chargement", tabName = "tel", icon = icon("table")),
                      menuItem("A propos", tabName = "about", icon = icon("question-circle")),
                      
                      tags$br(),
                      tags$br(),
                      tags$a(href="http://teo-paysdelaloire.fr", target="_blank", tags$img(src="www/logo_teo.jpg",width="120px",style="display: block; margin-left: auto; margin-right: auto;")),
                      tags$br(),
                      tags$a(href="http://www.pays-de-la-loire.developpement-durable.gouv.fr/dreal-centre-de-service-de-la-donnee-r1957.html", target="_blank", tags$img(src="www/Logo_datalab_blanc.svg",width="150px",style="display: block; margin-left: auto; margin-right: auto;")),
                      tags$br(),
                      tags$a(href="http://www.pays-de-la-loire.developpement-durable.gouv.fr/air-climat-et-energie-r189.html", target="_blank", tags$img(src="www/logo_PrefDREAL2.png", width="150px",style="display: block; margin-left: auto; margin-right: auto;"))
                      
                      
                    )),
                  
                  body = dashboardBody(
                    tags$head(tags$script(src="https://cdnjs.cloudflare.com/ajax/libs/iframe-resizer/4.1.1/iframeResizer.contentWindow.min.js",
                                          type="text/javascript"),
                              tags$link(rel="stylesheet", type="text/css", href="www/style.css")
                              ),
                    # Contenu de chacun des onglets
                    tabItems(
                      tabItem("onglet1",
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

