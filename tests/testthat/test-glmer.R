context("glmer")

twidlr_fit <- twidlr::glmer(lme4::cbpp, cbind(incidence, size - incidence) ~ period + (1 | herd), family = binomial)
origin_fit <- lme4::glmer(cbind(incidence, size - incidence) ~ period + (1 | herd), lme4::cbpp, family = binomial)

test_that("fit", {
  expect_equal(coef(twidlr_fit), coef(origin_fit))
})

test_that("predict", {
  expect_equal(predict(twidlr_fit), lme4:::predict.merMod(origin_fit))
})
