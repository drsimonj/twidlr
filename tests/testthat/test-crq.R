context("crq")

set.seed(1968)
n <- 200
x <-rnorm(n)
y <- 5 + x + rnorm(n)
c <- 4 + x + rnorm(n)
d <- (y > c)
dat <- data.frame(y = y,x = x,c = c,d = d)
rm(x,y,c,d)

test_that("== quantreg::rqss output", {
  expect_equal(coef(twidlr::crq(dat,survival::Surv(pmax(y,c), d, type = "left") ~ x,method = "Portnoy")),
               coef(quantreg::crq(survival::Surv(pmax(y,c), d, type = "left") ~ x, data = dat,method = "Portnoy")))
})
