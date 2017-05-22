
context("gamlss")


test_that("gamlss", {
  d <- datasets::mtcars

  twidlr_fit <- twidlr::gamlss(d, vs ~ hp + wt, family = "BI" )
  origin_fit <- gamlss::gamlss(vs ~ hp + wt, data = d, family = "BI" )

  expect_equal(coef(twidlr_fit), coef(origin_fit))
  expect_error(predict(twidlr_fit))
  expect_equal(predict(twidlr_fit, data = d), gamlss:::predict.gamlss(origin_fit, newdata = d, data = d))
})

