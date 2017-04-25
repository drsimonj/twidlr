#' data.frame-first formula-second method for \code{\link[glmnet]{glmnet}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[glmnet]{glmnet}}().
#'
#' @seealso \code{\link[glmnet]{glmnet}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' glmnet(mtcars, hp ~ .)
#'
#' # Help page for function being twiddled
#' ?glmnet::glmnet
glmnet <- function(data, formula, ...) {
  check_pkg("glmnet")
  UseMethod("glmnet")
}

#' @export
glmnet.default <- function(data, formula, ...) {
  glmnet.data.frame(as.data.frame(data), formula, ...)
}

#' @export
glmnet.data.frame <- function(data, formula, ...) {
  dat <- model_as_xy(data, formula)
  object <- glmnet::glmnet(x = dat$x, y = dat$y, ...)

  # Set up for custom predict function
  class(object) <- c("twidlr_glmnet", class(fit))
  attr(object, "formula") <- formula
  fit
}

#' twildr compatible predict for \code{\link[glmnet]{glmnet}}
#'
#' @export
predict.twidlr_glmnet <- function(object, data, ...) {
  if (hasArg(newx)) {
    stop("twidlr replaces 'newx' with 'data'. Please see examples in ?twidlr")
  }

  if (missing(data)) {
    if (hasArg(type) && list(...)["type"] %in% c("coefficients", "nonzero")) {
      return (NextMethod("predict", object, ...))
    }
    stop ("You need to supply a value for 'data'")
  }

  data <- model_as_xy(data, attr(object, "formula"))$x
  NextMethod("predict", object, newx = data, ...)
}
