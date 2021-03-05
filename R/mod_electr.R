#' electr UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_electr_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    mod_entete_ui(ns("entete_ui_1")), # en tete
    
    mod_l1_gaz_elec_ui(ns("l1_gaz_elec_ui_1")), #1ere ligne
    
    mod_l2_elec_ui(ns("l2_elec_ui_1")), # 2e ligne

    # 
    # fluidRow(   #3e ligne
    #   
    #   box(status="primary", solidHeader = TRUE, width=6,
    #       title = span("Installations de production \u00e9lectrique EnR&R", style="color:white"),
    #       leafletOutput(ns("carto_inst"), width = "95%", height = 370),
    #       downloadButton("bouton_carte_inst_elec","carte en png"),
    #       style="color:black",
    #       span(paste0("Source : registre au 31/12/", mil), style="font-size: 12px")
    #   ),
    #   
    #   box(status="primary", solidHeader = TRUE, width=6,
    #       title = span(paste0("Part de la consommation couverte par les EnR&R en ", mil), style="color:white"),
    #       girafeOutput(ns("carto_part_enr"), width = "100%", height = 380),
    #       style="color:black",
    #       span("Source : Donn\u00e9es Enedis et SDES retravaill\u00e9es par la DREAL", style="font-size: 12px")
    #   )
    # ),
    # 
    # fluidRow(   #5e ligne
    #   box(status="primary", solidHeader = TRUE, width=12,
    #       title = span("Installations de production \u00e9lectrique EnR&R", style="color:white"),
    #       dataTableOutput(ns("tab_inst")) %>% withSpinner(type=1),
    #       style="color:black",
    #       span(paste0("Source : registre au 31/12/", mil), style="font-size: 12px")
    #   )
    # ),
    HTML('<div data-iframe-height></div>')
    
    
  )
  

}
    
