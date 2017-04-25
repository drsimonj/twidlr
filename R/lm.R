#' data.frame-first formula-second method for \code{\link[stats]{lm}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[stats]{lm}}.
#'
#' @seealso \code{\link[stats]{lm}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' fit <- lm(mtcars, hp ~ .)
#' summary(fit)
#'
#' # Help page for function being twiddled
#' ?stats::lm
lm <- function(data, formula, ...) {
  check_pkg("stats")
  UseMethod("lm")
}

#' @export
lm.default <- function(data, formula, ...) {
  lm.data.frame(as.data.frame(data), formula, ...)
}

#' @export
lm.data.frame <- function(data, formula, ...) {
  stats::lm(formula = formula, data = data, ...)
}

#' Predict method for twidlr \code{\link{lm}}
#'
#' @inheritParams twidlr_defaults
#'
#' @export
predict.twidlr_lm <- function(object, data, ...) {
  if (hasArg(newx)) {
    stop("twidlr replaces 'newx' with 'data'. Please see examples in ?twidlr")
  }

  if (missing(data)) {
    if (hasArg(type) && list(...)["type"] %in% c("coefficients", "nonzero")) {
      return (NextMethod("predict", object, ...))
    }
    stop ("You need to supply a value for 'data'")
  }

  data <- model_as_xy(data, attr(object, "formula"))$x
  NextMethod("predict", object, newx = data, ...)
}
