context("crq")

n <- 200
x <-rnorm(n)
y <- 5 + x + rnorm(n)
c <- 4 + x + rnorm(n)
d <- (y > c)
dat <- data.frame(y = y,x = x,c = c,d = d)
rm(x,y,c,d)

twidlr_fit <- twidlr::crq(dat,survival::Surv(pmax(y,c), d, type = "left") ~ x,method = "Portnoy")
origin_fit <- quantreg::crq(survival::Surv(pmax(y,c), d, type = "left") ~ x, data = dat,method = "Portnoy")

test_that("fit", {
  expect_equal(coef(twidlr_fit), coef(origin_fit))
})

test_that("predict", {
  expect_equal(predict(twidlr_fit), predict(origin_fit))
})
