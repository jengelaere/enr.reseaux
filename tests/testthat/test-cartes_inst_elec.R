test_that("mes_instal() fonctionne", {
  obj <- mes_instal(fil = "eol", code_ter = "200060010")
  testthat::expect_true(all(c("sf", "data.frame") %in% attr(obj, "class")))
})


test_that("couche_fil() fonctionne", {
  obj <- couche_fil(fil = "eol", code_ter = "200060010", col = 5)
  testthat::expect_true(c("mapview") %in% attr(obj, "class"))
})

test_that("couche_fil() gere les couches vides", {
  obj <- couche_fil(fil = "xxxxx", code_ter = "200060010")
  testthat::expect_null(obj)
})
