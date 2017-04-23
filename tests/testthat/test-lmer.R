context("lmer")

test_that("== lme4 output", {
  expect_equal(stats::coef(twidlr::lmer(airquality, Ozone ~ Wind + (Wind | Month))),
               stats::coef(lme4::lmer(Ozone ~ Wind + (Wind | Month), airquality)))
})
