context("lme4")


test_that("lmer", {
  twidlr_fit <- twidlr::lmer(airquality, Ozone ~ Wind + (Wind | Month))
  origin_fit <- lme4::lmer(Ozone ~ Wind + (Wind | Month), airquality)

  expect_equal(coef(twidlr_fit), coef(origin_fit))
  expect_equal(predict(twidlr_fit), lme4:::predict.merMod(origin_fit))
})


test_that("glmer", {
  twidlr_fit <- twidlr::glmer(lme4::cbpp, cbind(incidence, size - incidence) ~ period + (1 | herd), family = binomial)
  origin_fit <- lme4::glmer(cbind(incidence, size - incidence) ~ period + (1 | herd), lme4::cbpp, family = binomial)

  expect_equal(coef(twidlr_fit), coef(origin_fit))
  expect_equal(predict(twidlr_fit), lme4:::predict.merMod(origin_fit))
})
