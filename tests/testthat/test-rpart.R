context("rpart")


test_that("rpart", {
  twidlr_fit <- twidlr::rpart(mtcars, hp ~ .)
  origin_fit <- rpart::rpart(hp ~ ., mtcars)

  expect_equal(twidlr_fit$splits, origin_fit$splits)
  expect_equal(predict(twidlr_fit), rpart:::predict.rpart(origin_fit))
})
