
# Chargement des packages : 9 sec, mapview est parmis les plus couteux
library(tidyverse)
library(lubridate)
library(sf)
library(sp)
library(rgdal)

library(shinydashboard)
library(shiny)
library(shinyBS)
library(shinycssloaders)
library(bsplus)
library(htmltools)
library(htmlwidgets)
library(markdown)

library(png)

library(leaflet)
library(leaflet.extras)
library(mapview)
library(leafpop)
# library(leafem)
library(geojsonsf)
library(geojson)

library(ggiraph)
library(ggthemes)
library(cowplot)

library(kableExtra)
library(DT)

if(!webshot::is_phantomjs_installed()) {webshot::install_phantomjs(force = FALSE)}

options(scipen=999)
# options("encoding"="UTF-8")

# chargement des données, moins d'un centieme de seconde
 # setwd("app")
load("data_appli.RData")

# fonctions utilitaires
is_not_empty <- function(x) all(!is.na(x)&x!="")
is_pas_zero  <- function(x) {
  if(is.numeric(x)) {all(x!=0)}
  else {TRUE}
}


# fonctions ggplot--------------------------------

theme_TEO <- theme_bw() %+replace% 
  theme(panel.grid = element_blank(), legend.position = "bottom", plot.margin = margin(0,0,0,0, unit="pt"),
        text = element_text(family = "sans", color = "black", face="plain", size = 15, hjust=0.5, vjust=0.5, angle=0, 
                            lineheight=1, margin=margin(0,0,0,0, unit="pt"), debug=F), 
        axis.text = element_text(size = 14),
        panel.background = element_blank(), legend.text = element_text(size = 14), legend.margin = margin(0,0,0,0, unit="pt"),
        legend.direction="horizontal") 

theme_TEO_carto <- theme_TEO %+replace% theme(axis.text = element_blank(), axis.ticks=element_blank(), axis.line=element_blank(),
                                              strip.background=element_blank(), panel.grid = element_blank(), panel.border = element_blank(),
                                              legend.position = "bottom")


ggteo <- function(data) {
  ggplot(data) + theme_TEO + 
    labs(title=element_blank(), x=element_blank(), y=element_blank(), colour = NULL, fill=NULL)
}

theme_set(theme_TEO)

girafeTEO <- function(plot, fill_tooltip=TRUE) {
  girafe(print(plot), width_svg = 9, height_svg = 6, pointsize=14)  %>% 
    girafe_options(opts_tooltip(use_fill = fill_tooltip, opacity = .8),
                   opts_toolbar(position = "bottomright", saveaspng = TRUE),
                   sizingPolicy(browser.defaultWidth = "100%", viewer.defaultWidth = "100%",
                                browser.defaultHeight = 400, viewer.defaultHeight = 400, 
                                browser.padding = 1, viewer.padding = 0,
                                browser.fill = TRUE, viewer.fill = TRUE),
                   opts_sizing(rescale = T))
}
#### Couleurs -------------------

col_registre <- c("#A86137", "#BBD66B" , rgb(0, 163, 224, maxColorValue =255), rgb(72, 162, 63, maxColorValue =255),
                  rgb(0, 94, 184, maxColorValue =255), rgb(234, 170, 0, maxColorValue =255)) %>%
  setNames(levels(inst_reg$typo))

col_enedis <- c("Bio Energie"=col_registre[[4]], "Eolien"=col_registre[[5]], 
                "Hydraulique"=col_registre[[3]], "Photovoltaïque"=col_registre[[6]])

col_biogaz <- c("Déchets ménagers" = col_registre[[2]],
                "ISDND" = col_registre[[1]],
                "Station d'épuration" = col_registre[[3]],
                "Agricole" = col_registre[[4]],
                "Territorial" = col_registre[[6]],
                "Industriel" = col_registre[[5]])
  
col_ter <- "#01a2d9"


