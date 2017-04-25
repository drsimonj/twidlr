#' data.frame-first formula-second method for \code{\link[quantreg]{crq}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[quantreg]{crq}}.
#'
#' @seealso \code{\link[quantreg]{crq}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' set.seed(1968)
#' n <- 200
#' x <-rnorm(n)
#' y <- 5 + x + rnorm(n)
#' c <- 4 + x + rnorm(n)
#' d <- (y > c)
#' dat <- data.frame(y = y,x = x,c = c,d = d)
#' rm(x,y,c,d)
#' f2 <- crq(dat,survival::Surv(pmax(y,c), d, type = "left") ~ x,method = "Portnoy")
#'
#' # Help page for function being twiddled
#' ?quantreg::crq
crq <- function(data, formula, ...) {
  check_pkg("quantreg")
  UseMethod("crq")
}

#' @export
crq.default <- function(data, formula, ...) {
  crq.data.frame(as.data.frame(data), formula, ...)
}

#' @export
crq.data.frame <- function(data, formula, ...) {
  quantreg::crq(formula = formula, data = data, ...)
}

#' @export predict.crq
predict.crq <- function(object, data, ...) {
  if (hasArg(newdata)) {
    stop("Please use 'data' instead of 'newdata' when using twidlr")
  }

  quantreg::predict.crq(object, newdata = data, ...)
}
