context("lm")

twidlr_fit <- twidlr::lm(mtcars, hp ~ .)
origin_fit <- stats::lm(hp ~ ., mtcars)

test_that("fit", {
  expect_equal(coef(twidlr_fit), coef(origin_fit))
})

test_that("predict", {
  expect_equal(predict(twidlr_fit), stats::predict.lm(origin_fit))
})
