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
  object <- stats::lm(formula = formula, data = data, ...)
  twiddle(object, "lm")
}

#' \code{\link[stats]{predict.lm}} for twidlr's \code{\link{lm}}
#'
#' @inheritParams twidlr_defaults
#'
#' @export
#'
#' @examples
#' fit <- lm(mtcars, hp ~ .)
#' predict(fit)
#' predict(fit, mtcars[1:5, ])
#' predict(fit, data = mtcars[1:10,])
predict.twidlr_lm <- function(object, data, ...) {
  if (hasArg(newdata)) {
    stop("Please use 'data' instead of 'newdata' when using twidlr")
  }

  stats::predict.lm(object, newdata = data, ...)
}


