context("xgboost")

test_that("== xgboost output", {
  twidlr_fit <- twidlr::xgboost(mtcars, mpg ~ ., nrounds = 5, verbose = 0)

  data = data.matrix(mtcars[-1])
  label = mtcars[[1]]
  xgboost_fit <- xgboost::xgboost(data = data, label = label, nrounds = 5, verbose = 0)

  expect_equal(
    predict(twidlr_fit,  data),
    predict(xgboost_fit, data)
  )
})
