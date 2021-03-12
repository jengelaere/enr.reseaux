r <- list(
  carte_PV = enr.reseaux::couche_fil("pvq", enr.reseaux::reg, 6),
  carte_hydro = enr.reseaux::couche_fil("hydro", enr.reseaux::reg, 3),
  carte_metha = enr.reseaux::couche_fil("metha", enr.reseaux::reg, 4)
)

test_that("get_carto works", {
 obj <- get_carto(list = r, "carte_PV")
 expect_true(grepl("mapview", class(obj)))
  
})

test_that("compose_carto works", {
  obj <- compose_carto(list = r, couches = c("carte_PV", "carte_hydro"))
  expect_true(grepl("mapview", class(obj)))
  
})
