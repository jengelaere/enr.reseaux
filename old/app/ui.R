

dashboardPage(title = "Enr de réseaux en Pays de Loire", # personnalisation du thème
              
#En-tête-----------------------------------------------------------------------------              

      dashboardHeader(title = tags$img(src='forme_TEO_blanc.svg', height="100px")),
              

#Barre de menu-----------------------------------------------------------------------------              
             
      dashboardSidebar(
              
          # Menu avec la liste des onglets
          sidebarMenu(
              id="menu",  
              selectInput(inputId = "mon_dept", 
                          label = "Sélectionner un département",
                          choices = filter(liste_zone_complete, TypeZone!="Epci") %>% pull(CodeZone) %>% as.character() %>%
                            setNames(filter(liste_zone_complete, TypeZone!="Epci") %>% pull(Zone) %>% as.character()),
                          selected = reg),  
 
              uiOutput('terr_selec'),
              
              # div(submitButton("Valider"), align="center"),    
                
              tags$br(),
              
              tags$h3(HTML(paste("Filière")), style="color:white", align="center"),	
              
            
              menuItem("Réseaux électriques", tabName = "onglet1", icon = icon("bolt"),
                       menuItem("Toutes filières électriques", tabName = "onglet1", icon = icon("bolt")),
                       menuItem(HTML(paste(tags$img(src='si-glyph-wind-turbines.svg', width = "18px", height = "18px"),"   Eolien terrestre")), tabName = "eol"),
                       menuItem("Photovoltaïque", tabName = "pv", icon = icon("solar-panel")),
                       menuItem(HTML(paste(tags$img(src='iconfinder_sea1_216717.svg', width = "16px", height = "16px"),"   Hydroélectricité")), tabName = "hydro"),
                       menuItem("Bioénergie", tabName = "bio", icon = icon("leaf",lib = "font-awesome"))
                       ),
              menuItem("Réseaux gaz", tabName = "biogaz", icon = icon("burn")),
              menuItem("Téléchargement", tabName = "tel", icon = icon("table")),
              menuItem("A propos", tabName = "about", icon = icon("question-circle ")),
              
                  
              tags$br(),
              tags$br(),
              tags$a(href="http://teo-paysdelaloire.fr", target="_blank", tags$img(src="logo_teo.jpg",width="120px",style="display: block; margin-left: auto; margin-right: auto;")),
              tags$br(),
              tags$a(href="http://www.pays-de-la-loire.developpement-durable.gouv.fr/dreal-centre-de-service-de-la-donnee-r1957.html", target="_blank", tags$img(src="Logo_datalab_blanc.svg",width="150px",style="display: block; margin-left: auto; margin-right: auto;")),
              tags$br(),
              tags$a(href="http://www.pays-de-la-loire.developpement-durable.gouv.fr/air-climat-et-energie-r189.html", target="_blank", tags$img(src="logo_PrefDREAL2.png", width="150px",style="display: block; margin-left: auto; margin-right: auto;"))
              


          )
          
      ),
              


#"Corps" = contenu / sorties-----------------------------------------------------------------------------              

  dashboardBody(
    
    #CFA635  marron TEO
    #19AECA  bleu TEO
    
    tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "www/style.css"),
              tags$link(rel = "shortcut icon", type = "image/x-icon", href = "favicon00.ico"),
              tags$script(src="https://cdnjs.cloudflare.com/ajax/libs/iframe-resizer/4.1.1/iframeResizer.contentWindow.min.js",
                            type="text/javascript")
              ),
    # Contenu de chacun des onglets
    tabItems(
   #--------------------------Toutes filières électriques---------------------------------------------------                  
      tabItem(tabName = "onglet1",
              tags$h1(textOutput("nom_terr")), #, style="color:black"
              tags$h5("Toutes filières électriques renouvelables et de récupération", align="center"),
              style="color:black",

              tags$hr(),
              tags$style(HTML("hr {border-top: 3px solid #f4b943;
                              margin:0 0 12px 0;}")),


              # fluidRow(textOutput("maille_ter")
              #          ),

              # fluidRow(dataTableOutput("dep_graph")
              #          ),

              # fluidRow(dataTableOutput("tab_conso")
              #          ),

              fluidRow(   #1e ligne
               valueBoxOutput("boxEnR1"),
               valueBoxOutput("boxEnR2"),
               valueBoxOutput("boxEnR3")
                ),


              fluidRow(   #2e ligne

                box(status="primary", solidHeader = TRUE, width=6,
                    title = span("Répartition des puissances installées", style="color:white"),
                    girafeOutput("pie_MW",  width="100%", height = 370) %>% withSpinner(type=4),
                    style="color:black",
                    span(paste0("au 31/12/", mil, " - Source : Registre"), style="font-size: 12px")
                    ),

                box(status="primary", solidHeader = TRUE, width=6,
                   title = span("Répartition de la production EnR&R", style="color:white"),
                   girafeOutput("pie_MWh",  width="100%", height = 370),
                   style="color:black",
                   span(paste0("GWh produits en ", mil, " - Source : ENEDIS"), style="font-size: 12px")
                   )
               ),

              fluidRow(   #3e ligne

               box(status="primary", solidHeader = TRUE, width=6,
                    title = span("Installations de production électrique EnR&R", style="color:white"),
                    leafletOutput("carto_inst", width = "95%", height = 370),
                   downloadButton("bouton_carte_inst_elec","carte en png"),
                    style="color:black",
                    span(paste0("Source : registre au 31/12/", mil), style="font-size: 12px")
                ),

               box(status="primary", solidHeader = TRUE, width=6,
                   title = span(paste0("Part de la consommation couverte par les EnR&R en ", mil), style="color:white"),
                   girafeOutput("carto_part_enr", width = "100%", height = 380),
                   style="color:black",
                   span("Source : Données Enedis et SDES retravaillées par la DREAL", style="font-size: 12px")
                        )
                        # tabBox(
                        #   side = "right", height = "250px",
                        #   selected = "Tab3",
                        #   tabPanel("Tab1", "Tab content 1"),
                        #   tabPanel("Tab2", "Tab content 2"),
                        #   tabPanel("Tab3", "Note that when side=right, the tab order is reversed.")
                        # )
                ),

              fluidRow(   #5e ligne
                box(status="primary", solidHeader = TRUE, width=12,
                            title = span("Installations de production électrique EnR&R", style="color:white"),
                            dataTableOutput("tab_inst") %>% withSpinner(type=1),
                            style="color:black",
                            span(paste0("Source : registre au 31/12/", mil), style="font-size: 12px")
                        )
                ),
              HTML('<div data-iframe-height></div>')


              ),



   #--------------------------EOLIEN---------------------------------------------------
      tabItem(tabName = "eol",
              tags$h1(textOutput("nom_terr2")), #, style="color:black"
              tags$h5("Eolien", align="center"),
              tags$hr(),
              tags$style(HTML("hr {border-top: 3px solid #f4b943;}")),

              fluidRow(   #2e ligne
                # tags$br(),
                valueBoxOutput("boxEol1"),
                valueBoxOutput("boxEol2"),
                valueBoxOutput("boxEol3")
              ),

              fluidRow(   #3e ligne
                column(width=8,
                       fluidRow(
                         box(status="primary",
                             solidHeader = TRUE, width=6,
                             title = span("Evolution des puissances installées", style="color:white"),
                             girafeOutput("Eol_evol_MW",  width="100%", height=275) %>% withSpinner(type=4),
                             style="color:black",
                             span(textOutput("leg_evol_1"), style="font-size: 12px")
                         ),
                         box(status="primary",
                             solidHeader = TRUE, width=6,
                             title = span("Evolution du nombre d'installations", style="color:white"),
                             girafeOutput("evol_nb_eol",  width="100%", height=275),
                             style="color:black",
                             span(textOutput("leg_evol_2"), style="font-size: 12px")
                         )
                       ),
                       fluidRow(
                         box(status="primary",
                             solidHeader = TRUE, width=12,
                             plotOutput("legende_evol_eol", inline = F, height="23px", width="100%")
                         )
                       )
                ),
                column(width=4, fluidRow(
                  box(status="primary",
                      solidHeader = TRUE, width=12,
                      title = span("Productions annuelles", style="color:white"),
                      girafeOutput("bar_prod_eol",  width="100%", height=320),
                      style="color:black",
                      span("GWh - Source : ENEDIS", style="font-size: 12px")
                  )
                ))
                ),

              fluidRow(   #4e ligne
                box(status="primary",
                    solidHeader = TRUE, width=5,
                    title = span("Evolution des puissances installées (MW)", style="color:white"),
                    tableOutput("tab_MW_eol"),
                    style="color:black",
                    span("MW raccordés au 31/12 - Source : ENEDIS jusque 2017 puis registre", style="font-size: 12px")
                ),

                box(status="primary", solidHeader = TRUE, width=7,
                    title = span("Parcs éoliens raccordés", style="color:white"),
                    footer = span(tags$a(href="https://carto.sigloire.fr/1/n_sre_eolien_r52.map", 
                                         "Accéder à la carte détaillée du suivi du développement éolien de la DREAL sur SIGLoire", 
                                         target="_blank"), style="font-size: 18px"),
                    leafletOutput("carto_eol", width = "95%", height = 370),
                    downloadButton("bouton_carte_eol","carte en png"),
                    style="color:black",
                    span(paste0("Source : registre au 31/12/", mil), style="font-size: 12px")
                )
              ),
              HTML('<div data-iframe-height></div>')


       ),



   #--------------------------photovoltaique---------------------------------------------------
    tabItem(tabName = "pv",
            tags$h1(textOutput("nom_terr3")), 
            tags$h5("Photovoltaïque",align="center"),
            tags$hr(),
            tags$style(HTML("hr {border-top: 3px solid #f4b943;}")),
            
            fluidRow(   #2e ligne
              valueBoxOutput("boxPV1"),
              valueBoxOutput("boxPV2"),
              valueBoxOutput("boxPV3")
              ),

            fluidRow(   #3e ligne
              column(width=8,
                     fluidRow(
                       box(status="primary",
                           solidHeader = TRUE, width=6,
                           title = span("Evolution des puissances installées", style="color:white"),
                           girafeOutput("PV_evol_MW", width="100%", 275) %>% withSpinner(type=4),
                           style="color:black",
                           span(textOutput("leg_evol_3"), style="font-size: 12px")
                       ),
                       box(status="primary",
                           solidHeader = TRUE, width=6,
                           title = span("Evolution du nombre d'installations", style="color:white"),
                           girafeOutput("evol_nb_PV", width="100%", height=275),
                           style="color:black",
                           span(textOutput("leg_evol_4"), style="font-size: 12px")
                       )
                     ),
                     fluidRow(
                       box(status="primary",
                           solidHeader = TRUE, width=12,
                           plotOutput("legende_evol_PV", inline = F, height="23px", width="100%")
                           )
                       )
              ),
              column(width=4, fluidRow(
              box(status="primary",
                  solidHeader = TRUE, width=12,
                  title = span("Productions annuelles", style="color:white"),
                  girafeOutput("bar_prod_pv", width="100%", height=320),
                  style="color:black",
                  span("GWh - Source : ENEDIS", style="font-size: 12px")
              )
              ))

            ),

            fluidRow(   #4e ligne
              box(status="primary",
                  solidHeader = TRUE, width=5,
                  title = span("Evolution des puissances installées (MW)", style="color:white"),
                  tableOutput("tab_MW_PV"),
                  style="color:black",
                  span("MW raccordés au 31/12 - Source : ENEDIS jusque 2017 puis registre",style="font-size: 12px")
              ),
              box(status="primary", solidHeader = TRUE, width=7,
                  title = span("Installations solaires photovoltaïques raccordées", style="color:white"),
                  leafletOutput("carto_PV", width = "95%", height = 370),
                  downloadButton("bouton_carte_pvq","carte en png"),
                  style="color:black",
                  span(paste0("Source : registre au 31/12/", mil), style="font-size: 12px")
              )
              ),
            HTML('<div data-iframe-height></div>')

            ),
   #--------------------------Hydroélectricité---------------------------------------------------
   tabItem(tabName = "hydro",
           tags$h1(textOutput("nom_terr4")), 
           tags$h5("Hydroélectricité", align="center"),
           tags$hr(),
           tags$style(HTML("hr {border-top: 3px solid #f4b943;}")),

           fluidRow(   #2e ligne
             # tags$br(),
             valueBoxOutput("boxHydro1"),
             valueBoxOutput("boxHydro2"),
             valueBoxOutput("boxHydro3")
             ),

           fluidRow(   #3e ligne
             column(width=8,
                    fluidRow(
                      box(status="primary",
                          solidHeader = TRUE, width=6,
                          title = span("Evolution des puissances installées", style="color:white"),
                          girafeOutput("Hydro_evol_MW",  width="100%", height=275) %>% withSpinner(type=4),
                          style="color:black",
                          span(textOutput("leg_evol_5"), style="font-size: 12px")
                          ),
                      box(status="primary",
                          solidHeader = TRUE, width=6,
                          title = span("Evolution du nombre d'installations", style="color:white"),
                          girafeOutput("evol_nb_hydro",  width="100%", height=275),
                          style="color:black",
                          span(textOutput("leg_evol_6"), style="font-size: 12px")
                          )
                      ),
                    fluidRow(
                      box(status="primary",
                          solidHeader = TRUE, width=12,
                          plotOutput("legende_evol_hydro", inline = F, height="23px", width="100%")
                          )
                      )
                    ),
             column(width=4, 
                    fluidRow(
                       box(status="primary",
                           solidHeader = TRUE, width=12,
                           title = span("Productions annuelles", style="color:white"),
                           girafeOutput("bar_prod_hydro",  width="100%", height=320),
                           style="color:black",
                           span("GWh - Source : ENEDIS", style="font-size: 12px")
                           )
                       )
                    )
             ),

           fluidRow(   #4e ligne
             box(status="primary",
                 solidHeader = TRUE, width=5,
                 title = span("Evolution des puissances installées (MW)", style="color:white"),
                 tableOutput("tab_MW_hydro"),
                 style="color:black",
                 span("MW raccordés au 31/12 - Source : ENEDIS jusque 2017 puis registre", style="font-size: 12px")
                 ),
             box(status="primary", solidHeader = TRUE, width=7,
                 title = span("Installations hydro-électriques raccordées", style="color:white"),
                 leafletOutput("carto_hydro", width = "95%", height = 370),
                 downloadButton("bouton_carte_hydro","carte en png"),
                 style="color:black",
                 span(paste0("Source : registre au 31/12/", mil), style="font-size: 12px")
                 )
             ),
           
           HTML('<div data-iframe-height></div>')
           ),
   #--------------------------bioénergie---------------------------------------------------
   tabItem(tabName = "bio",
           tags$h1(textOutput("nom_terr7")), 
           tags$h5("Production d'électricité à partir de bioénergie",align="center"),
           tags$hr(),
           tags$style(HTML("hr {border-top: 3px solid #f4b943;}")),
           
           fluidRow(   #2e ligne
              valueBoxOutput("boxBio1"),
              valueBoxOutput("boxBio2"),
              valueBoxOutput("boxBio3")
              ),
           
           fluidRow(   #3e ligne
              column(width=8,
                     fluidRow(
                        box(status="primary",
                            solidHeader = TRUE, width=6,
                            title = span("Evolution des puissances installées", style="color:white"),
                            girafeOutput("bio_evol_MW", width="100%", 275) %>% withSpinner(type=4),
                            style="color:black",
                            span(textOutput("leg_evol_7"), style="font-size: 12px")
                            ),
                        box(status="primary",
                            solidHeader = TRUE, width=6,
                            title = span("Evolution du nombre d'installations", style="color:white"),
                            girafeOutput("evol_nb_bio", width="100%", height=275),
                            style="color:black",
                            span(textOutput("leg_evol_8"), style="font-size: 12px")
                            )
                        ),
                     fluidRow(
                        box(status="primary",
                            solidHeader = TRUE, width=12,
                            # plotOutput("legende_evol_bio", inline = F, height="23px", width="100%")
                            uiOutput("legende_evol_bio_ui")
                            )
                        )
                     ),
              column(width=4, 
                     fluidRow(
                        box(status="primary",
                            solidHeader = TRUE, width=12,
                            title = span("Productions annuelles", style="color:white"),
                            girafeOutput("bar_prod_bio", width="100%", height=320),
                            style="color:black",
                            span("GWh - Source : ENEDIS", style="font-size: 12px")
                            )
                        )
                     )
              ),
           
           fluidRow(   #4e ligne
              box(status="primary",
                  solidHeader = TRUE, width=5,
                  title = span("Evolution des puissances installées (MW)", style="color:white"),
                  tableOutput("tab_MW_bio"),
                  style="color:black",
                  span("MW raccordés au 31/12 - Source : ENEDIS jusque 2017 puis registre",style="font-size: 12px")
                  ),
              box(status="primary", solidHeader = TRUE, width=7,
                  title = span("Installations de bioénergie raccordées", style="color:white"),
                  leafletOutput("carto_bio", width = "95%", height = 370),
                  downloadButton("bouton_carte_bio","carte en png"),
                  style="color:black",
                  span(paste0("Source : registre au 31/12/", mil), style="font-size: 12px")
                  )
              ),
           
           HTML('<div data-iframe-height></div>')
           ),

   #--------------------------injections biogaz---------------------------------------------------

    tabItem(tabName = "biogaz",
            tags$h1(textOutput("nom_terr5")), #, style="color:black"
            tags$h5("Injections de biométhane sur les réseaux de gaz naturel", align="center"),
            tags$hr(),
            tags$style(HTML("hr {border-top: 3px solid #f4b943;}")),

            fluidRow(   #1e ligne
               valueBoxOutput("boxgaz1"),
               valueBoxOutput("boxgaz2"),
               valueBoxOutput("boxgaz3")
            ),
            
            
            fluidRow(   #2e ligne

               box(status="primary", solidHeader = TRUE, width=6,
                   title = span("Capacités installées selon le type", style="color:white"),
                   girafeOutput("pie_MW_gaz",  width="100%", height = 370) %>% withSpinner(type=4),
                   style="color:black",
                   span(paste0("au ", date_registre_biogaz, " - Source : registre biométhane ODRE"), style="font-size: 12px")
               ),

               box(status="primary", solidHeader = TRUE, width=6,
                   title = span("Injections de biométhane par type d'installations", style="color:white"),
                   girafeOutput("pie_MWh_gaz",  width="100%", height = 370),
                   style="color:black",
                   span(paste0("GWh injectés en ", mil_gaz, " - Source : GRDF et estimations DREAL"), style="font-size: 12px")
                   )
            ),

            fluidRow(   #3e ligne

               box(status="primary",
                   solidHeader = TRUE, width=6,
                   title = span("Evolution des capacités installées (GWh/an)", style="color:white"),
                   tableOutput("tab_MW_biogaz"),
                   style="color:black",
                   span("GWh/an raccordés au 31/12 - Source : registre biométhane ODRE", style="font-size: 12px")
                   ),
               
               box(status="primary",
                   solidHeader = TRUE, width=6,
                   title = span("Injections annuelles", style="color:white"),
                   girafeOutput("bar_prod_biogaz",  width="100%", height=250),
                   style="color:black",
                   span("GWh - Source : GRDF et estimations DREAL", style="font-size: 12px")
                   )
               ),
            
            fluidRow(   #4e ligne
               
               box(status="primary", solidHeader = TRUE, width=6,
                   title = span("Points d'injection de biométhane", style="color:white"),
                   leafletOutput("carto_inst_gaz", width = "95%", height = 370),
                   downloadButton("bouton_carte_inst_gaz","carte en png"),
                   style="color:black",
                   span(paste0("Source : registre biométhane ODRE au ", date_registre_biogaz), style="font-size: 12px")
               ),
               
               box(status="primary", solidHeader = TRUE, width=6,
                   title = span(paste0("Injections de biométhane rapportées à la consommation en ", mil), style="color:white"),
                   girafeOutput("carto_part_bioch4", width = "100%", height = 380),
                   style="color:black",
                   span("Source : Données GRDF, SDES et estimations DREAL", style="font-size: 12px")
               )
               
            ),

            fluidRow(   #5e ligne
               box(status="primary", solidHeader = TRUE, width=12,
                   title = span("Points d'injection de biométhane", style="color:white"),
                   dataTableOutput("tab_inst_gaz") %>% withSpinner(type=1),
                   style="color:black",
                   span(paste0("Source : registre biométhane ODRE au ", date_registre_biogaz), style="font-size: 12px")
               )
            ),
            HTML('<div data-iframe-height></div>')
            
            
    ),
            
   
   
   # --------------------------------TELECHARGEMENT---------------------------------   

   tabItem(tabName = "tel",
           tags$h1(textOutput("nom_terr6")), #, style="color:black"
           tags$h5("Téléchargement des données de l'application", align="center"),
           tags$hr(),
           tags$style(HTML("hr {border-top: 3px solid #f4b943;}")),
           #         
           fluidRow(   
             box(status="primary",
                 solidHeader = TRUE, width=6,
                 title = span("Registre des installations électriques", style="color:white"),
                 span("Téléchargez ici la liste des installations de production d'électricité renouvelable et de récupération de votre territoire"),
                 p(downloadButton("fic_instal_csv", label = "format tableur (csv)", class = NULL)),
                 p(downloadButton("fic_instal_json", label = "format geojson", class = NULL)),
                 style="color:black",
                 span(tags$a(href="https://opendata.reseaux-energies.fr/explore/dataset/registre-national-installation-production-stockage-electricite-agrege-311217/information/?disjunctive.departement&disjunctive.region&disjunctive.libelletension&disjunctive.libelle_filiere&disjunctive.libelle_combustible&disjunctive.libelle_combustible_secondaire&disjunctive.libelle_technologie", "Accédez à l'ensemble du registre électricité (données brutes)", target="_blank"), style="font-size: 12px")
             ),
             
             box(status="primary",
                 solidHeader = TRUE, width=6,
                 title = span("Points d'injection de bio-méthane", style="color:white"),
                 p("Téléchargez ici la liste des points d'injections de votre territoire"),
                 p(downloadButton("fic_ins_bioch4_csv", label = "format tableur (csv)", class = NULL)),
                 p(downloadButton("fic_ins_bioch4_json", label = "format geojson", class = NULL)),
                 style="color:black",
                 span(tags$a(href="https://opendata.reseaux-energies.fr/explore/dataset/points-dinjection-de-biomethane-en-france/custom/?disjunctive.site&disjunctive.departement&disjunctive.region&disjunctive.type_de_reseau&disjunctive.grx_demandeur", "Accédez à l'ensemble du registre biométhane (données brutes)", target="_blank"), style="font-size: 12px")
             )
           ),
           
           fluidRow(
             
             box(status="primary",
                 solidHeader = TRUE, width=6,
                 title = span("Productions électriques annuelles et capacités raccordées", style="color:white"),
                 p("Téléchargez ici les indicateurs annuels sur l'électricité renouvelable et de récupération de votre territoire"),
                 p(downloadButton("fic_prod", label = "format tableur (csv)", class = NULL)),
                 style="color:black",
                 span(tags$a(href="https://data.enedis.fr/explore/dataset/production-electrique-par-filiere-a-la-maille-commune/information/", "Accédez aux données sources sur la plateforme opendata d'Enedis (données brutes)", target="_blank"), style="font-size: 12px")
                 ),
             
             box(status="primary",
                 solidHeader = TRUE, width=6,
                 title = span("Injections annuelles de biométhane et capacités d'injection", style="color:white"),
                 p("Téléchargez ici les indicateurs annuels sur l'injection de biométhane de votre territoire"),
                 p(downloadButton("fich_prod_bioch4", label = "format tableur (csv)", class = NULL)),
                 style="color:black",
                 span(tags$a(href="https://opendata.grdf.fr/explore/dataset/capacite-et-quantite-dinjection-de-biomethane", "Accédez aux données sources sur la plateforme opendata de GRDF (données brutes)", target="_blank"), style="font-size: 12px")
             )
             
             
           ),
           fluidRow(
              box(status="primary",
                  solidHeader = TRUE, width=6,
                  title = span("Consommation et part EnR&R", style="color:white"),
                  p("Téléchargez ici les indicateurs liés à la consommation électrique et gaz de votre territoire"),
                  p(downloadButton("fic_conso", label = "format tableur (csv)", class = NULL),
                  style="color:black"),
                  span(tags$a(href="https://www.statistiques.developpement-durable.gouv.fr/donnees-locales-de-consommation-denergie?rubrique=23&dossier=189","Accédez à l'ensemble des données de consommations (données brutes)", target="_blank"), style="font-size: 12px")
                  ),
              box(status="primary", solidHeader = TRUE, width=6,
                  title = span("Nota tableurs CSV", style="color:white"),
                  "Les fichiers csv sont encodés en utf8 et utilisent le point virgule comme séparateur."
                 )
             ),
           
           HTML('<div data-iframe-height></div>')
           
   ),
   
   
   #--------------------------------A PROPOS----------------------------------------         
   tabItem(tabName = "about",
           tags$h5("A propos", align="center"),
           tags$hr(),
           tags$style(HTML("hr {border-top: 3px solid #f4b943;}")),
           
           fluidRow(tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "style.css")),
                    column(width=12,
                    includeMarkdown("a_propos.md"))
                    ),
           
           HTML('<div data-iframe-height></div>')
           
   )
   
#-----------------------------------------------------------------------------         

     
    )
)
              
  )
