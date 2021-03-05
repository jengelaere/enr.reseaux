test_that("girafeTEO_pie fonctionne", {
  library(ggplot2)
  p <- ggplot(mpg, aes(fl, fill=drv)) + geom_bar(position = "fill")
  graph <- girafeTEO_pie(p, "Epci")
  
  testthat::expect_equal(attr(graph, "class"), c("girafe", "htmlwidget"))
})
