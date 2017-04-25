context("glmer")

test_that("== lme4 output", {
  expect_equal(stats::coef(twidlr::glmer(lme4::cbpp, cbind(incidence, size - incidence) ~ period + (1 | herd), family = binomial)),
               stats::coef(lme4::glmer(cbind(incidence, size - incidence) ~ period + (1 | herd), lme4::cbpp, family = binomial)))
})
