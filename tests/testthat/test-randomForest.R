context("randomForest")


test_that("randomForest", {
  set.seed(234)
  twidlr_fit <- twidlr::randomForest(mtcars, hp ~ .)
  set.seed(234)
  origin_fit <- randomForest::randomForest(hp ~ ., mtcars)

  expect_equal(twidlr_fit$forest, origin_fit$forest)
  expect_equal(predict(twidlr_fit), randomForest:::predict.randomForest(origin_fit))
})

