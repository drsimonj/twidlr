#' data.frame-first formula-second method for \code{\link[lme4]{lmer}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[lme4]{lmer}}
#'
#' @seealso \code{\link[lme4]{lmer}}
#'
#' @param data frame containing the variables in the model
#' @inheritParams lme4::lmer
#' @param ... Additional arguments to pass to model function
#' @export
#'
#' @examples
#' fit <- lmer(airquality, Ozone ~ Wind + (Wind | Month))
#' summary(fit)
#'
#' # Help page for function being twiddled
#' ?lme4::lmer
lmer <- function(data, formula, ...) {
  UseMethod("lmer")
}

#' @export
lmer.default <- function(data, formula, ...) {
  lmer.data.frame(as.data.frame(data), formula, ...)
}

#' @export
lmer.data.frame <- function(data, formula, ...) {
  lme4::lmer(formula = formula, data = data, ...)
}
