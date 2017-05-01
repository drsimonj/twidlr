context("stats")

test_that("t.test", {
  twidlr_fit <- twidlr::t.test(mtcars, hp ~ am)
  stats_fit  <- stats::t.test(hp ~ am, mtcars)

  expect_equal(twidlr_fit$statistic, stats_fit$statistic)
  expect_equal(twidlr_fit$estimate, stats_fit$estimate)
})


test_that("lm", {
  d <- datasets::mtcars

  twidlr_fit <- twidlr::lm(d, hp ~ .)
  origin_fit <- stats::lm(hp ~ ., d)

  expect_equal(coef(twidlr_fit), coef(origin_fit))
  expect_error(predict(twidlr_fit))
  expect_equal(predict(twidlr_fit, data = d), stats::predict.lm(origin_fit, newdata = d))
})

test_that("extra checks for predict()", {
  d <- datasets::mtcars

  twidlr_fit <- twidlr::lm(d, hp ~ .)

  expect_error(predict(twidlr_fit))
  expect_length(predict(twidlr_fit, data = as.matrix(d)), nrow(d))
  expect_error(predict(twidlr_fit, data = d, newdata = 10))
})

test_that("glm", {
  d <- datasets::mtcars

  twidlr_fit <- twidlr::glm(d, vs ~ hp + wt, family = binomial())
  origin_fit <- stats::glm(vs ~ hp + wt, family = binomial(), d)

  expect_equal(coef(twidlr_fit), coef(origin_fit))
  expect_error(predict(twidlr_fit))
  expect_equal(predict(twidlr_fit, data = d), stats::predict.glm(origin_fit, newdata = d))
})


test_that("kmeans", {
  expect_equal(names(twidlr::kmeans(mtcars, ~ ., centers = 3)$cluster),
               names(stats::kmeans(mtcars, centers = 3)$cluster))
})
