context("glmnet")


test_that("glmnet", {
  twidlr_fit <- twidlr::glmnet(mtcars, hp ~ .)
  origin_fit <- glmnet::glmnet(model.matrix(hp ~ ., mtcars), mtcars$hp)

  expect_equal(twidlr_fit$lambda, origin_fit$lambda)
  expect_equal(predict(twidlr_fit, data = mtcars),
               glmnet::predict.glmnet(origin_fit, newx = model.matrix(hp ~ ., mtcars)))
})
