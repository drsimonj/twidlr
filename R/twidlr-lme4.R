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
  check_pkg("lme4")
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

#' @rdname lmer
#' @export predict.merMod
predict.merMod <- function(object, data, ...) {
  if (hasArg(newdata)) stop("Please specify 'data' instead of 'newdata'")
  if (missing(data)) return (lme4:::predict.merMod(object, ...))
  lme4:::predict.merMod(object, newdata = data, ...)
}


#' data.frame-first formula-second method for \code{\link[lme4]{glmer}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[lme4]{glmer}}
#'
#' @seealso \code{\link[lme4]{glmer}}
#'
#' @param data frame containing the variables in the model
#' @inheritParams lme4::lmer
#' @param ... Additional arguments to pass to model function
#' @export
#'
#' @examples
#' fit <- glmer(lme4::cbpp, cbind(incidence, size - incidence) ~ period + (1 | herd), family = binomial)
#' summary(fit)
#'
#' # Help page for function being twiddled
#' ?lme4::glmer
#'
glmer <- function(data, formula, ...) {
  check_pkg("lme4")
  UseMethod("glmer")
}

#' @export
glmer.default <- function(data, formula, ...) {
  glmer.data.frame(as.data.frame(data), formula, ...)
}

#' @export
glmer.data.frame <- function(data, formula, ...) {
  lme4::glmer(formula = formula, data = data, ...)
}
