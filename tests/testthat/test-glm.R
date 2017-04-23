context("glm")

test_that("== stats output", {
  expect_equal(stats::coef(twidlr::glm(mtcars, hp ~ .)),
               stats::coef(stats::glm(hp ~ ., mtcars)))
})
