#' data.frame-first formula-second method for \code{\link[quantreg]{rq}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[quantreg]{rq}}.
#'
#' @seealso \code{\link[quantreg]{rq}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' fit <- rq(data = stackloss,formula = stack.loss ~ .,tau = 0.5)
#' summary(fit)
#'
#' fit <- rq(data = stackloss,formula = stack.loss ~ .,tau = c(0.25,0.75))
#' summary(fit)
#'
#' # Help page for function being twiddled
#' ?quantreg::rq
rq <- function(data, formula, ...) {
  check_pkg("quantreg")
  UseMethod("rq")
}

#' @export
rq.default <- function(data, formula, ...) {
  rq.data.frame(as.data.frame(data), formula, ...)
}

#' @export
rq.data.frame <- function(data, formula, ...) {
  quantreg::rq(formula = formula, data = data, ...)
}

#' @rdname rq
#' @export predict.rq
predict.rq <- function(object, data, ...) {
  if (hasArg(newdata)) data <- newdata
  quantreg::predict.rq(object, newdata = data, ...)
}
