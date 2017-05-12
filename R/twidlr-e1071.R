#' data.frame-first formula-second method for \code{\link[e1071]{svm}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[e1071]{svm}}.
#'
#' @seealso \code{\link[e1071]{svm}}
#'
#' @inheritParams twidlr_defaults
#' @formula \code{\link[stats]{formula}} (or object that can be coerced to one)
#'   describing the model to be fitted. If one-sided, density-estimation is
#'   carried out. If omitted, density-estimation is done on all variables in
#'   `data`.
#' @export
#'
svm <- function(data, formula = ~., ...) {
  check_pkg("e1071")
  UseMethod("svm")
}

#' @export
svm.default <- function(data, formula = ~., ...) {
  key_args <- coerce_args(data, formula)
  data     <- key_args$data
  formula  <- key_args$formula

  e1071:::svm.formula(formula = formula, data = data, ...)
}

#' @rdname svm
#' @export
#' @export predict.svm
predict.svm <- function(object, data, ...) {
  data <- predict_checks(data = data, ...)
  e1071:::predict.svm(object, newdata = data, ...)
}
