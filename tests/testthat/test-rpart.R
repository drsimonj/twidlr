context("rpart")


test_that("rpart", {
  d <- datasets::mtcars

  twidlr_fit <- twidlr::rpart(d, hp ~ .)
  origin_fit <- rpart::rpart(hp ~ ., d)

  expect_equal(twidlr_fit$splits, origin_fit$splits)
  expect_error(predict(twidlr_fit))
  expect_equal(predict(twidlr_fit, data = d), rpart:::predict.rpart(origin_fit, newdata = d))
})
