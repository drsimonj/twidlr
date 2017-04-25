context("lm")

twidlr_fit <- twidlr::lm(mtcars, hp ~ .)
stats_fit  <- stats::lm(hp ~ ., mtcars)

test_that("fit", {
  expect_equal(coef(twidlr_fit), coef(stats_fit))
})

test_that("predict", {
  expect_equal(predict(twidlr_fit), predict(stats_fit))
})
