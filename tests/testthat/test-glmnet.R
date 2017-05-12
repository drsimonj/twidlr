context("glmnet")


test_that("glmnet", {
  d <- datasets::mtcars
  x <- model.matrix(hp ~ ., d)[,-1]
  y <- d$hp

  twidlr_fit <- twidlr::glmnet(d, hp ~ .)
  origin_fit <- glmnet::glmnet(x, y)

  expect_equal(coef(twidlr_fit), coef(origin_fit))
  expect_error(predict(twidlr_fit))
  expect_equal(predict(twidlr_fit, data = d),
               glmnet::predict.glmnet(origin_fit, newx = x))
})

test_that("cv.glmnet", {
  d <- datasets::mtcars
  x <- model.matrix(hp ~ .*., d)[,-1]
  y <- d$hp

  set.seed(170504)
  twidlr_fit <- twidlr::cv.glmnet(d, hp ~ .*.)
  set.seed(170504)
  origin_fit <- glmnet::cv.glmnet(x, y)

  expect_equal(coef(twidlr_fit, s = "lambda.min"), coef(origin_fit, s = "lambda.min"))
  expect_error(predict(twidlr_fit))
  expect_equal(predict(twidlr_fit, data = d, s = "lambda.min"),
               glmnet::predict.cv.glmnet(origin_fit, newx = x, s = "lambda.min"))
})
