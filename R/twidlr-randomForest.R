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
  randomForest.data.frame(as.data.frame(data), formula, ...)
}

#' @export
randomForest.data.frame <- function(data, formula, ...) {
  randomForest::randomForest(formula = formula, data = data, ...)
}

#' @rdname randomForest
#' @export
predict.randomForest <- function(object, data, ...) {
  data <- predict_checks(data = data, ...)
  randomForest:::predict.randomForest(object, newdata = data, ...)
}
