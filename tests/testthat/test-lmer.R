context("lmer")

twidlr_fit <- twidlr::lmer(airquality, Ozone ~ Wind + (Wind | Month))
origin_fit <- lme4::lmer(Ozone ~ Wind + (Wind | Month), airquality)

test_that("fit", {
  expect_equal(coef(twidlr_fit), coef(origin_fit))
})

test_that("predict", {
  expect_equal(predict(twidlr_fit), lme4:::predict.merMod(origin_fit))
})
