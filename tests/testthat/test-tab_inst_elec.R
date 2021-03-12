test_that("tab_inst_elec fonctionne", {
  obj <- tab_inst_elec("49")
  expect_equal(class(obj), "data.frame")
})
