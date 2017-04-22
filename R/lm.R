#' data.frame-first formula-second method of stats::lm
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[stats]{lm}}().
#'
#' @export
lm <- function(data, formula, ...) {
  UseMethod("lm")
}

#' @export
lm.default <- function(data, formula, ...) {
  stop("twidlr::lm() requires the first argument `data` to be a data frame. ",
       "If you are attempting to use lm() normally, use `stats::lm()`")
}

#' @export
lm.data.frame <- function(data, formula, ...) {
  stats::lm(formula = formula, data = data, ...)
}
