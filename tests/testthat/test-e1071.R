context("e1071")

test_that("svm", {
  d <- datasets::mtcars

  # Unsupervised model
  twidlr_fit <- twidlr::svm(d)
  origin_fit <- e1071::svm(~., d)

  expect_equal(twidlr_fit$gamma, origin_fit$gamma)
  expect_error(predict(twidlr_fit))
  expect_equal(predict(twidlr_fit, data = d),
               e1071:::predict.svm(origin_fit, newdata = d))

  # Supervised model
  d$am <- factor(d$am)
  twidlr_fit <- twidlr::svm(d, am ~ .)
  origin_fit <- e1071::svm(am ~ ., d)

  expect_equal(twidlr_fit$gamma, origin_fit$gamma)
  expect_error(predict(twidlr_fit))
  expect_equal(predict(twidlr_fit, data = d),
               e1071:::predict.svm(origin_fit, newdata = d))
})


test_that("naiveBayes", {
  
  d <- datasets::mtcars
  d$cyl_gr_6 <- as.factor( ifelse(d$cyl > 6, 1, 0) )
  
  twidlr_fit <- twidlr::naiveBayes(d, cyl_gr_6 ~ .)
  origin_fit <- e1071::naiveBayes(cyl_gr_6 ~ ., d)
  
  expect_equal(twidlr_fit$tables, origin_fit$tables)
  expect_error(predict(twidlr_fit))
  expect_equal(predict(twidlr_fit, data = d), e1071:::predict.naiveBayes(origin_fit, newdata = d))
})