# graph recurrents - evol en base 100--------------------------
graph_evol <- function(fil, indic, territoires) {
  
  if("Epci" %in% territoires$TypeZone) { # pour choix d'un epci
  
  data_evol <- inner_join(territoires, Enedis_com_a_reg) %>%
    filter(grepl(fil, Filiere.de.production), grepl(indic, indicateur)) %>%
    mutate(annee=as.Date(paste0(annee, "-12-31")), Zone=fct_inorder(as.character(Zone)), 
           CodeZone=fct_inorder(as.character(CodeZone))) %>%
    group_by(Filiere.de.production, CodeZone) %>%
    arrange(annee) %>%
    mutate(., valeur_cor = if_else(valeur<500 & grepl("Puissance", indicateur), 500, valeur),
           valeur_indiciee=if_else(valeur_cor/valeur_cor[1]*100>500,500, valeur_cor/valeur_cor[1]*100),
           tooltip=ifelse(grepl("Nombre", indicateur), prettyNum(valeur, big.mark = " "),
                          paste0(round(valeur/1000,1), " MW"))) %>%
    ungroup
    ggteo(data_evol) +
    geom_line_interactive(aes(x=annee, y=valeur_indiciee, color=Zone,
                              tooltip=paste0(htmlEscape(Zone, TRUE))), size=2 ) +
    geom_point_interactive(aes(x=annee, y=valeur_indiciee, color=Zone, 
                               tooltip=tooltip), size=1 ) +
    scale_color_economist()
  
  } else { # pour choix de la région ou d'un département
    
    graph <- bind_rows(Enedis_com_a_reg %>% mutate(type_estimation = "0_realise"), obj_reg) %>%
      inner_join(territoires, .) %>%
      filter(grepl(fil, Filiere.de.production), grepl(indic, indicateur)) %>%
      mutate(annee=as.Date(paste0(annee, "-12-31")),
             Zone=fct_inorder(as.character(Zone)), CodeZone=fct_inorder(as.character(CodeZone)),
             valeur=ifelse(grepl("Nombre", indicateur), valeur, valeur/1000),
             tooltip=ifelse(grepl("Nombre", indicateur), prettyNum(valeur, big.mark = " "),
                                   paste0(round(valeur,1), " MW"))) %>%
      ggteo()
    
    if("Départements" %in% territoires$TypeZone) {
      graph + geom_line_interactive(aes(x=annee, y=valeur, color=Zone,
                                        tooltip=paste0(htmlEscape(Zone, TRUE))), size=2 ) +
        geom_point_interactive(aes(x=annee, y=valeur, color=Zone, 
                                   tooltip=tooltip), size=1 ) + 
        scale_colour_manual(values = c(rep("#6794a7",nrow(territoires)-1), col_ter),
                            label= c(rep("autres départements",nrow(territoires)-1), as.character(territoires$Zone[nrow(territoires)])))
      } else {
        graph + geom_line_interactive(aes(x=annee, y=valeur, color=type_estimation,
                                          tooltip=paste0(htmlEscape(Zone, TRUE))), size=2 ) +
          geom_point_interactive(aes(x=annee, y=valeur, color=type_estimation, 
                                     tooltip=tooltip), size=1 ) +
          scale_colour_manual(values = c(col_ter, "ivory3"), label= c("réalisé", "objectifs SRCAE")) # + scale_x_discrete
        }
  }
    
}
# exemple usage
# graph_evol(fil = "Eol", indic = "Puissance", liste_ter) + guides(colour="none")

# carte des installations-------------------
mes_instal <- function(fil, code_ter, typ_exclus="xxxxxxxxx"){
  filter(inst_reg, grepl(fil, code_typo), !grepl(typ_exclus, code_typo),
         REG==code_ter|DEP==code_ter|EPCI==code_ter) %>%
    st_set_crs(2154) %>% 
    st_transform(crs = 4326) %>%
    st_set_crs(4326) %>% 
    st_jitter(factor = 0.008)
  
}

nb_instal <- function(fil, code_ter, typ_exclus="xxxxxxxxx"){
  filter(inst_reg, grepl(fil, code_typo), !grepl(typ_exclus, code_typo),
         REG==code_ter|DEP==code_ter|EPCI==code_ter) %>%
    nrow()
}

