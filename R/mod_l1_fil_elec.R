#' l1_fil_elec UI Function
#'
#' @description 1ere ligne des pages par filiere electriques, comprenant 3 boites de valeurs
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_l1_fil_elec_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    fluidRow(   #1e ligne
      valueBoxOutput(ns("box_puiss")),
      valueBoxOutput(ns("box_inst")),
      valueBoxOutput(ns("box_prod"))
    )
 
  )
}
    
#' l1_gaz_elec Server Functions
#'
#' @noRd 
#' @importFrom dplyr filter mutate pull
#' @importFrom rlang .data
mod_l1_fil_elec_server <- function(id, r, obj_page){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    locale <- reactiveValues()
    
    observeEvent(
      r$mon_ter,{
        
        locale$box_puiss <- obj_page$df_nb_inst_MWh %>% 
          dplyr::filter(.data$CodeZone==r$mon_ter, .data$annee==obj_page$millesime, 
                        grepl("puiss", tolower(indicateur)), grepl(obj_page$fil_enedis, .data$Filiere.de.production)) %>%
          dplyr::mutate(valeur=round(.data$valeur/1000, 1)) %>% # passage en MW
          dplyr::pull(.data$valeur) %>% 
          prettyNum(big.mark=" ", decimal.mark=",")%>%
          paste0(" MW")
        
        locale$box_inst <- dplyr::filter(obj_page$df_nb_inst_MWh, .data$CodeZone==r$mon_ter, .data$annee==obj_page$millesime, 
                                         grepl("Nombre|nb_instal", .data$indicateur), grepl(obj_page$fil_enedis, .data$Filiere.de.production)) %>%
          dplyr::pull(.data$valeur) %>%
          prettyNum(big.mark=" ", decimal.mark=",")
        
        locale$box_prod <- dplyr::filter(obj_page$df_nb_inst_MWh, .data$CodeZone==r$mon_ter, .data$annee==obj_page$millesime, 
                                         grepl("Energie", .data$indicateur), grepl(obj_page$fil_enedis, .data$Filiere.de.production)) %>%
          dplyr::mutate(valeur=round(.data$valeur/1000000, 1)) %>% # passage en GWh
          dplyr::pull(.data$valeur) %>%
          prettyNum(big.mark=" ", decimal.mark=",") %>%
          paste0(" GWh")
        
      })
    
    output$box_inst <- renderValueBox({
      valueBox(
        value=locale$box_inst,
        subtitle=paste0("installations en fonctionnement en ", obj_page$millesime), 
        color="blue", icon = icon(obj_page$icone)
      )
    })
    
    output$box_puiss <- renderValueBox({
      valueBox(
        value=locale$box_puiss,
        subtitle=paste0("raccordés au 31 décembre ", obj_page$millesime), 
        color="blue", icon = icon(obj_page$icone)
      )
    })
    
    output$box_prod <- renderValueBox({
      valueBox(
        value=locale$box_prod,
        subtitle=obj_page$leg_box_prod,
        color="blue", icon = icon(obj_page$icone)
      )
    })
    
 
  })
}
    
## To be copied in the UI
# mod_l1_fil_elec_ui("l1_fil_elec_ui_1")
    
## To be copied in the server
# mod_l1_fil_elec_server("l1_fil_elec_ui_1", r, obj_page)
