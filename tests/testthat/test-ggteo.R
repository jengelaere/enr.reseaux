test_that("ggteo works", {
  library(ggplot2)  
  graph <- ggteo(mpg) + geom_bar(aes(hwy))
  testthat::expect_equal(attr(graph, "class"), c("gg", "ggplot"))
  
})
