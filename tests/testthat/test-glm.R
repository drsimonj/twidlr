context("glm")

twidlr_fit <- twidlr::glm(mtcars, vs ~ hp + wt, family = binomial())
origin_fit <- stats::glm(vs ~ hp + wt, family = binomial(), mtcars)

test_that("fit", {
  expect_equal(coef(twidlr_fit), coef(origin_fit))
})

test_that("predict", {
  expect_equal(predict(twidlr_fit), predict(origin_fit))
})

