context("glmnet")

twidlr_fit <- twidlr::glmnet(mtcars, hp ~ .)
origin_fit <- glmnet::glmnet(model.matrix(hp ~ ., mtcars), mtcars$hp)

test_that("fit", {
  expect_equal(twidlr_fit$lambda, origin_fit$lambda)
})

test_that("predict", {
  expect_equal(predict(twidlr_fit, data = mtcars),
               predict(origin_fit, newx = model.matrix(hp ~ ., mtcars)))
})
