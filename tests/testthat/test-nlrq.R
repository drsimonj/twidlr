context("nlrq")

Dat <- NULL
Dat$x <- rep(1:25, 20)
set.seed(1)
Dat$y <- SSlogis(Dat$x, 10, 12, 2) * rnorm(500, 1, 0.1)

test_that("== quantreg::nlrq output", {
  expect_equal(coef(twidlr::nlrq(Dat,y ~ SSlogis(x, Asym, mid, scal))),
               coef(quantreg::nlrq(y ~ SSlogis(x, Asym, mid, scal),Dat)))
})
