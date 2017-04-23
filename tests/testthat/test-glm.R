context("glm")

test_that("== stats output", {
  expect_equal(stats::coef(twidlr::glm(mtcars, vs ~ hp + wt, family = binomial())),
               stats::coef(stats::glm(vs ~ hp + wt, family = binomial(), mtcars)))
})



