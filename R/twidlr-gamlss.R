


#' data.frame-first formula-second method for \code{\link[gamlss]{gamlss}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[gamlss]{gamlss}}.
#'
#' @seealso \code{\link[gamlss]{gamlss}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' fit <- gamlss(mtcars, vs ~ hp + wt, family = BI())
#' summary(fit)
#' predict(fit, mtcars[1:5,])
#'

gamlss <- function(data, formula, ...) {
  check_pkg("gamlss")
  UseMethod("gamlss")
}

#' @export
gamlss.default <- function(data, formula, ...) {

  key_args <- coerce_args(data, formula)
  data     <- key_args$data
  formula  <- key_args$formula

  fit = gamlss::gamlss(formula = formula, data = data, ...)

  fit$data = data

  return(fit)
}

#' @rdname gamlss
#' @export
#' @export predict.gamlss
predict.gamlss <- function(object, data, ...) {

  data <- predict_checks(data = data, ...)

  gamlss:::predict.gamlss(object, newdata = data, data = object$data, ...)
}

