#' data.frame-first formula-second method for \code{\link[glmnet]{glmnet}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[glmnet]{glmnet}}().
#'
#' @seealso \code{\link[glmnet]{glmnet}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' glmnet(mtcars, hp ~ .)
glmnet <- function(data, formula, ...) {
  check_pkg("glmnet")
  UseMethod("glmnet")
}

#' @export
glmnet.default <- function(data, formula, ...) {
  glmnet.data.frame(as.data.frame(data), formula, ...)
}

#' @export
glmnet.data.frame <- function(data, formula, ...) {
  dat <- model_as_xy(data, formula)
  object <- glmnet::glmnet(x = dat$x, y = dat$y, ...)
  attr(object, "formula") <- formula
  object
}

#' @rdname glmnet
#' @export
predict.glmnet <- function(object, data, ...) {
  data <- predict_checks(data = data, ...)
  data <- model_as_xy(data, attr(object, "formula"))$x
  glmnet::predict.glmnet(object, newx = data, ...)
}

#' data.frame-first formula-second method for \code{\link[glmnet]{cv.glmnet}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[glmnet]{cv.glmnet}}().
#'
#' @seealso \code{\link[glmnet]{cv.glmnet}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' fit <- cv.glmnet(mtcars, hp ~ .)
#' predict(fit, mtcars, s = "lambda.min")
cv.glmnet <- function(data, formula, ...) {
  check_pkg("glmnet")
  UseMethod("cv.glmnet")
}

#' @export
cv.glmnet.default <- function(data, formula, ...) {
  cv.glmnet.data.frame(as.data.frame(data), formula, ...)
}

#' @export
cv.glmnet.data.frame <- function(data, formula, ...) {
  dat <- model_as_xy(data, formula)
  object <- glmnet::cv.glmnet(x = dat$x, y = dat$y, ...)
  attr(object, "formula") <- formula
  object
}

#' @rdname cv.glmnet
#' @export
predict.cv.glmnet <- function(object, data, ...) {
  data <- predict_checks(data = data, ...)
  data <- model_as_xy(data, attr(object, "formula"))$x
  glmnet::predict.cv.glmnet(object, newx = data, ...)
}

