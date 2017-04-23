#' data.frame-first formula-second method for \code{\link[rpart]{rpart}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[rpart]{rpart}}.
#'
#' @seealso \code{\link[rpart]{rpart}}
#'
#' @param data Data frame containing the variables in the model
#' @param formula A \code{\link[stats]{formula}} with a response but no
#'   interaction terms
#' @param ... additional arguments to pass to \code{\link[rpart]{rpart}}
#'
#' @export
#'
#' @examples
#' fit <- rpart(mtcars, hp ~ .)
#' summary(fit)
#'
#' # Help page for function being twiddled
#' ?rpart::rpart
rpart <- function(data, formula, ...) {
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
