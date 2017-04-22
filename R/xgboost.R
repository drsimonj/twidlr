#' data.frame-first formula-second method for xgboost::xgboost
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[xgboost]{xgboost}}().
#'
#' @seealso \code{\link[xgboost]{xgboost}}
#'
#' @param data Data frame containing the variables in the model.
#' @param formula A formula of the form \code{label ~ feature_1 + feature_2 +
#'   ... + feature_i}
#' @param ... additional arguments to pass to \code{\link[xgboost]{xgboost}}()
#'
#' @export
#'
#' @examples
#' xgboost(mtcars, hp ~ ., nrounds = 10)
xgboost <- function(data, formula, ...) {
  UseMethod("xgboost")
}

#' @export
xgboost.default <- function(data, formula, ...) {
  xgboost.data.frame(as.data.frame(data), formula, ...)
}

#' @export
xgboost.data.frame <- function(data, formula, ...) {
  dat <- unpack_data(data, formula)
  xgboost::xgboost(data = dat$X, label = dat$y, ...)
}
