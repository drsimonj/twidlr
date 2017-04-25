context("nlrq")

Dat <- NULL
Dat$x <- rep(1:25, 20)
set.seed(1)
Dat$y <- SSlogis(Dat$x, 10, 12, 2) * rnorm(500, 1, 0.1)

twidlr_fit <- twidlr::nlrq(Dat,y ~ SSlogis(x, Asym, mid, scal))
origin_fit <- quantreg::nlrq(y ~ SSlogis(x, Asym, mid, scal),Dat)

test_that("fit", {
  expect_equal(coef(twidlr_fit), coef(origin_fit))
})

test_that("predict", {
  expect_equal(predict(twidlr_fit), quantreg::predict.nlrq(origin_fit))
})
