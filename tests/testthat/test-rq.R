context("rq")

twidlr_fit <- twidlr::rq(mtcars, hp ~ mpg + cyl)
origin_fit <- quantreg::rq(hp ~ mpg + cyl,tau = 0.5,mtcars)

test_that("fit", {
  expect_equal(coef(twidlr_fit), coef(origin_fit))
})

test_that("predict", {
  expect_equal(predict(twidlr_fit), quantreg::predict.rq(origin_fit))
})
