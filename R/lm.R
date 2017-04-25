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

#' @rdname lm
#' @export predict.lm
predict.lm <- function(object, data, ...) {
  if (hasArg(newdata)) {
    if (hasArg(data)) {
      message("Only one of 'data' or 'newdata' needs to be provided. Will use 'data'.")
    } else {
      data <- newdata
    }
  }

  stats::predict.lm(object, newdata = data, ...)
}


