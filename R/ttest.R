#' data.frame-first formula-second method for \code{\link[stats]{t.test}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[stats]{t.test}}.
#'
#' @seealso \code{\link[stats]{t.test}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' t.test(iris[1:100,], Petal.Width ~ Species)
#'
#' # Help page for function being twiddled
#' ?stats::t.test
t.test <- function(data, formula, ...) {
  check_pkg("stats")
  message(1)
  UseMethod("ttest")
}

#' @export
ttest.default <- function(data, formula, ...) {
  ttest.data.frame(as.data.frame(data), formula, ...)
}

#' @export
ttest.data.frame <- function(data, formula, ...) {
  stats::t.test(formula, data = data, ...)
}

