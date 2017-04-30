context("xgboost")

test_that("xgboost", {
  d <- datasets::mtcars
  x <- model.matrix(am ~ ., d)[,-1]
  y <- mtcars$am

  twidlr_fit <- twidlr::xgboost(d, am ~ ., nrounds = 5, verbose = 0, save_period = NULL)
  origin_fit <- xgboost::xgboost(data = x, label = y, nrounds = 5, verbose = 0, save_period = NULL)

  expect_equal(twidlr_fit$raw, origin_fit$raw)
  expect_error(predict(twidlr_fit))
  expect_equal(predict(twidlr_fit, data = d),
               xgboost:::predict.xgb.Booster(origin_fit, newdata = x))
})
