test_that("graph_evol works", {
  liste_ter <- dplyr::filter(liste_zone_complete, CodeZone %in% c("200060010", "49", "52"))
  graph <- graph_evol(fil = "Eol", indic = "Puissance", liste_ter)
  testthat::expect_equal(attr(graph, "class"), c("gg", "ggplot" ))
})
