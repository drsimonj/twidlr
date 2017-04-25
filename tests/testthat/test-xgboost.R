context("xgboost")

twidlr_fit <- twidlr::xgboost(mtcars, mpg ~ .*., nrounds = 20, verbose = 0, save_period = NULL)

xs  <- model.matrix(mpg ~ .*., mtcars)
y <- mtcars$mpg
origin_fit <- xgboost::xgboost(data = xs, label = y, nrounds = 20, verbose = 0, save_period = NULL)

test_that("fit", {
  expect_equal(twidlr_fit$evaluation_log, origin_fit$evaluation_log)
})

test_that("predict", {
  expect_equal(predict(twidlr_fit, data = mtcars),
               xgboost:::predict.xgb.Booster(origin_fit, newdata = xs))
})
