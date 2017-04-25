#' data.frame-first formula-second method for \code{\link[stats]{glm}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[stats]{glm}}.
#'
#' @seealso \code{\link[stats]{glm}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' fit <- glm(mtcars, vs ~ hp + wt, family = binomial())
#' summary(fit)
#'
#' # Help page for function being twiddled
#' ?stats::glm
glm <- function(data, formula, ...) {
  check_pkg("stats")
  UseMethod("glm")
}

#' @export
glm.default <- function(data, formula, ...) {
  glm.data.frame(as.data.frame(data), formula, ...)
}

#' @export
glm.data.frame <- function(data, formula, ...) {
  object <- stats::glm(formula = formula, data = data, ...)
  twiddle(object, "glm")
}


#' \code{\link[stats]{predict.glm}} for twidlr's \code{\link{glm}}
#'
#' @inheritParams twidlr_defaults
#'
#' @export
#'
#' @examples
#' fit <- glm(mtcars, hp ~ .)
#' predict(fit)
#' predict(fit, mtcars[1:5, ])
#' predict(fit, data = mtcars[1:10,])
predict.twidlr_glm <- function(object, data, ...) {
  if (hasArg(newdata)) {
    stop("Please use 'data' instead of 'newdata' when using twidlr")
  }

  stats::predict.glm(object, newdata = data, ...)
}
