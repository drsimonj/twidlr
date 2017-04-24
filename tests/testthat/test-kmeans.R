context("kmeans")

test_that("== stats output", {
  expect_equal(names(twidlr::kmeans(mtcars, ~ ., centers = 3)$cluster),
               names(stats::kmeans(mtcars, centers = 3)$cluster))
})
