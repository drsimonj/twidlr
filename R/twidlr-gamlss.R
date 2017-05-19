


#' data.frame-first formula-second method for \code{\link[gamlss]{gamlss}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[gamlss]{gamlss}}.
#'
#'This function attaches the training data to the generated model,
#'because the default gamlss.predict() function requires access to
#'the original data in order to make predictions. Please be aware
#'that memory issues can arise when working with large data sets and
#'or when generating a large number of models.
#'
#' @seealso \code{\link[gamlss]{gamlss}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' fit <- gamlss(mtcars, vs ~ hp + wt, family = "BI")
#' summary(fit)
#' predict(fit, mtcars)
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

  original_data <- data[, all.vars(formula)]

  fit = gamlss::gamlss(formula = formula, data = original_data, ...)

  attr(fit, "original_data") <- original_data

  return(fit)
}

#' @rdname gamlss
#' @export
#' @export predict.gamlss
predict.gamlss <- function(object, data, ...) {

  data <- predict_checks(data = data, ...)

  original_data = attr(object, "original_data")

  adapted_data = data[, names(data) %in% names(original_data) ]

  gamlss:::predict.gamlss(object, newdata = adapted_data, data = original_data, ...)
}

