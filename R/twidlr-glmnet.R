#' data.frame-first formula-second method for \code{\link[glmnet]{glmnet}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[glmnet]{glmnet}}().
#'
#' @seealso \code{\link[glmnet]{glmnet}} for source model;
#'   \code{\link{predict.twidlr_glmnet}} for predictions
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
#' @export predict.glmnet
predict.glmnet <- function(object, data, ...) {
  data <- predict_checks(data = data, ...)
  data <- model_as_xy(data, attr(object, "formula"))$x
  glmnet::predict.glmnet(object, newx = data, ...)
}
