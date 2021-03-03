test_that("girafeTEO works", {
  library(ggplot2)
  graph <- girafeTEO(ggplot(mpg, aes(hwy)) + geom_bar(), FALSE)
  testthat::expect_equal(attr(graph, "class"), c("girafe", "htmlwidget"))
  
})
