test_that("pie_gaz works", {
  
  r <- list(liste_ter = dplyr::filter(liste_zone_complete, CodeZone %in% c("49", "52")),
            maille_terr = "Epci")
  graph <- pie_gaz(r = r , indic = "capaci", unite = " GWh/an", fct_unite = 1)
  
  testthat::expect_equal(attr(graph, "class"), c("girafe", "htmlwidget"))
  
})
