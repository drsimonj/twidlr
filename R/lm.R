#' data.frame-first formula-second method for \code{\link[stats]{lm}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[stats]{lm}}.
#'
#' @seealso \code{\link[stats]{lm}}
#'
#' @param data Data frame containing the variables in the model.
#' @inheritParams stats::lm
#' @param ... additional arguments to pass to \code{\link[stats]{lm}}
#'
#' @export
#'
#' @examples
#' fit <- lm(mtcars, hp ~ .)
#' summary(fit)
#'
#' # Help page for function being twiddled
#' ?stats::lm
lm <- function(data, formula, ...) {
  UseMethod("lm")
}

#' @export
lm.default <- function(data, formula, ...) {
  #stop("twidlr::lm() requires the first argument `data` to be a data frame. ",
  #     "If you are attempting to use lm() normally, use `stats::lm()`")
  lm.data.frame(as.data.frame(data), formula, ...)
}

#' @export
lm.data.frame <- function(data, formula, ...) {
  stats::lm(formula = formula, data = data, ...)
}
