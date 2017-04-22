#' data.frame-first formula-second method for glmnet::glmnet
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[glmnet]{glmnet}}().
#'
#' @seealso \code{\link[glmnet]{glmnet}}
#'
#' @param data Data frame containing the variables in the model.
#' @param formula A formula of the form \code{label ~ feature_1 + feature_2 +
#'   ... + feature_i}
#' @param ... additional arguments to pass to \code{\link[glmnet]{glmnet}}()
#'
#' @export
#'
#' @examples
#' glmnet(mtcars, hp ~ .)
glmnet <- function(data, formula, ...) {
  UseMethod("glmnet")
}

#' @export
glmnet.default <- function(data, formula, ...) {
  glmnet.data.frame(as.data.frame(data), formula, ...)
}

#' @export
glmnet.data.frame <- function(data, formula, ...) {
  dat <- unpack_data(data, formula)
  glmnet::glmnet(x = dat$X, y = dat$y, ...)
}
