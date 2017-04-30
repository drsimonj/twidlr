context("quantreg")


test_that("crq", {
  n <- 200
  x <-rnorm(n)
  y <- 5 + x + rnorm(n)
  c <- 4 + x + rnorm(n)
  d <- (y > c)
  dat <- data.frame(y = y,x = x,c = c,d = d)
  rm(x,y,c,d)

  twidlr_fit <- twidlr::crq(dat, survival::Surv(pmax(y,c), d, type = "left") ~ x,method = "Portnoy")
  origin_fit <- quantreg::crq(survival::Surv(pmax(y,c), d, type = "left") ~ x, data = dat, method = "Portnoy")

  expect_equal(coef(twidlr_fit), coef(origin_fit))
  expect_error(predict(twidlr_fit))
  expect_equal(predict(twidlr_fit, data = dat), quantreg::predict.crq(origin_fit, newdata = dat))
})


test_that("nlrq", {
  dat <- NULL
  dat$x <- rep(1:25, 20)
  set.seed(1)
  dat$y <- SSlogis(dat$x, 10, 12, 2) * rnorm(500, 1, 0.1)

  twidlr_fit <- twidlr::nlrq(dat, y ~ SSlogis(x, Asym, mid, scal))
  origin_fit <- quantreg::nlrq(y ~ SSlogis(x, Asym, mid, scal), dat)

  expect_equal(coef(twidlr_fit), coef(origin_fit))
  expect_error(predict(twidlr))
  expect_equal(predict(twidlr_fit, data = dat), quantreg::predict.nlrq(origin_fit, newdata = dat))
})


test_that("rq", {
  d <- datasets::mtcars

  twidlr_fit <- twidlr::rq(d, hp ~ mpg + cyl, tau = 0.4)
  origin_fit <- quantreg::rq(hp ~ mpg + cyl, tau = 0.4, d)

  expect_equal(coef(twidlr_fit), coef(origin_fit))
  expect_error(predict(twidlr_fit))
  expect_equal(predict(twidlr_fit, data = d), quantreg::predict.rq(origin_fit, newdata = d))
})


# test_that("rqss", {
  # # Silencing masking warnings and loading quantreg to
  # # ensure that qss() is available. Using quantreg::qss
  # # in the formula fails.
  # require(SparseM, warn.conflicts = FALSE, quietly = TRUE)
  # require(quantreg, warn.conflicts = FALSE, quietly = TRUE)
  #
  # n <- 200
  # x <- sort(rchisq(n,4))
  # z <- x + rnorm(n)
  # y <- log(x)+ .1*(log(x))^2 + log(x)*rnorm(n)/4 + z
  # dat <- data.frame(y = y,x = x,z = z)
  # rm(x,y,z)
  #
  # twidlr_fit <- twidlr::rqss(dat,y ~ qss(x,constraint = "N"),tau = 0.5)
  # origin_fit <- quantreg::rqss(y ~ qss(x,constraint = "N"),0.5,dat)
  #
#   expect_equal(coef(twidlr_fit), coef(origin_fit))
#   expect_equal(predict(twidlr_fit), quantreg::predict.rqss(origin_fit))
# })