couche_fil <- function(fil, code_ter, col) {
  if(nb_instal(fil, code_ter)>0) {
    dta <- mes_instal(fil, code_ter) %>%
      mutate(typo=as.character(typo))  %>%
      transmute(commune = NOM_DEPCOM,
                installation = nominstallation,
                puissance_en_MW = puiss_MW,
                type = typo,
                part_renouvelable = part_EnR,
                mise_en_service = date_inst)
    nom_couche <- dta$type[1]
    tiquette <- paste0(dta$puissance_en_MW, " MW", " (", dta$type, ")")
    carte_fil <- mapview(dta, zcol="type", col.regions=col_registre[[col]], map.types = c("CartoDB.Positron"),legend=FALSE, label=tiquette,
                         popup = popupTable(dta, zcol=c("commune","installation","puissance_en_MW","type","part_renouvelable","mise_en_service")),
                         cex="puissance_en_MW", alpha = 0,layer.name=dta$type[1],
                         homebutton = FALSE)
  }  else { carte_fil <- NULL}
  carte_fil
}

couche_fil_legend <- function(fil, code_ter, col=1) {
  if(nb_instal(fil, code_ter)>0) {
    data <- mes_instal(fil, code_ter) %>% mutate(typo=as.character(typo))
    nom_couche <- data$typo[1]
    tiquette <- paste0(data$puiss_MW, " MW", " (", data$typo, ")")
    carte_fil <- mapview(data, zcol="typo", col.regions=col_registre[[col]], map.types = c("CartoDB.Positron"),
                         legend=TRUE,label=tiquette, cex="puiss_MW", alpha = 0,
                         layer.name=data$typo[1])
  }  else { carte_fil <- NULL}
  carte_fil
}

couche_typ_gaz <- function(typ, code_ter, col=1) {
  inst <- filter(inst_biogaz_reg, type==typ, REG==code_ter|DEP==code_ter|EPCI==code_ter) %>% 
    transmute(commune = NOM_DEPCOM,
              installation = nom_du_projet,
              capacite_en_GWh_par_an = capacite_de_production_gwh_an,
              type = type,
              mise_en_service = date_de_mes,
              iris = NOM_IRIS)
    
  if(nrow(inst)!=0) {
    data <- st_set_crs(inst, 2154) %>% 
      st_transform(4326) %>%
      st_set_crs(4326) %>% 
      st_jitter(factor = 0.008) %>% 
      mutate(type=as.character(type) %>% enc2utf8())
    tiquette = paste0("Capacité : ", data$capacite_en_GWh_par_an, " GWh/an", " (", data$type, ")") %>%
      enc2utf8()
    nom_couche <- data$type[1] %>% enc2utf8()
    carte_fil <- mapview(data, col.regions=col_biogaz[[col]], map.types = c("CartoDB.Positron"),
                         legend=FALSE, label=tiquette, 
                         popup = popupTable(data, zcol=c("commune","installation","capacite_en_GWh_par_an","type","mise_en_service","iris")),
                         cex="capacite_en_GWh_par_an", alpha = 0,
                         layer.name=nom_couche,
                         homebutton = FALSE)
  }  else { carte_fil <- NULL}
  carte_fil
}

couche_typ_gaz_legend <- function(typ, code_ter, col=1) {
  inst <- filter(inst_biogaz_reg, type==typ, REG==code_ter|DEP==code_ter|EPCI==code_ter)
  
  if(nrow(inst)!=0) {
    data <- st_set_crs(inst, 2154) %>% 
      st_transform(4326) %>%
      st_set_crs(4326) %>% 
      st_jitter(factor = 0.008) %>% 
      mutate(type=as.character(type) %>% enc2utf8())
    tiquette = paste0("Capacité : ", data$capacite_de_production_gwh_an, " GWh/an", " (", data$type, ")") %>%
      enc2utf8()
    nom_couche <- data$type[1] %>% enc2utf8()
    carte_fil <- mapview(data, col.regions=col_biogaz[[col]], map.types = c("CartoDB.Positron"),
                         legend=TRUE, label=tiquette, cex="capacite_de_production_gwh_an", alpha = 0,
                         layer.name=nom_couche)
  }  else { carte_fil <- NULL}
  carte_fil
}
