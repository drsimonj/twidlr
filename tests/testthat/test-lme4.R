context("lme4")


test_that("lmer", {
  d <- airquality

  twidlr_fit <- twidlr::lmer(d, Ozone ~ Wind + (Wind | Month))
  origin_fit <- lme4::lmer(Ozone ~ Wind + (Wind | Month), d)

  expect_equal(coef(twidlr_fit), coef(origin_fit))
  expect_error(predict(twidlr_fit))
  expect_equal(predict(twidlr_fit, data = d), lme4:::predict.merMod(origin_fit, newdata = d))
})


test_that("glmer", {
  d <- lme4::cbpp

  twidlr_fit <- twidlr::glmer(d, cbind(incidence, size - incidence) ~ period + (1 | herd), family = binomial)
  origin_fit <- lme4::glmer(cbind(incidence, size - incidence) ~ period + (1 | herd), d, family = binomial)

  expect_equal(coef(twidlr_fit), coef(origin_fit))
  expect_error(predict(twidlr_fit))
  expect_equal(predict(twidlr_fit, data = d), lme4:::predict.merMod(origin_fit, newdata = d))
})
