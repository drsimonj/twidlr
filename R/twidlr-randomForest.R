#' data.frame-first formula-second method for \code{\link[randomForest]{randomForest}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[randomForest]{randomForest}}.
#'
#' @seealso \code{\link[randomForest]{randomForest}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' randomForest(mtcars, hp ~ .)
#'
#' # Help page for function being twiddled
#' ?randomForest::randomForest
randomForest <- function(data, formula, ...) {
  check_pkg("randomForest")
  UseMethod("randomForest")
}

#' @export
randomForest.default <- function(data, formula, ...) {
  key_args <- coerce_args(data, formula)
  data     <- key_args$data
  formula  <- key_args$formula

  randomForest::randomForest(formula = formula, data = data, ...)
}

#' @rdname randomForest
#' @export
#' @export predict.randomForest
predict.randomForest <- function(object, data, ...) {
  data <- predict_checks(data = data, ...)
  randomForest:::predict.randomForest(object, newdata = data, ...)
}

