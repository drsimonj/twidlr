# Silencing masking warnings and loading quantreg to
# ensure that qss() is available. Using quantreg::qss
# in the formula fails.
require(SparseM,warn.conflicts = FALSE,quietly = TRUE)
require(quantreg,warn.conflicts = FALSE,quietly = TRUE)
context("rqss")

n <- 200
x <- sort(rchisq(n,4))
z <- x + rnorm(n)
y <- log(x)+ .1*(log(x))^2 + log(x)*rnorm(n)/4 + z
dat <- data.frame(y = y,x = x,z = z)
rm(x,y,z)

test_that("== quantreg::rqss output", {
  expect_equal(coef(twidlr::rqss(dat,y ~ qss(x,constraint = "N"),tau = 0.5)),
               coef(quantreg::rqss(y ~ qss(x,constraint = "N"),0.5,dat)))
})
