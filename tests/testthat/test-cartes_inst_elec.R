test_that("mes_instal() fonctionne", {
  obj <- mes_instal(fil = "pvq", code_ter = "52")
  testthat::expect_true(all(c("sf", "data.frame") %in% attr(obj, "class")))
})


test_that("couche_fil() fonctionne", {
  obj <- couche_fil(fil = "pvq", code_ter = "200067635", col = 6)
  testthat::expect_true(c("mapview") %in% attr(obj, "class"))
})

test_that("couche_fil() gere les couches vides", {
  obj <- couche_fil(fil = "xxxxx", code_ter = "52")
  testthat::expect_null(obj)
})
