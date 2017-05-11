#' data.frame-first formula-second method for \code{\link[xgboost]{xgboost}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[xgboost]{xgboost}}.
#'
#' @seealso \code{\link[xgboost]{xgboost}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' fit <- xgboost(mtcars, hp ~ ., nrounds = 10, save_period = NULL)
#' predict(fit, mtcars)
xgboost <- function(data, formula, ...) {
  check_pkg("xgboost")
  UseMethod("xgboost")
}

#' @export
xgboost.default <- function(data, formula, ...) {
  key_args <- coerce_args(data, formula)
  data     <- key_args$data
  formula  <- key_args$formula

  xy <- model_as_xy(data, formula)
  object <- xgboost::xgboost(data = xy$x, label = xy$y, ...)
  attr(object, "formula") <- formula # For predict
  object
}

#' @rdname xgboost
#' @export
#' @export predict.xgb.Booster
predict.xgb.Booster <- function(object, data, ...) {
  data <- predict_checks(data = data, ...)
  data <- model_as_xy(data, attr(object, "formula"))$x
  xgboost:::predict.xgb.Booster(object, newdata = data, ...)
}
