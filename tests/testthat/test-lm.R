context("lm")

test_that("== stats output", {
  expect_equal(stats::coef(twidlr::lm(mtcars, hp ~ .)),
               stats::coef(stats::lm(hp ~ ., mtcars)))
})
