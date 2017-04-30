context("randomForest")


test_that("randomForest", {
  d <- datasets::mtcars

  set.seed(170501)
  twidlr_fit <- twidlr::randomForest(d, hp ~ .)
  set.seed(170501)
  origin_fit <- randomForest::randomForest(hp ~ ., d)

  expect_equal(twidlr_fit$forest, origin_fit$forest)
  expect_error(predict(twidlr_fit))
  expect_equal(predict(twidlr_fit, data = d), randomForest:::predict.randomForest(origin_fit, newdata = d))
})

