context("rq")

test_that("== quantreg output", {
  expect_equal(coef(twidlr::rq(mtcars, hp ~ mpg + cyl)),
               coef(quantreg::rq(hp ~ mpg + cyl, data = mtcars)))
})

test_that("== quantreg output", {
  expect_equal(coef(twidlr::rq(mtcars, hp ~ mpg + cyl,tau = c(0.25,0.75))),
               coef(quantreg::rq(hp ~ mpg + cyl,tau = c(0.25,0.75),data = mtcars)))
})
