#' data.frame-first formula-second method for \code{\link[glmnet]{glmnet}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[glmnet]{glmnet}}().
#'
#' @seealso \code{\link[glmnet]{glmnet}} for source model;
#'   \code{\link{predict.twidlr_glmnet}} for predictions
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' glmnet(mtcars, hp ~ .)
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
  twiddle(object, "glmnet", formula)
}

#' \code{\link[glmnet]{predict.glmnet}} for twidlr's \code{\link{glmnet}}
#'
#' @inheritParams twidlr_defaults
#'
#' @export
#'
#' @examples
#' fit <- glmnet(mtcars, hp ~ .)
#' coef(fit)
#' coef(fit, s = 0.01)
#' predict(fit, mtcars[1:5,], s = .04)
#' predict(fit, data = mtcars)
#' predict(fit, data = mtcars, s = 0.01)
predict.twidlr_glmnet <- function(object, data, ...) {
  if (hasArg(newx)) {
    stop("Please use 'data' instead of 'newx' when using twidlr")
  }

  if (missing(data)) {
    if (hasArg(type) && list(...)["type"] %in% c("coefficients", "nonzero")) {
      return (glmnet::predict.glmnet(object, ...))
    }
    stop ("You need to supply a value for 'data'")
  }

  data <- model_as_xy(data, attr(object, "formula"))$x
  glmnet::predict.glmnet(object, newx = data, ...)
}
