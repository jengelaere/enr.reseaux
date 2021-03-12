test_that("tab_inst_biogaz fonctionne", {
  obj <- tab_inst_biogaz("49")
  expect_equal(class(obj), "data.frame")
})
