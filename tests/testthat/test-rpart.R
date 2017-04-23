context("rpart")

test_that("== rpart output", {
  expect_equal(twidlr::rpart(mtcars, hp ~ .)$variable.importance,
               rpart::rpart(hp ~ ., mtcars)$variable.importance)
})