#' electr Server Functions -----------------------------------------------------
#'
#' @noRd 
mod_electr_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    obj_page <- list(
      titre = "Toutes fili\u00e8res \u00e9lectriques renouvelables et de r\u00e9cup\u00e9ration",
      icone = "bolt",
      domaine = "*",
      millesime = enr.reseaux::mil,
      df_nb_inst_MWh = enr.reseaux::Enedis_com_a_reg,
      var_pct_enrr = c("pourcent_enrr", "cat_prct_enrr"),
      df_repart_MW = enr.reseaux::indic_registre,
      couche = enr.reseaux::couche_fil,
      leg_box_enr = paste0("consommation \u00e9lectrique couverte par la production EnR&R en ", enr.reseaux::mil),
      leg_box_prod = paste0("GWh produits en ", enr.reseaux::mil),
      fct_GWh = 1000000
      
    )
    
    mod_entete_server("entete_ui_1", r, obj_page)
    
    mod_l1_gaz_elec_server("l1_gaz_elec_ui_1", r, obj_page) #1ere ligne
    
    mod_l2_elec_server("l2_elec_ui_1", r, obj_page) #2e ligne
    
    locale <- reactiveValues(
      
    )
    
    observeEvent(
      r$go,{
        locale
        
      }) 
    
    

  #   
  #   output$carto_inst <- renderLeaflet({
  #     req(input$mon_ter)
  #     carte_PV <- couche_fil("pvq", input$mon_ter, 6)
  #     carte_bois <- couche_fil("bois", input$mon_ter, 1)
  #     carte_dechet <- couche_fil("dechet", input$mon_ter, 2)
  #     carte_hydro <- couche_fil("hydro", input$mon_ter, 3)
  #     carte_metha <- couche_fil("metha", input$mon_ter, 4)
  #     carte_eol <- couche_fil("eol", input$mon_ter, 5)
  #     
  #     (contours() + carte_PV + carte_bois + carte_dechet + carte_hydro + carte_metha + carte_eol)@map %>%
  #       addFullscreenControl() # %>%
  #     # leafem::addHomeButton(group = "contours") # ça marche pour la carte, mais ça impacte le bon fonctionnement de l'application, notamment les tableaux
  #   })
  #   
  #   user.created.map <- reactive({
  #     req(input$mon_ter)
  #     carte_PV <- couche_fil("pvq", input$mon_ter, 6, TRUE)
  #     carte_bois <- couche_fil("bois", input$mon_ter, 1, TRUE)
  #     carte_dechet <- couche_fil("dechet", input$mon_ter, 2, TRUE)
  #     carte_hydro <- couche_fil("hydro", input$mon_ter, 3, TRUE)
  #     carte_metha <- couche_fil("metha", input$mon_ter, 4, TRUE)
  #     carte_eol <- couche_fil("eol", input$mon_ter, 5, TRUE)
  #     tag.map.title <- tags$style(HTML("
  # .leaflet-control.map-title {
  #   transform: translate(-50%,20%);
  #   position: fixed !important;
  #   left: 0%;
  #   text-align: left;
  #   padding-left: 10px;
  #   padding-right: 10px;
  #   background: rgba(255,255,255,0.75);
  #   font-weight: bold;
  #   font-size: 18px;
  #   }"))
  #     title <- tags$div(
  #       tag.map.title, HTML("Installations<br>de production \u00e9lectrique<br>EnR&R", paste0("<p>Source : registre au 31/12/", mil))
  #     )
  #     # source<-paste0("Source : registre au 31/12/", mil)
  #     (contours() + carte_PV + carte_bois + carte_dechet + carte_hydro + carte_metha + carte_eol)@map %>%
  #       addControl(title, position = "topleft", className="map-title")
  #   }) # end of creating user.created.map()
  #   
  #   output$bouton_carte_inst_elec <- downloadHandler(
  #     filename = paste0( Sys.Date(),"_map_inst_elec",".png"),
  #     content = function(file) {
  #       map<-mapshot( user.created.map(),
  #                     file = file,
  #                     cliprect = "viewport", # the clipping rectangle matches the height & width from the viewing port
  #                     selfcontained = FALSE # when this was not specified, the function for produced a PDF of two pages: one of the leaflet map, the other a blank page.
  #       )
  #     } # end of content() function
  #   ) # end of downloadHandler() function
  #   
  #   
  #   output$carto_part_enr <- renderGirafe({
  #     req(input$mon_ter)
  #     if (maille_terr()=="Epci") {
  #       carto_maille <- carto_epci
  #       lim <- filter(carto_epci, EPCI==input$mon_ter) %>% st_bbox()
  #     }
  #     else
  #       if (maille_terr()=="R\u00e9gions")
  #       {carto_maille <- carto_epci}
  #     else {
  #       carto_maille <- filter(carto_epci, EPCI %in% epci_dep()$CodeZone)
  #     }
  #     
  #     c <- ggplot(carto_maille, aes(fill=cat_prct_enrr, tooltip=paste0(htmlEscape(Zone, TRUE), " : ", round(pourcent_enrr, 1), " %"))) +
  #       geom_sf_interactive() + theme_TEO_carto +
  #       scale_fill_brewer(palette="PuBuGn") +
  #       labs(title=element_blank(), x=element_blank(), y=element_blank(), fill=element_blank())
  #     
  #     if (maille_terr()=="Epci")
  #     {c <- c + coord_sf(crs = st_crs(carto_maille), datum = NA, expand = FALSE,
  #                        xlim = c(lim[[1]]-25000, lim[[3]]+25000),
  #                        ylim = c(lim[[2]]-20000, lim[[4]]+20000))}
  #     else {c <- c + coord_sf(crs = st_crs(carto_maille), datum = NA)}
  #     
  #     
  #     girafeTEO(c, fill_tooltip=FALSE)
  #   })
  #   
  #   output$tab_inst <- DT::renderDataTable(
  #     if (isTruthy(input$mon_ter)) {
  #       filter(inst_reg, REG==input$mon_ter|DEP==input$mon_ter|EPCI==input$mon_ter) %>% as.data.frame() %>%
  #         mutate(part_EnR=part_EnR*100, date_inst=year(date_inst)) %>%
  #         select(commune= NOM_DEPCOM, Installation=nominstallation, 'puissance (MW)'=puiss_MW, type=typo,
  #                combustible, 'combustible secondaire'=combustiblessecondaires, 'nombre de m\u00e2ts'=nbgroupes,
  #                'production annuelle (MWh)'= prod_MWh_an, 'part renouvelable (%)'=part_EnR,
  #                'mise en service'=date_inst, -geometry) %>%
  #         select_if(is_not_empty) %>% select_if(is_pas_zero)%>%
  #         arrange(desc(`puissance (MW)`), commune, type, Installation)},
  #     # %>% formatPercentage(7, 0)
  #     extensions = 'Buttons', rownames = FALSE,
  #     options = list(dom = 'Bfrtip', pageLength = 10, language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/French.json'),
  #                    buttons = list(c(list(extend = 'csv', file=paste0(Sys.Date(), '-registre_elec_3112', mil, '-', input$mon_ter, '.csv')))))
  #   )
    

  })
}
    
## To be copied in the UI
# mod_electr_ui("electr_ui_1")
    
## To be copied in the server
# mod_electr_server("electr_ui_1")
