#' data.frame-first formula-second method for \code{\link[lme4]{lmer}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[lme4]{lmer}}
#'
#' @seealso \code{\link[lme4]{lmer}}
#'
#' @inheritParams twidlr_defaults
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
#' @export
#' @export predict.merMod
predict.merMod <- function(object, data, ...) {
  data <- predict_checks(data = data, ...)
  lme4:::predict.merMod(object, newdata = data, ...)
}


#' data.frame-first formula-second method for \code{\link[lme4]{glmer}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[lme4]{glmer}}
#'
#' @seealso \code{\link[lme4]{glmer}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' fit <- glmer(lme4::cbpp,
#'   cbind(incidence, size - incidence) ~ period + (1 | herd),
#'   family = binomial)
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
