#' data.frame-first formula-second method for \code{\link[glmnet]{glmnet}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[glmnet]{glmnet}}().
#'
#' @seealso \code{\link[glmnet]{glmnet}}
#'
#' @param data Data frame containing the variables in the model.
#' @param formula A formula of the form \code{y ~ x1 + x2 + ... + xi}
#' @param ... additional arguments to pass to \code{\link[glmnet]{glmnet}}()
#'
#' @export
#'
#' @examples
#' glmnet(mtcars, hp ~ .)
#'
#' # Help page for function being twiddled
#' ?glmnet::glmnet
glmnet <- function(data, formula, ...) {
  UseMethod("glmnet")
}

#' @export
glmnet.default <- function(data, formula, ...) {
  glmnet.data.frame(as.data.frame(data), formula, ...)
}

#' @export
glmnet.data.frame <- function(data, formula, ...) {
  dat <- model_as_xy(data, formula)
  glmnet::glmnet(x = dat$x, y = dat$y, ...)
}
