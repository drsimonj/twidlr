context("glmnet")

twidlr_fit <- twidlr::glmnet(mtcars, hp ~ .)
stats_fit  <- glmnet::glmnet(model.matrix(hp ~ ., mtcars), mtcars$hp)

test_that("fit", {
  expect_equal(twidlr_fit$lambda, stats_fit$lambda)
})

test_that("predict", {
  expect_equal(predict(twidlr_fit, data = mtcars),
               predict(stats_fit, newx = model.matrix(hp ~ ., mtcars)))
})
