#' data.frame-first formula-second method for \code{\link[randomForest]{randomForest}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[randomForest]{randomForest}}.
#'
#' @seealso \code{\link[randomForest]{randomForest}}
#'
#' @param data Data frame containing the variables in the model
#' @param formula \code{\link[stats]{formula}} describing the model to be fitted
#' @param ... additional arguments to pass to \code{\link[rpart]{rpart}}
#'
#' @export
#'
#' @examples
#' randomForest(mtcars, hp ~ .)
#'
#' # Help page for function being twiddled
#' ?randomForest::randomForest
randomForest <- function(data, formula, ...) {
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
