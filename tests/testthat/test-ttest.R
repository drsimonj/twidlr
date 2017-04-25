context("ttest")

twidlr_fit <- twidlr::t.test(mtcars, hp ~ am)
stats_fit  <- stats::t.test(hp ~ am, mtcars)

test_that("== stats output", {
  expect_equal(twidlr_fit$statistic, stats_fit$statistic)
  expect_equal(twidlr_fit$estimate, stats_fit$estimate)
})

