#' data.frame-first formula-second method for \code{\link[rpart]{rpart}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[rpart]{rpart}}.
#'
#' @seealso \code{\link[rpart]{rpart}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' rpart(mtcars, hp ~ .)
#'
#' # Help page for function being twiddled
#' ?rpart::rpart
rpart <- function(data, formula, ...) {
  check_pkg("rpart")
  UseMethod("rpart")
}

#' @export
rpart.default <- function(data, formula, ...) {
  rpart.data.frame(as.data.frame(data), formula, ...)
}

#' @export
rpart.data.frame <- function(data, formula, ...) {
  rpart::rpart(formula = formula, data = data, ...)
}

#' @rdname rpart
#' @export predict.rpart
predict.rpart <- function(object, data, ...) {
  check_alt_data(...)
  rpart:::predict.rpart(object, newdata = data, ...)
}
