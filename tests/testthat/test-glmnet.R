context("glmnet")


test_that("glmnet", {
  d <- datasets::mtcars
  x <- model.matrix(hp ~ ., mtcars)[,-1]
  y <- mtcars$hp

  twidlr_fit <- twidlr::glmnet(mtcars, hp ~ .)
  origin_fit <- glmnet::glmnet(x, y)

  expect_equal(coef(twidlr_fit), coef(origin_fit))
  expect_error(predict(twidlr_fit))
  expect_equal(predict(twidlr_fit, data = d),
               glmnet::predict.glmnet(origin_fit, newx = x))
})

test_that("cv.glmnet", {
  d <- datasets::mtcars
  x <- model.matrix(hp ~ ., mtcars)[,-1]
  y <- mtcars$hp

  set.seed(170504)
  twidlr_fit <- twidlr::cv.glmnet(mtcars, hp ~ .)
  set.seed(170504)
  origin_fit <- glmnet::cv.glmnet(x, y)

  expect_equal(coef(twidlr_fit, s = "lambda.min"), coef(origin_fit, s = "lambda.min"))
  expect_error(predict(twidlr_fit))
  expect_equal(predict(twidlr_fit, data = d, s = "lambda.min"),
               glmnet::predict.cv.glmnet(origin_fit, newx = x, s = "lambda.min"))
})
