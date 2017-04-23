context("randomForest")

test_that("== randomForest output", {
  expect_equal(twidlr::randomForest(mtcars, hp ~ .)$terms,
               randomForest::randomForest(hp ~ ., mtcars)$terms)
})
