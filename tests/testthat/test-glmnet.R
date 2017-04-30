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
