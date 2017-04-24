#' data.frame-first formula-second method for \code{\link[quantreg]{rqss}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[quantreg]{rqss}}.
#'
#' @seealso \code{\link[quantreg]{rqss}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' n <- 200
#' x <- sort(rchisq(n,4))
#' z <- x + rnorm(n)
#" y <- log(x)+ .1*(log(x))^2 + log(x)*rnorm(n)/4 + z
#' dat <- data.frame(y = y,x = x,z = z)
#' rm(x,y,z)
#' fit  <- rqss(dat,y ~ qss(x, constraint= "N") + z,tau = 0.5)
#'
#' # Help page for function being twiddled
#' ?quantreg::rqss
rqss <- function(data, formula, ...) {
  UseMethod("rqss")
}

#' @export
rqss.default <- function(data, formula, ...) {
  rqss.data.frame(as.data.frame(data), formula, ...)
}

#' @export
rqss.data.frame <- function(data, formula, ...) {
  quantreg::rqss(formula = formula, data = data, ...)
}
