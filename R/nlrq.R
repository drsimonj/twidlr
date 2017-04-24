#' data.frame-first formula-second method for \code{\link[quantreg]{nlrq}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[quantreg]{nlrq}}.
#'
#' @seealso \code{\link[quantreg]{nlrq}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' Dat <- NULL
#' Dat$x <- rep(1:25, 20)
#' set.seed(1)
#' Dat$y <- SSlogis(Dat$x, 10, 12, 2) * rnorm(500, 1, 0.1)
#'
#' fit <- nlrq(data = Dat,formula = y ~ SSlogis(x, Asym, mid, scal),tau = 0.5)
#' summary(fit)
#'
#' # Help page for function being twiddled
#' ?quantreg::nlrq
nlrq <- function(data, formula, ...) {
  UseMethod("nlrq")
}

#' @export
nlrq.default <- function(data, formula, ...) {
  nlrq.data.frame(as.data.frame(data), formula, ...)
}

#' @export
nlrq.data.frame <- function(data, formula, ...) {
  quantreg::nlrq(formula = formula, data = data, ...)
}
