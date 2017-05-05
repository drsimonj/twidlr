context("stats")

test_that("ttest", {
  twidlr_fit <- twidlr::ttest(mtcars, hp ~ am)
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
  d <- datasets::iris[,-5]

  expect_equal(twidlr::kmeans(d, centers = 3)$totss,
               stats::kmeans(d, centers = 3)$totss)

  expect_equal(twidlr::kmeans(d, ~ Sepal.Length + Sepal.Width, centers = 3)$totss,
               stats::kmeans(d[c("Sepal.Length", "Sepal.Width")], centers = 3)$totss)


  set.seed(170501)
  twidlr_fit <- twidlr::kmeans(d, centers = 3)
  set.seed(170501)
  origin_fit <- stats::kmeans(d, centers = 3)

  expect_true(all(predict(twidlr_fit, d) == origin_fit$cluster))
})

test_that("prcomp", {
  d <- datasets::mtcars

  expect_equal(twidlr::prcomp(d)$rotation,
               stats::prcomp(d)$rotation)

  twidlr_fit <- twidlr::prcomp(d, ~ .*.)
  origin_fit <- stats::prcomp(~.*., d)

  expect_equal(twidlr_fit$rotation, origin_fit$rotation)

  expect_equal(predict(twidlr_fit, d),
               stats:::predict.prcomp(origin_fit, as.data.frame(model.matrix(~.*., d))[-1L]))
})

test_that("aov", {
  d <- datasets::mtcars

  twidlr_fit <- twidlr::aov(d, hp ~ am * vs)
  origin_fit <- stats::lm(hp ~ am * vs, d)

  expect_equal(coef(twidlr_fit), coef(origin_fit))
  expect_error(predict(twidlr_fit))
  expect_equal(predict(twidlr_fit, data = d), stats::predict.lm(origin_fit, newdata = d))
})
