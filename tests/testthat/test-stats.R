context("stats")


test_that("t.test", {
  twidlr_fit <- twidlr::t.test(mtcars, hp ~ am)
  stats_fit  <- stats::t.test(hp ~ am, mtcars)

  expect_equal(twidlr_fit$statistic, stats_fit$statistic)
  expect_equal(twidlr_fit$estimate, stats_fit$estimate)
})


test_that("lm", {
  twidlr_fit <- twidlr::lm(mtcars, hp ~ .)
  origin_fit <- stats::lm(hp ~ ., mtcars)

  expect_equal(coef(twidlr_fit), coef(origin_fit))
  expect_equal(predict(twidlr_fit), stats::predict.lm(origin_fit))
})


test_that("glm", {
  twidlr_fit <- twidlr::glm(mtcars, vs ~ hp + wt, family = binomial())
  origin_fit <- stats::glm(vs ~ hp + wt, family = binomial(), mtcars)

  expect_equal(coef(twidlr_fit), coef(origin_fit))
  expect_equal(predict(twidlr_fit), predict(origin_fit))
})


test_that("kmeans", {
  expect_equal(names(twidlr::kmeans(mtcars, ~ ., centers = 3)$cluster),
               names(stats::kmeans(mtcars, centers = 3)$cluster))
})
