context("rpart")

twidlr_fit <- twidlr::rpart(mtcars, hp ~ .)
origin_fit <- rpart::rpart(hp ~ ., mtcars)

test_that("fit", {
  expect_equal(twidlr_fit$splits, origin_fit$splits)
})

test_that("predict", {
  expect_equal(predict(twidlr_fit), rpart:::predict.rpart(origin_fit))
})
