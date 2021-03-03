test_that("couche_typ_gaz() fonctionne", {
  obj <- couche_typ_gaz(typ = "Territ", code_ter = "52", col = 5)
  testthat::expect_true(c("mapview") %in% attr(obj, "class"))
})

test_that("couche_typ_gaz() gere les couches vides", {
  obj <- couche_typ_gaz(typ = "xxxxx", code_ter = "200060010")
  testthat::expect_null(obj)
})
