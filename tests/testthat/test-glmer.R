context("glmer")

test_that("== lme4 output", {
  expect_equal(stats::coef(twidlr::glmer(cbpp, cbind(incidence, size - incidence) ~ period + (1 | herd), family = binomial)),
               stats::coef(lme4::glmer(cbind(incidence, size - incidence) ~ period + (1 | herd),cbpp, family = binomial)))
})
