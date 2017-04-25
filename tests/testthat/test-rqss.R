# context("rqss")
#
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
# test_that("fit", {
#   expect_equal(coef(twidlr_fit), coef(origin_fit))
# })
#
# test_that("predict", {
#   expect_equal(predict(twidlr_fit), quantreg::predict.rqss(origin_fit))
# })
# predict(twidlr_fit)
