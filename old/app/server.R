
shinyServer(function(session, input, output) {

#### intéractivité via requête URL-------------------
  
  observe({
    query <- parseQueryString(session$clientData$url_search)
    if(!is.null(query$fil)) {
      updateTabItems(session, inputId = "menu", selected = as.character(query$fil)) 
    }
    if(!is.null(query$dpt)) {
      updateSelectInput(session, inputId = "mon_dept", selected = query$dpt) 
    }
  })
  
#### création de la liste de choix EPCI, dépendant du département, pour la 2e boite de sélection terr et objets réactifs ---------------
 
  epci_dep <- reactive({
    req(input$mon_dept)
    epci_dep <- filter(liste_zones_dep, dep==input$mon_dept | dep==input$mon_ter) %>% unnest()
  })
  
  output$terr_selec <-renderUI({
    req(input$mon_dept)
    if (input$mon_dept == reg | input$mon_dept =="" | is.na(input$mon_dept)) ({
      selectInput(inputId ="mon_ter", label="sélectionner un territoire",
                  choices = liste_zones,
                  selected = reg)    
    })  
    else ({  
      list_epci_dep <- filter(liste_zones_dep, dep==input$mon_dept) %>% unnest() %>% pull(CodeZone) %>%
        setNames(filter(liste_zones_dep, dep==input$mon_dept) %>% unnest() %>% pull(Zone))
      
      selectInput(inputId = "mon_ter", label="sélectionner un territoire",
                  choices = list_epci_dep,
                  selected = input$mon_dept)
      
    })  
  })
  
  maille_terr <- reactive({
    req(input$mon_ter)
    filter(liste_zone_complete, CodeZone == input$mon_ter) %>%
      pull(TypeZone) %>% as.character()
  }) 
  
  lib_terr <- reactive({
    req(input$mon_ter)
    filter(liste_zone_complete, CodeZone == input$mon_ter) %>%
        pull(Zone) %>% as.character()
    })

  liste_ter <- reactive ({
       req(input$mon_ter)
       filter(liste_zone_complete, CodeZone %in% c(reg, input$mon_dept, input$mon_ter)) %>%
         arrange(desc(row_number()))
      })
  
  ter_evol <- reactive ({
    req(input$mon_ter)
    if(maille_terr()=="Départements") {
      filter(liste_zone_complete, CodeZone %in% c(setdiff(liste_dep, input$mon_ter))) %>%
        bind_rows(filter(liste_zone_complete, CodeZone == input$mon_ter))
      } else { liste_ter() }
     })
  
  leg_evol <- reactive({
    req(input$mon_ter)
    if(maille_terr()!="Epci") "Source : ENEDIS jusque 2017 puis registre" else "indice 100 - Source : ENEDIS jusque 2017 puis registre"
  })
  
  leg_evol_MW <- reactive({
    req(input$mon_ter)
    if(maille_terr()!="Epci") "MW - Source : ENEDIS jusque 2017 puis registre " else "indice 100 - Source : ENEDIS jusque 2017 puis registre"
  })

  contours <- reactive({
    if (maille_terr()=="Epci") { cont <- filter(carto_epci, EPCI==input$mon_ter) %>% st_geometry %>% st_set_crs(2154) }
  else
    if (maille_terr()=="Régions") { cont <- st_geometry(carto_reg) %>% st_set_crs(2154) }
  else {cont <-  filter(carto_dep, DEP==input$mon_ter) %>% st_geometry %>% st_set_crs(2154) }
    mapview(cont, legend=FALSE, map.types = c("CartoDB.Positron"), col="gray", alpha = 1, 
            col.regions="papayawhip", alpha.regions=0.15, homebutton=TRUE, label=NULL, layer.name="Contours")
  })
  

  # affichage du nom du territoire---------------------------
  output$nom_terr <- renderText({
    req(input$mon_dept)
    lib_terr()})
  
  output$nom_terr2 <- renderText({
    req(input$mon_dept)
    lib_terr()})
  
  output$nom_terr3 <- renderText({
    req(input$mon_dept)
    lib_terr()})
  
  output$nom_terr4 <- renderText({
    req(input$mon_dept)
    lib_terr()})
  
  output$nom_terr5 <- renderText({
    req(input$mon_dept)
    lib_terr()})
  
  output$nom_terr6 <- renderText({
    req(input$mon_dept)
    lib_terr()})
  
  output$nom_terr7 <- renderText({
    req(input$mon_dept)
    lib_terr()})

  # outpout$mon_dep <- renderText(input$mon_dept)
  # output$id_terr <- renderText(input$mon_ter)
  # output$list_filtr_ter <- renderTable(liste_ter())  
  
  # output$dep_graph <- renderDataTable(
  #   ter_evol()
  # )
  
  # output$maille_ter <- renderText(maille_terr()) 

  #--------------------------Toutes filières électriques---------------------------------------------------
  output$boxEnR1 <- renderValueBox({
    req(input$mon_ter)
    valueBox(
      value=filter(Enedis_com_a_reg, CodeZone==input$mon_ter, annee==mil, grepl("Nombre", indicateur)) %>%
        summarise(valeur=sum(valeur)) %>%
        prettyNum(big.mark=" ", decimal.mark=","),
      subtitle=paste0("installations en fonctionnement en ", mil), 
      color="blue", icon = icon("bolt")
    )
   })

  output$boxEnR2 <- renderValueBox({
    req(input$mon_ter)
    valueBox(
      value=filter(indic_epci_a_reg, CodeZone==input$mon_ter) %>%
        summarise(valeur=round(pourcent_enrr, 1)) %>%
        prettyNum(big.mark=" ", decimal.mark=",") %>%
        paste0(" %"),
      subtitle=paste0("consommation électrique couverte par la production EnR&R en ", mil), 
      color="blue", icon = icon("bolt")
    )
  })
  
  output$boxEnR3 <- renderValueBox({
    req(input$mon_ter)
    valueBox(
      value=filter(Enedis_com_a_reg, CodeZone==input$mon_ter, annee==mil, grepl("Energie", indicateur)) %>%
        summarise(valeur=sum(valeur)/1000000) %>% round(digits=1) %>% prettyNum(big.mark=" ", decimal.mark=",") %>%
        paste0(" GWh"),
      subtitle=paste0("GWh produit en ", mil),  width=100,
      color="blue", icon = icon("bolt")
    )
  })

  output$pie_MW <- renderGirafe ({
    req(input$mon_ter)
    p <- inner_join(indic_registre, liste_ter()) %>%
        filter(grepl("puiss_MW", variable)) %>%
        mutate(code_typo=gsub("puiss_MW__", "", variable)) %>%
        inner_join(typo_registre) %>%
        ggplot() + scale_fill_manual(values = col_registre) +
        geom_bar_interactive(aes(x=Zone, y=valeur, fill=typo,
                                 tooltip = paste0(typo, " : ", prettyNum(round(valeur, 1), decimal.mark = ","), " MW")),
                             stat="identity", position="fill") +
          labs(title=element_blank(), x=element_blank(), y=element_blank(), colour = NULL, fill=NULL)

      if (maille_terr()!="Régions") {
        girafeTEO( p +  theme_TEO + scale_y_continuous(labels = c("0 %", "25 %", "50 %", "75 %", "100 %")))
      }
      else {
        girafeTEO( p + theme_TEO_carto + coord_polar(theta = "y") )
      }

    })
  
  output$pie_MWh <- renderGirafe ({ req(input$mon_ter)
    p <- inner_join(Enedis_com_a_reg, liste_ter()) %>%
      filter(grepl("Energie", indicateur), annee==mil) %>%
      ggplot() + scale_fill_manual(values=col_enedis) +
      geom_bar_interactive(aes(Zone, valeur, fill=Filiere.de.production,
                               tooltip = paste0(Filiere.de.production, " :\n", round(valeur/1000000,1), " GWh")),
                           stat="identity", position="fill" ) +
      labs(title=element_blank(), x=element_blank(), y=element_blank(), colour = NULL, fill=NULL)

    if (maille_terr()!="Régions") {
      girafeTEO( p +  theme_TEO + scale_y_continuous(labels = c("0%", "25%", "50%", "75%", "100%")))
    }
    else {
      girafeTEO( p + theme_TEO_carto + coord_polar(theta = "y") )
    }
    })
 
  output$carto_inst <- renderLeaflet({
    req(input$mon_ter)
    carte_PV <- couche_fil("pvq", input$mon_ter, 6)
    carte_bois <- couche_fil("bois", input$mon_ter, 1)
    carte_dechet <- couche_fil("dechet", input$mon_ter, 2)
    carte_hydro <- couche_fil("hydro", input$mon_ter, 3)
    carte_metha <- couche_fil("metha", input$mon_ter, 4)
    carte_eol <- couche_fil("eol", input$mon_ter, 5)

    (contours() + carte_PV + carte_bois + carte_dechet + carte_hydro + carte_metha + carte_eol)@map %>%
      addFullscreenControl() # %>%
      # leafem::addHomeButton(group = "contours") # ça marche pour la carte, mais ça impacte le bon fonctionnement de l'application, notamment les tableaux
  })
  
  user.created.map <- reactive({
    req(input$mon_ter)
    carte_PV <- couche_fil("pvq", input$mon_ter, 6, TRUE)
    carte_bois <- couche_fil("bois", input$mon_ter, 1, TRUE)
    carte_dechet <- couche_fil("dechet", input$mon_ter, 2, TRUE)
    carte_hydro <- couche_fil("hydro", input$mon_ter, 3, TRUE)
    carte_metha <- couche_fil("metha", input$mon_ter, 4, TRUE)
    carte_eol <- couche_fil("eol", input$mon_ter, 5, TRUE)
    tag.map.title <- tags$style(HTML("
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
    }"))
    title <- tags$div(
      tag.map.title, HTML("Installations<br>de production électrique<br>EnR&R", paste0("<p>Source : registre au 31/12/", mil))
      )
    # source<-paste0("Source : registre au 31/12/", mil)
    (contours() + carte_PV + carte_bois + carte_dechet + carte_hydro + carte_metha + carte_eol)@map %>%
      addControl(title, position = "topleft", className="map-title")
    }) # end of creating user.created.map()
  
  output$bouton_carte_inst_elec <- downloadHandler(
    filename = paste0( Sys.Date(),"_map_inst_elec",".png"),
    content = function(file) {
      map<-mapshot( user.created.map(),
               file = file,
               cliprect = "viewport", # the clipping rectangle matches the height & width from the viewing port
               selfcontained = FALSE # when this was not specified, the function for produced a PDF of two pages: one of the leaflet map, the other a blank page.
               )
      } # end of content() function
    ) # end of downloadHandler() function

  
  output$carto_part_enr <- renderGirafe({
    req(input$mon_ter)
    if (maille_terr()=="Epci") {
      carto_maille <- carto_epci
      lim <- filter(carto_epci, EPCI==input$mon_ter) %>% st_bbox()
      }
    else
      if (maille_terr()=="Régions")
        {carto_maille <- carto_epci}
    else {
      carto_maille <- filter(carto_epci, EPCI %in% epci_dep()$CodeZone)
    }

    c <- ggplot(carto_maille, aes(fill=cat_prct_enrr, tooltip=paste0(htmlEscape(Zone, TRUE), " : ", round(pourcent_enrr,1), " %"))) +
                geom_sf_interactive() + theme_TEO_carto +
                scale_fill_brewer(palette="PuBuGn") +
                labs(title=element_blank(), x=element_blank(), y=element_blank(), fill=element_blank())

    if (maille_terr()=="Epci")
    {c <- c + coord_sf(crs = st_crs(carto_maille), datum = NA, expand = FALSE,
                       xlim = c(lim[[1]]-25000, lim[[3]]+25000),
                       ylim = c(lim[[2]]-20000, lim[[4]]+20000))}
    else {c <- c + coord_sf(crs = st_crs(carto_maille), datum = NA)}


    girafeTEO(c, fill_tooltip=FALSE)
      })

  output$tab_inst <- DT::renderDataTable(
    if (isTruthy(input$mon_ter)) {
      filter(inst_reg, REG==input$mon_ter|DEP==input$mon_ter|EPCI==input$mon_ter) %>% as.data.frame() %>%
        mutate(part_EnR=part_EnR*100, date_inst=year(date_inst)) %>%
        select(commune= NOM_DEPCOM, Installation=nominstallation, 'puissance (MW)'=puiss_MW, type=typo,
               combustible, 'combustible secondaire'=combustiblessecondaires, 'nombre de mâts'=nbgroupes,
               'production annuelle (MWh)'= prod_MWh_an, 'part renouvelable (%)'=part_EnR,
               'mise en service'=date_inst, -geometry) %>%
        select_if(is_not_empty) %>% select_if(is_pas_zero)%>%
        arrange(desc(`puissance (MW)`), commune, type, Installation)},
      # %>% formatPercentage(7, 0)
    extensions = 'Buttons', rownames = FALSE,
    options = list(dom = 'Bfrtip', pageLength = 10, language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/French.json'),
                   buttons = list(c(list(extend = 'csv', file=paste0(Sys.Date(), '-registre_elec_3112', mil, '-', input$mon_ter, '.csv')))))
    )
  
  #--------------------------EOLIEN---------------------------------------------------
  output$boxEol1 <- renderValueBox({
    req(input$mon_ter)
    valueBox(
      value=filter(indic_registre, CodeZone==input$mon_ter, grepl("puiss_MW__eol", variable)) %>%
        summarise(valeur=sum(valeur)) %>% round(digits=1) %>% prettyNum(big.mark=" ", decimal.mark=",") %>%
        paste0(" MW"),
      subtitle=paste0("raccordés au 31 décembre ", mil),
      color="blue", icon = icon("area-chart")
    )
  })

  output$boxEol2 <- renderValueBox({
    req(input$mon_ter)
    valueBox(value = filter(Enedis_com_a_reg, CodeZone==input$mon_ter, annee==mil, grepl("Nombre", indicateur),
                            Filiere.de.production=="Eolien") %>%
               summarise(valeur=sum(valeur)) %>%
               prettyNum(big.mark=" ", decimal.mark=","),
             subtitle=paste0("parcs ou installations en fonctionnement en ", mil),
             color="blue", icon = icon("area-chart")
    )
  })

  output$boxEol3 <- renderValueBox({
    req(input$mon_ter)
    valueBox(
      value=filter(Enedis_com_a_reg, CodeZone==input$mon_ter, annee==mil, grepl("Energie", indicateur),
                   Filiere.de.production=="Eolien") %>%
        summarise(valeur=sum(valeur)/1000000) %>% round(digits=1) %>% prettyNum(big.mark=" ", decimal.mark=",") %>%
        paste0(" GWh"),
      subtitle=paste0("GWh produit en ", mil),  width=100,
      color="blue", icon = icon("area-chart")
    )
  })

  output$Eol_evol_MW <- renderGirafe ({
    req(input$mon_ter)
    girafeTEO(graph_evol("Eolien", "Puissance", ter_evol()) +
                guides(colour="none"))
  })

  output$evol_nb_eol <- renderGirafe ({
    req(input$mon_ter)
    girafeTEO(graph_evol("Eolien", "Nombre", ter_evol()) +
                guides(colour="none"))
  })

  output$legende_evol_eol <- renderPlot ({
    req(input$mon_ter)
    if(maille_terr()=="Départements") {ter_legende <- tail(ter_evol(),2)}
    else {ter_legende <- ter_evol()}
    graph_evol("Eolien", "Puiss", ter_legende) %>%
      get_legend() %>% ggdraw()
  })

  output$leg_evol_1 <- renderText({ leg_evol_MW() })
  output$leg_evol_2 <- renderText({ leg_evol() })

  output$bar_prod_eol <- renderGirafe ({
    req(input$mon_ter)
    girafeTEO(filter(Enedis_com_a_reg, CodeZone==input$mon_ter,
           grepl("Eol", Filiere.de.production), grepl("Energie", indicateur)) %>%
      mutate(valeur=valeur/1000000) %>%
      ggteo() + expand_limits(y = 1) +
      geom_bar_interactive(aes(x=annee, y=valeur, tooltip=paste0(round(valeur, 1), " GWh")),
                           stat = "identity", fill=col_ter)
      )

  })

  output$tab_MW_eol <- function() ({
    req(input$mon_ter)
    inner_join(Enedis_com_a_reg, liste_ter()) %>%
      filter(grepl("Eol", Filiere.de.production), grepl("Puissance", indicateur)) %>%
      mutate(`Année`=substr(annee, 1,4), valeur=round(valeur/1000,1)) %>%
      select(`Année`, everything(), -Filiere.de.production, -indicateur, -TypeZone, -CodeZone,
             -annee, -ends_with("stimation")) %>%
      spread(key = Zone, value=valeur) %>%
      arrange(desc(as.character(`Année`))) %>%
      kable(align="c", row.names=F) %>%
      kable_styling(bootstrap_options = c("striped", "hover", "condensed","responsive"), full_width = T) %>%
      row_spec(0,  color = "black", bold = "T")  })

  output$carto_eol <- renderLeaflet({
    req(input$mon_ter)
    carte_eol <- couche_fil("eol",input$mon_ter, 5)
    (contours() + carte_eol)@map %>%
      addFullscreenControl()
  })

  user.created.map_eol <- reactive({
    req(input$mon_ter)
    carte_eol <- couche_fil("eol", input$mon_ter, 5, TRUE)
    tag.map.title <- tags$style(HTML("
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
    }"))
    title <- tags$div(
      tag.map.title, HTML("Parcs éoliens raccordés", paste0("<p>Source : registre au 31/12/",mil))
      )
    (contours() + carte_eol)@map %>%
      addControl(title, position = "topleft", className="map-title")
    }) # end of creating user.created.map()

  output$bouton_carte_eol <- downloadHandler(
    filename = paste0( Sys.Date(),"_map_eol",".png"),
    content = function(file) {
      map<-mapshot( user.created.map_eol(),
                    file = file,
                    cliprect = "viewport",
                    selfcontained = FALSE)
    } # end of content() function
  ) # end of downloadHandler() function



  #--------------------------PHOTOVOLTAIQUE---------------------------------------------------

  output$boxPV1 <- renderValueBox({
    req(input$mon_ter)
    valueBox(
      value=filter(indic_registre, CodeZone==input$mon_ter, grepl("puiss_MW__pvq", variable)) %>%
        summarise(valeur=sum(valeur)) %>% round(digits=1) %>% prettyNum(big.mark=" ", decimal.mark=",") %>%
        paste0(" MW"),
      subtitle=paste0("raccordés au 31 décembre ", mil),
      color="blue", icon = icon("solar-panel")
    )
    })

  output$boxPV2 <- renderValueBox({
    req(input$mon_ter)
    valueBox(value = filter(Enedis_com_a_reg, CodeZone==input$mon_ter, annee==mil, grepl("Nombre", indicateur),
                              Filiere.de.production=="Photovoltaïque") %>%
                 summarise(valeur=sum(valeur)) %>%
               prettyNum(big.mark=" ", decimal.mark=","),
        subtitle=paste0("installations en fonctionnement en ", mil),
        color="blue", icon = icon("solar-panel")
      )
    })

  output$boxPV3 <- renderValueBox({
    req(input$mon_ter)
        valueBox(
          value=filter(Enedis_com_a_reg, CodeZone==input$mon_ter, annee==mil, grepl("Energie", indicateur),
                       Filiere.de.production=="Photovoltaïque") %>%
            summarise(valeur=sum(valeur)/1000000) %>% round(digits=1) %>%
            prettyNum(big.mark=" ", decimal.mark=",") %>% paste0(" GWh"),
          subtitle=paste0("GWh produit en ", mil),  width=100,
          color="blue", icon = icon("solar-panel")
        )
      })

  output$leg_evol_3 <- renderText({ leg_evol_MW() })
  output$leg_evol_4 <- renderText({ leg_evol() })

  output$PV_evol_MW <- renderGirafe ({
    req(input$mon_ter)
    girafeTEO(graph_evol("Photo", "Puissance", ter_evol()) +
                guides(colour="none"))
    })

  output$evol_nb_PV <- renderGirafe ({
    req(input$mon_ter)
    girafeTEO(graph_evol("Photo", "Nombre", ter_evol()) +
                guides(colour="none"))

  })

  output$legende_evol_PV <- renderPlot ({
    req(input$mon_ter)
    if(maille_terr()=="Départements") {ter_legende <- tail(ter_evol(),2)}
    else {ter_legende <- ter_evol()}
    graph_evol("Photo", "Puiss", ter_legende) %>%
                get_legend() %>% ggdraw()
  })

  output$bar_prod_pv <- renderGirafe ({
    req(input$mon_ter)
    girafeTEO(filter(Enedis_com_a_reg, CodeZone==input$mon_ter,
                     grepl("Photov", Filiere.de.production), grepl("Energie", indicateur)) %>%
                mutate(valeur=valeur/1000000) %>%
                ggteo() +
                geom_bar_interactive(aes(x=annee, y=valeur, tooltip=paste0(round(valeur, 1), " GWh")),
                                     stat = "identity", fill=col_ter)
    )
  })

  output$tab_MW_PV <- function() ({
    req(input$mon_ter)
    inner_join(Enedis_com_a_reg, liste_ter()) %>%
      filter(grepl("Photov", Filiere.de.production), grepl("Puissance", indicateur)) %>%
      mutate(`Année`=substr(annee, 1,4), valeur=round(valeur/1000,1)) %>%
      select(`Année`, everything(), -Filiere.de.production, -indicateur, -TypeZone, -CodeZone,
             -annee, -ends_with("stimation")) %>%
      spread(key = Zone, value=valeur) %>%
      arrange(desc(as.character(`Année`))) %>%
      kable(align="c", row.names=F) %>%
      kable_styling(bootstrap_options = c("striped", "hover", "condensed","responsive"), full_width = T) %>%
      row_spec(0,  color = "black", bold = "T")  })


  output$carto_PV <- renderLeaflet({
    req(input$mon_ter)
    carte_PV <- couche_fil("pvq",input$mon_ter, 6)
    (contours() + carte_PV)@map %>%
      addFullscreenControl()
  })

  user.created.map_pvq <- reactive({
    req(input$mon_ter)
    carte_pvq <- couche_fil("pvq", input$mon_ter, 6, TRUE)
    tag.map.title <- tags$style(HTML("
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
    }"))
    title <- tags$div(
      tag.map.title, HTML("Installations solaires photovoltaïques raccordées", paste0("<p>Source : registre au 31/12/",mil))
      )
    (contours() + carte_pvq)@map %>%
      addControl(title, position = "topleft", className="map-title")
  }) # end of creating user.created.map()

  output$bouton_carte_pvq <- downloadHandler(
    filename = paste0( Sys.Date(),"_map_pvq",".png"),
    content = function(file) {
      map<-mapshot( user.created.map_pvq(),
                    file = file,
                    cliprect = "viewport",
                    selfcontained = FALSE)
    } # end of content() function
  ) # end of downloadHandler() function

  #--------------------------Hydroélectricité---------------------------------------------------
  output$boxHydro1 <- renderValueBox({
    req(input$mon_ter)
    valueBox(
      value=filter(indic_registre, CodeZone==input$mon_ter, grepl("puiss_MW__hydro", variable)) %>%
        summarise(valeur=sum(valeur)) %>% round(digits=1) %>% prettyNum(big.mark=" ", decimal.mark=",") %>%
        paste0(" MW"),
      subtitle=paste0("raccordés au 31 décembre ", mil),
      color="blue", icon = icon("water")
    )
  })

  output$boxHydro2 <- renderValueBox({
    req(input$mon_ter)
    valueBox(value = filter(Enedis_com_a_reg, CodeZone==input$mon_ter, annee==mil, grepl("Nombre", indicateur),
                            Filiere.de.production=="Hydraulique") %>%
               summarise(valeur=sum(valeur)) %>%
               prettyNum(big.mark=" ", decimal.mark=","),
             subtitle=paste0("installations en fonctionnement en ", mil),
             color="blue", icon = icon("water")
    )
  })

  output$boxHydro3 <- renderValueBox({
    req(input$mon_ter)
    valueBox(
      value=filter(Enedis_com_a_reg, CodeZone==input$mon_ter, annee==mil, grepl("Energie", indicateur),
                   Filiere.de.production=="Hydraulique") %>%
        summarise(valeur=sum(valeur)/1000000) %>% round(digits=1) %>% prettyNum(big.mark=" ", decimal.mark=",") %>%
        paste0(" GWh"),
      subtitle=paste0("GWh produit en ", mil),  width=100,
      color="blue", icon = icon("water")
    )
  })

  output$Hydro_evol_MW <- renderGirafe ({
    req(input$mon_ter)
    girafeTEO(graph_evol("Hydraulique", "Puissance", ter_evol()) +
                guides(colour="none"))
  })

  output$evol_nb_hydro <- renderGirafe ({
    req(input$mon_ter)
    girafeTEO(graph_evol("Hydraulique", "Nombre", ter_evol()) +
                guides(colour="none"))
  })

  output$legende_evol_hydro <- renderPlot ({
    req(input$mon_ter)
    if(maille_terr()=="Départements") {ter_legende <- tail(ter_evol(),2)}
    else {ter_legende <- ter_evol()}
    graph_evol("Hydraulique", "Puiss", ter_legende) %>%
      get_legend() %>% ggdraw()
  })

  output$leg_evol_5 <- renderText({ leg_evol_MW() })
  output$leg_evol_6 <- renderText({ leg_evol() })

  output$bar_prod_hydro <- renderGirafe ({
    req(input$mon_ter)
    girafeTEO(filter(Enedis_com_a_reg, CodeZone==input$mon_ter,
                     grepl("Hydraulique", Filiere.de.production), grepl("Energie", indicateur)) %>%
                mutate(valeur=valeur/1000000) %>%
                ggteo() + expand_limits(y = 1) +
                geom_bar_interactive(aes(x=annee, y=valeur, tooltip=paste0(round(valeur, 1), " GWh")),
                                     stat = "identity", fill=col_ter)
    )

  })

  output$tab_MW_hydro <- function() ({
    req(input$mon_ter)
    inner_join(Enedis_com_a_reg, liste_ter()) %>%
      filter(grepl("Hydraulique", Filiere.de.production), grepl("Puissance", indicateur)) %>%
      arrange(desc(annee)) %>%
      mutate(`Année`=substr(annee, 1,4), valeur=round(valeur/1000,1)) %>%
      select(`Année`, everything(), -Filiere.de.production, -indicateur, -TypeZone, -CodeZone,
             -annee, -ends_with("stimation")) %>%
      spread(key = Zone, value=valeur) %>%
      kable(align="c", row.names=F) %>%
      kable_styling(bootstrap_options = c("striped", "hover", "condensed","responsive"), full_width = T) %>%
      row_spec(0,  color = "black", bold = "T")  })

  output$carto_hydro <- renderLeaflet({
    req(input$mon_ter)
    carte_hydro <- couche_fil("hydro",input$mon_ter, 3)
    (contours() + carte_hydro)@map %>%
      addFullscreenControl()

  })

  user.created.map_hydro <- reactive({
    req(input$mon_ter)
    carte_hydro <- couche_fil("hydro", input$mon_ter, 3, TRUE)
    tag.map.title <- tags$style(HTML("
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
    }"))
    title <- tags$div(
      tag.map.title, HTML("Installations hydro-électriques<br>raccordées", paste0("<p>Source : registre au 31/12/",mil))
    )
    (contours() + carte_hydro)@map %>%
      addControl(title, position = "topleft", className="map-title")
  }) # end of creating user.created.map()

  output$bouton_carte_hydro <- downloadHandler(
    filename = paste0( Sys.Date(),"_map_hydro",".png"),
    content = function(file) {
      map<-mapshot( user.created.map_hydro(),
                    file = file,
                    cliprect = "viewport",
                    selfcontained = FALSE)
    } # end of content() function
  ) # end of downloadHandler() function

  #--------------------------Bioénergie---------------------------------------------------

  output$boxBio1 <- renderValueBox({
    req(input$mon_ter)
    valueBox(
      value=filter(indic_registre, CodeZone==input$mon_ter, variable %in% c("puiss_MW__bois","puiss_MW__dechet","puiss_MW__metha")) %>%
        summarise(valeur=sum(valeur)) %>% round(digits=1) %>% prettyNum(big.mark=" ", decimal.mark=",") %>%
        paste0(" MW"),
      subtitle=paste0("raccordés au 31 décembre ", mil),
      color="blue", icon = icon("leaf")
    )
  })

  output$boxBio2 <- renderValueBox({
    req(input$mon_ter)
    valueBox(value = filter(Enedis_com_a_reg, CodeZone==input$mon_ter, annee==mil, grepl("Nombre", indicateur),
                            Filiere.de.production=="Bio Energie") %>%
               summarise(valeur=sum(valeur)) %>%
               prettyNum(big.mark=" ", decimal.mark=","),
             subtitle=paste0("installations en fonctionnement en ", mil),
             color="blue", icon = icon("leaf")
    )
  })

  output$boxBio3 <- renderValueBox({
    req(input$mon_ter)
    valueBox(
      value=filter(Enedis_com_a_reg, CodeZone==input$mon_ter, annee==mil, grepl("Energie", indicateur),
                   Filiere.de.production=="Bio Energie") %>%
        summarise(valeur=sum(valeur)/1000000) %>% round(digits=1) %>%
        prettyNum(big.mark=" ", decimal.mark=",") %>% paste0(" GWh"),
      subtitle=paste0("GWh produit en ", mil),  width=100,
      color="blue", icon = icon("leaf")
    )
  })

  output$leg_evol_7 <- renderText({ leg_evol_MW() })
  output$leg_evol_8 <- renderText({ leg_evol() })

  output$bio_evol_MW <- renderGirafe ({
    req(input$mon_ter)
    girafeTEO(graph_evol("Bio", "Puissance", ter_evol()) +
                guides(colour="none"))
  })

  output$evol_nb_bio <- renderGirafe ({
    req(input$mon_ter)
    girafeTEO(graph_evol("Bio", "Nombre", ter_evol()) +
                guides(colour="none"))

  })

  output$legende_evol_bio_plot <- renderPlot ({
    req(input$mon_ter)
    if(maille_terr()=="Départements") {
      ter_legende <- tail(ter_evol(),2)
      }
    else {ter_legende <- ter_evol()}
    graph_evol("Bio", "Puiss", ter_legende) %>%
      get_legend() %>% ggdraw()
  })

  output$legende_evol_bio_txt<-renderText({
    paste("<font size =\"2\">Développement régional des filières bioénergie :</font>",
          "<font size =\"2\" color=\"#0073b7\">pas d'objectifs définis spécifiquement pour la cogénération.</font>")
  })

  output$legende_evol_bio_ui<-renderUI({
    if(maille_terr()=="Régions"){
      htmlOutput("legende_evol_bio_txt")
    } else {
      plotOutput("legende_evol_bio_plot",inline = F, height="23px", width="100%")
    }
  })

  output$bar_prod_bio <- renderGirafe ({
    req(input$mon_ter)
    girafeTEO(filter(Enedis_com_a_reg, CodeZone==input$mon_ter,
                     grepl("Bio", Filiere.de.production), grepl("Energie", indicateur)) %>%
                mutate(valeur=valeur/1000000) %>%
                ggteo() +
                geom_bar_interactive(aes(x=annee, y=valeur, tooltip=paste0(round(valeur, 1), " GWh")),
                                     stat = "identity", fill=col_ter)
              )
  })

  output$tab_MW_bio <- function() ({
    req(input$mon_ter)
    inner_join(Enedis_com_a_reg, liste_ter()) %>%
      filter(grepl("Bio", Filiere.de.production), grepl("Puissance", indicateur)) %>%
      mutate(`Année`=substr(annee, 1,4), valeur=round(valeur/1000,1)) %>%
      select(`Année`, everything(), -Filiere.de.production, -indicateur, -TypeZone, -CodeZone,
             -annee, -ends_with("stimation")) %>%
      spread(key = Zone, value=valeur) %>%
      arrange(desc(as.character(`Année`))) %>%
      kable(align="c", row.names=F) %>%
      kable_styling(bootstrap_options = c("striped", "hover", "condensed","responsive"), full_width = T) %>%
      row_spec(0,  color = "black", bold = "T")  })

  output$carto_bio <- renderLeaflet({
    req(input$mon_ter)
      carte_bois <- couche_fil("bois",input$mon_ter, 1)
      carte_dechet<-couche_fil("dechet",input$mon_ter, 2)
      carte_metha<-couche_fil("metha",input$mon_ter, 4)
    (contours() + carte_bois + carte_dechet + carte_metha)@map %>%
      addFullscreenControl()
  })

  user.created.map_bio <- reactive({
    req(input$mon_ter)
    carte_bois <- couche_fil("bois",input$mon_ter, 1, TRUE)
    carte_dechet<-couche_fil("dechet",input$mon_ter, 2, TRUE)
    carte_metha<-couche_fil("metha",input$mon_ter, 4, TRUE)
    # carte_bio <- carte_bois + carte_dechet + carte_metha
    tag.map.title <- tags$style(HTML("
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
    }"))
    title <- tags$div(
      tag.map.title, HTML("Installations de bio énergie raccordées", paste0("<p>Source : registre au 31/12/",mil))
    )
    (contours() + carte_bois + carte_dechet + carte_metha)@map %>%
      addControl(title, position = "topleft", className="map-title")
  }) # end of creating user.created.map()

  output$bouton_carte_bio <- downloadHandler(
    filename = paste0( Sys.Date(),"_map_bio-energie",".png"),
    content = function(file) {
      map<-mapshot( user.created.map_bio(),
                    file = file,
                    cliprect = "viewport",
                    selfcontained = FALSE)
    } # end of content() function
  ) # end of downloadHandler() function

  #--------------------------INJECTION BIOGAZ---------------------------------------------------

  nb_ins_biogaz <- reactive({
    req(input$mon_dept)
    filter(indic_biogaz_epci_a_reg_reg, CodeZone==input$mon_ter, annee==mil_gaz, grepl("nb_instal", indicateur)) %>%
      summarise(valeur=sum(valeur))
    })

  output$boxgaz1 <- renderValueBox({
    req(input$mon_ter)
    valueBox(
      value= nb_ins_biogaz() %>% prettyNum(big.mark=" ", decimal.mark=","),
      subtitle=paste0("installations en fonctionnement en ", mil_gaz),
      color="blue", icon = icon("burn")
    )
  })

  output$boxgaz2 <- renderValueBox({
    req(input$mon_ter)
    valueBox(
      value=filter(indic_epci_a_reg, CodeZone==input$mon_ter) %>%
        summarise(valeur=round(pourcent_bioch4, 2))%>%
        prettyNum(big.mark=" ", decimal.mark=",") %>%
        paste0(" %"),
      subtitle=paste0("consommation gaz couverte par les injections de biométhane en ", mil),
      color="blue", icon = icon("burn")
    )
  })

  output$boxgaz3 <- renderValueBox({
    req(input$mon_ter)
    valueBox(
      value=filter(indic_biogaz_epci_a_reg_reg, CodeZone==input$mon_ter, annee==mil_gaz, grepl("_inject", indicateur)) %>%
        summarise(valeur=sum(valeur)/1000) %>% round(digits=1) %>% prettyNum(big.mark=" ", decimal.mark=",") %>%
        paste0(" GWh"),
      subtitle=paste0("GWh injectés sur le réseau en ", mil_gaz), width=100,
      color="blue", icon = icon("burn")
    )
  })

  output$pie_MW_gaz <- renderGirafe ({
    req(input$mon_ter)
    p <- arrange(liste_ter(), desc(row_number())) %>%
      inner_join(indic_biogaz_epci_a_reg_reg) %>%
      filter(grepl("capaci", indicateur), annee==mil_gaz) %>%
      ggplot() + scale_fill_manual(values=col_biogaz)+
      geom_bar_interactive(aes(x=Zone, y=valeur, fill=type,
                               tooltip = paste0(type, " : ", prettyNum(round(valeur, 1), decimal.mark = ","), " GWh/an") %>% enc2utf8() %>%
                                 htmlEscape(TRUE)) ,
                           stat="identity", position="fill") +
      labs(title=element_blank(), x=element_blank(), y=element_blank(), colour = NULL, fill=NULL)

    if (maille_terr()!="Régions") {
      girafeTEO( p +  theme_TEO + scale_y_continuous(labels = c("0%", "25%", "50%", "75%", "100%")))
    }
    else {
      girafeTEO( p + theme_TEO_carto + coord_polar(theta = "y") )
    }

  })

  output$pie_MWh_gaz <- renderGirafe ({ req(input$mon_ter)
    p <- arrange(liste_ter(), desc(row_number())) %>%
      inner_join(indic_biogaz_epci_a_reg_reg) %>%
      filter(grepl("_inject", indicateur), annee==mil_gaz) %>%
      ggplot() + scale_fill_manual(values=col_biogaz) +
      geom_bar_interactive(aes(Zone, valeur, fill=type,
                               tooltip = paste0(type, " : ", round(valeur/1000,1), " GWh") %>% htmlEscape(TRUE)),
                           stat="identity", position="fill" ) +
      labs(title=element_blank(), x=element_blank(), y=element_blank(), colour = NULL, fill=NULL)

    if (maille_terr()!="Régions") {
      girafeTEO( p +  theme_TEO + scale_y_continuous(labels = c("0%", "25%", "50%", "75%", "100%")))
    }
    else {
      girafeTEO( p + theme_TEO_carto + coord_polar(theta = "y") )
    }
  })

  output$carto_inst_gaz <- renderLeaflet({
    req(input$mon_ter)
    # carte_agri <- couche_typ_gaz(typ="Agricole", code_ter=input$mon_ter, col = 4)
    carte_agri <- couche_typ_gaz("Agricole", input$mon_ter, 4)
    carte_dechet <- couche_typ_gaz("Déchets ménagers", input$mon_ter, 1)
    carte_indust <- couche_typ_gaz("Industriel", input$mon_ter, 6)
    carte_isdnd <- couche_typ_gaz("ISDND", input$mon_ter, 2)
    carte_step <- couche_typ_gaz("Station d'épuration", input$mon_ter, 3)
    carte_terri <- couche_typ_gaz("Territorial", input$mon_ter, 5)

    (contours() + carte_agri + carte_dechet + carte_indust + carte_isdnd + carte_step + carte_terri )@map %>%
      addFullscreenControl()
  })

  user.created.map_inst_gaz <- reactive({
    req(input$mon_ter)
    carte_agri <- couche_typ_gaz_legend(typ="Agricole", code_ter=input$mon_ter, col = 4)
    carte_dechet <- couche_typ_gaz_legend("Déchets ménagers", input$mon_ter, 1)
    carte_indust <- couche_typ_gaz_legend("Industriel", input$mon_ter, 6)
    carte_isdnd <- couche_typ_gaz_legend("ISDND", input$mon_ter, 2)
    carte_step <- couche_typ_gaz_legend("Station d'épuration", input$mon_ter, 3)
    carte_terri <- couche_typ_gaz_legend("Territorial", input$mon_ter, 5)
    tag.map.title <- tags$style(HTML("
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
    }"))
    title <- tags$div(
      tag.map.title, HTML("Points d'injection de biométhane", paste0("<p>Source registre biométhane au 31/12/", mil_gaz))
    )
    (contours() + carte_agri + carte_dechet + carte_indust + carte_isdnd + carte_step + carte_terri )@map %>%
      addControl(title, position = "topleft", className="map-title")
  }) # end of creating user.created.map()

  output$bouton_carte_inst_gaz <- downloadHandler(
    filename = paste0( Sys.Date(),"_map_inst_gaz",".png"),
    content = function(file) {
      map<-mapshot( user.created.map_inst_gaz(),
                    file = file,
                    cliprect = "viewport",
                    selfcontained = FALSE)
    } # end of content() function
  ) # end of downloadHandler() function

  output$carto_part_bioch4 <- renderGirafe({
    req(input$mon_ter)

    # if (maille_terr()=="Epci")
    # {carto_maille <- filter(carto_com, EPCI==input$mon_ter)}
    # else

    if (maille_terr()=="Epci") {
      carto_mai <- carto_epci
      limites <- filter(carto_epci, EPCI==input$mon_ter) %>% st_bbox()
    }
    if (maille_terr()=="Régions") {
      carto_mai <- carto_epci
      }
    if (maille_terr()=="Départements") {
      carto_mai <- filter(carto_epci, EPCI %in% epci_dep()$CodeZone)
    }

    cb <- ggplot(carto_mai, aes(fill=cat_prct_bioch4, tooltip=paste0(htmlEscape(Zone, TRUE), " : ", round(pourcent_bioch4,1), " %"))) +
      geom_sf_interactive() + theme_TEO_carto +
      scale_fill_brewer(palette="PuBuGn") +
      labs(title=element_blank(), x=element_blank(), y=element_blank(), fill=element_blank())

    if (maille_terr()=="Epci")  {
      cb <- cb + coord_sf(crs = st_crs(carto_mai), datum = NA, expand = FALSE,
                       xlim = c(limites[[1]]-25000, limites[[3]]+25000),
                       ylim = c(limites[[2]]-20000, limites[[4]]+20000))
      }
    else {
      cb <- cb + coord_sf(crs = st_crs(carto_mai), datum = NA)
      }

    girafeTEO(cb, fill_tooltip=FALSE)
  })

  output$tab_inst_gaz <- DT::renderDataTable(
    if (isTruthy(input$mon_ter)) {
      filter(inst_biogaz_reg, REG==input$mon_ter|DEP==input$mon_ter|EPCI==input$mon_ter) %>% as.data.frame() %>%
        select(commune=NOM_DEPCOM, installation=nom_du_projet, 'capacité (GWh/an)'=capacite_de_production_gwh_an, type,
               'mise en service'=date_de_mes, iris=NOM_IRIS, -geometry) %>%
        arrange(desc(`capacité (GWh/an)`), commune, type, installation)
      },
    extensions = 'Buttons', rownames = FALSE,
    options = list(dom = 'Bfrtip', pageLength = 10, language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/French.json'),
                   buttons = list(c(list(extend = 'csv', file=paste0(Sys.Date(), '-registre_biogaz_-', input$mon_ter, '.csv')))))
  )

  output$tab_MW_biogaz <- function() ({
    req(input$mon_ter)
    inner_join(indic_biogaz_epci_a_reg_reg, liste_ter()) %>%
      filter(grepl("capaci", indicateur)) %>%
      group_by(annee, indicateur, Zone) %>%
      summarise(valeur=sum(valeur, na.rm=T)) %>%
      ungroup() %>%
      mutate(`Année`=as.character(annee), valeur=round(valeur,1)) %>%
      select(-indicateur, -annee) %>%
      spread(key = Zone, value=valeur) %>%
      arrange(desc(`Année`)) %>%
      kable(align="c", row.names=F) %>%
      kable_styling(bootstrap_options = c("striped", "hover", "condensed","responsive"), full_width = T) %>%
      row_spec(0,  color = "black", bold = "T")  })

  output$bar_prod_biogaz <- renderGirafe ({
    req(input$mon_ter)
    girafeTEO(filter(indic_biogaz_epci_a_reg_reg, CodeZone==input$mon_ter, grepl("_inject", indicateur)) %>%
                mutate(valeur=valeur/1000) %>%
                ggteo() + expand_limits(y = 1) +
                geom_bar_interactive(aes(x=annee, y=valeur, fill=type, tooltip=paste0(round(valeur, 1), " GWh")),
                                     stat = "identity", position="stack") + scale_fill_manual(values=col_biogaz) +
                guides(fill="none")
    )

  })




  #--------------------------Téléchargements---------------------------------------------------
  fin_nom_fich <- reactive({
    req(input$mon_ter)
    paste0(mil, "-", tolower(substr(maille_terr(), 1, 1)), input$mon_ter, "_", Sys.Date())
  })

  # fichiers des installations du registre----------

  inst_terr <- reactive({
    req(input$mon_ter)
    filter(inst_reg, REG==input$mon_ter|DEP==input$mon_ter|EPCI==input$mon_ter) %>%
      select(-DEPARTEMENTS_DE_L_EPCI, -REG, -NOM_REG)
    })

  output$fic_instal_csv <- downloadHandler(
    filename=function() { req(input$mon_ter)
      paste0("Registre_elec_", fin_nom_fich(), ".csv")},
    content=function(file) { req(input$mon_ter)
      as.data.frame(inst_terr()) %>%
        select(-(precision_geo:geometry)) %>%
        write_csv2(file, na="")},
    contentType = "text/csv")

  output$fic_instal_json <- downloadHandler(
    filename=function() {req(input$mon_ter)
      paste0("Registre_elec_", fin_nom_fich(), ".geojson")},
    content=function(file) {
      req(input$mon_ter)
      inst_terr() %>%
        mutate_if(is.factor, as.character) %>%
        sf_geojson() %>%
        geo_write(file)},
    contentType = "application/geo+json")


  #  Liste des points d'injections de biométhane -----------------

  inst_terr_biogaz <- reactive({
    req(input$mon_ter)
    filter(inst_biogaz_reg, REG==input$mon_ter|DEP==input$mon_ter|EPCI==input$mon_ter) %>%
      select(-DEPARTEMENTS_DE_L_EPCI, -REGIONS_DE_L_EPCI, -REG, -NOM_REG)
  })

  output$fic_ins_bioch4_csv <- downloadHandler(
  filename=function() {req(input$mon_ter)
    paste0("Registre_biomethane_", fin_nom_fich(), ".csv")},
  content=function(file) {req(input$mon_ter)
    as.data.frame(inst_terr_biogaz()) %>%
      select(-geometry, -data_annuelles) %>%
      write_csv2(file, na="")},
  contentType = "text/csv")


  output$fic_ins_bioch4_json <- downloadHandler(
    filename=function() {req(input$mon_ter)
      paste0("Registre_biomethane_", fin_nom_fich(), ".geojson")},
    content=function(file) {
      req(input$mon_ter)
      inst_terr_biogaz() %>%
        mutate_if(is.factor, as.character) %>%
        sf_geojson() %>%
        geo_write(file)},
    contentType = "application/geo+json")


  # fichiers des conso + indic part EnR&R---------
  output$fic_conso <- downloadHandler(
    filename=function() {req(input$mon_ter)
      paste0("Conso_et_part_EnRR_", fin_nom_fich(), ".csv")},
    content=function(file) {
      req(input$mon_ter)
      if (maille_terr()=="Epci") {
        data_conso <- filter(carto_com, EPCI==input$mon_ter) %>%
          as.data.frame() %>%
          mutate(TypeZone="Communes", CodeZone=DEPCOM) %>%
          select(-geometry, -cat_prct_enrr, -cat_prct_bioch4, -EPCI, -DEPCOM, -AREA) %>%
          bind_rows(
            filter(carto_iris, EPCI==input$mon_ter) %>%
              mutate(TypeZone="Iris", CodeZone=CODE_IRIS, Zone = NOM_IRIS) %>%
              as.data.frame() %>% select(-geometry, -cat_prct_enrr, -cat_prct_bioch4, -CODE_IRIS, -NOM_IRIS, -TYP_IRIS, 
                                         -DEP, -EPCI, -DEPCOM, -sce_estim)
          ) %>%
          bind_rows(
            inner_join(liste_ter(), indic_epci_a_reg)
          )
      }
      else
        if (maille_terr()=="Régions") {data_conso <- indic_epci_a_reg}
      else {
        data_conso <- filter(carto_com, substr(DEPCOM, 1, 2) == input$mon_ter) %>%
          as.data.frame() %>%
          mutate(TypeZone="Communes", CodeZone=DEPCOM) %>%
          select(-geometry, -cat_prct_enrr, -cat_prct_bioch4, -EPCI, -DEPCOM, -AREA) %>%
          bind_rows(
            filter(indic_epci_a_reg, CodeZone %in% c(epci_dep()$CodeZone, as.character(liste_ter()$CodeZone)))
          )
      }
      
      data_conso %>% rename(conso_elec_GWh=CONSO_GWH, prod_elec_renouv_GWh=prod_GWh, pourcent_enrr_elec=pourcent_enrr,
                            org_reseaux_elec=Sources, injections_bioch4_GWh=injections_GWh, source_inject_bioch4=source_inject) %>%
        select(TypeZone, CodeZone, Zone, contains("elec"), conso_gaz_GWh, contains("bioch4"), org_reseaux_gaz=source_conso_gaz ) %>%
        mutate(org_reseaux_gaz = map(org_reseaux_gaz, ~paste(.x, collapse = ", ")) %>% unlist,
               source_inject_bioch4 = map(source_inject_bioch4, ~paste(.x, collapse = ", ")) %>% unlist,
               across(where(is.numeric), ~ round(.x, 2))) %>%
        write_csv2(file, na="")},
    contentType = "text/csv")

  # fichier des productions elect enrr---------
  output$fic_prod <- downloadHandler(
    filename=function() {req(input$mon_ter)
      paste0("Productions_capacites_elec_", fin_nom_fich(), ".csv")},
    content=function(file) {
      req(input$mon_ter)
      if (maille_terr()=="Epci") {
        data_prod <- com_iris_csv_elec %>%
          filter(EPCI == input$mon_ter) %>%
          select(-DEP, -EPCI) %>% 
          bind_rows(
          inner_join(liste_ter(), Enedis_com_a_reg) %>%
            left_join(liste_zone_complete))
      }
      else
        if (maille_terr()=="Régions") {data_prod <- Enedis_com_a_reg %>%
          filter(TypeZone != "Communes") %>% 
          left_join(liste_zone_complete)}
      
      else {
        data_prod <- filter(Enedis_com_a_reg, CodeZone %in% c(epci_dep()$CodeZone, as.character(liste_ter()$CodeZone))) %>%
          left_join(liste_zone_complete) %>%
          bind_rows(com_iris_csv_elec %>%
                      filter(DEP == input$mon_ter, TypeZone == "Communes") %>%
                      select(-DEP, -EPCI))
      }
      
      data_prod  %>%
        select(TypeZone, CodeZone, Zone, everything()) %>%
        arrange(desc(TypeZone), CodeZone, annee) %>% 
        mutate(across(where(is.numeric), ~ round(.x, 2))) %>% 
        write_csv2(file, na="")},
    contentType = "text/csv")


  # fichier des injections de biométhane--------------

  output$fich_prod_bioch4 <- downloadHandler(
    filename = function() { req(input$mon_ter)
      paste0("Injections_capacites_biomethane_", fin_nom_fich(), ".csv")},
    content = function(file) {
      req(input$mon_ter)
      if (maille_terr()=="Epci") {
        data_prod <- com_iris_csv_biogaz %>%
          filter(EPCI == input$mon_ter) %>%
          select(-DEP, -EPCI) %>% 
          bind_rows(inner_join(liste_ter(), indic_biogaz_epci_a_reg_reg))
      }
      else
        if (maille_terr()=="Régions") {data_prod <- indic_biogaz_epci_a_reg_reg}
      else {
        data_prod <- filter(indic_biogaz_epci_a_reg_reg, CodeZone %in% c(epci_dep()$CodeZone, as.character(liste_ter()$CodeZone))) %>%
          bind_rows(com_iris_csv_biogaz %>%
                      filter(DEP == input$mon_ter, TypeZone == "Communes") %>%
                      select(-DEP, -EPCI))
      }
      data_prod %>%
        mutate(source=paste(source)) %>%
        select(TypeZone, CodeZone, Zone, annee, indicateur, type, valeur, source) %>%
        arrange(desc(TypeZone), CodeZone, annee) %>% 
        mutate(across(where(is.numeric), ~ round(.x, 2))) %>% 
        write_csv2(file, na="")},
    contentType = "text/csv")




  #--------------------------A propos---------------------------------------------------

  })
  
  