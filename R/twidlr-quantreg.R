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

#' @rdname crq
#' @export predict.crq
predict.crq <- function(object, data, ...) {
  data <- predict_checks(data = data, ...)
  quantreg::predict.crq(object, newdata = data, ...)
}

#' data.frame-first formula-second method for \code{\link[quantreg]{rq}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[quantreg]{rq}}.
#'
#' @seealso \code{\link[quantreg]{rq}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' fit <- rq(data = stackloss,formula = stack.loss ~ .,tau = 0.5)
#' summary(fit)
#'
#' fit <- rq(data = stackloss,formula = stack.loss ~ .,tau = c(0.25,0.75))
#' summary(fit)
#'
#' # Help page for function being twiddled
#' ?quantreg::rq
rq <- function(data, formula, ...) {
  check_pkg("quantreg")
  UseMethod("rq")
}

#' @export
rq.default <- function(data, formula, ...) {
  rq.data.frame(as.data.frame(data), formula, ...)
}

#' @export
rq.data.frame <- function(data, formula, ...) {
  quantreg::rq(formula = formula, data = data, ...)
}

#' @rdname rq
#' @export
predict.rq <- function(object, data, ...) {
  data <- predict_checks(data = data, ...)
  quantreg::predict.rq(object, newdata = data, ...)
}

#' data.frame-first formula-second method for \code{\link[quantreg]{nlrq}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[quantreg]{nlrq}}.
#'
#' @seealso \code{\link[quantreg]{nlrq}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' Dat <- NULL
#' Dat$x <- rep(1:25, 20)
#' set.seed(1)
#' Dat$y <- SSlogis(Dat$x, 10, 12, 2) * rnorm(500, 1, 0.1)
#'
#' fit <- nlrq(data = Dat,formula = y ~ SSlogis(x, Asym, mid, scal),tau = 0.5)
#' summary(fit)
#'
#' # Help page for function being twiddled
#' ?quantreg::nlrq
nlrq <- function(data, formula, ...) {
  check_pkg("quantreg")
  UseMethod("nlrq")
}

#' @export
nlrq.default <- function(data, formula, ...) {
  nlrq.data.frame(as.data.frame(data), formula, ...)
}

#' @export
nlrq.data.frame <- function(data, formula, ...) {
  quantreg::nlrq(formula = formula, data = data, ...)
}

#' @rdname nlrq
#' @export
predict.nlrq <- function(object, data, ...) {
  data <- predict_checks(data = data, ...)
  quantreg::predict.nlrq(object, newdata = data, ...)
}

#' #' data.frame-first formula-second method for \code{\link[quantreg]{rqss}}
#' #'
#' #' This function passes a data.frame, formula, and additional arguments to
#' #' \code{\link[quantreg]{rqss}}.
#' #'
#' #' @seealso \code{\link[quantreg]{rqss}}
#' #'
#' #' @inheritParams twidlr_defaults
#' #' @export
#' #'
#' #' @examples
#' #' n <- 200
#' #' x <- sort(rchisq(n,4))
#' #' z <- x + rnorm(n)
#' #" y <- log(x)+ .1*(log(x))^2 + log(x)*rnorm(n)/4 + z
#' #' dat <- data.frame(y = y,x = x,z = z)
#' #' rm(x,y,z)
#' #' fit  <- rqss(dat,y ~ qss(x, constraint= "N") + z,tau = 0.5)
#' #'
#' #' # Help page for function being twiddled
#' #' ?quantreg::rqss
#' rqss <- function(data, formula, ...) {
#'   check_pkg("quantreg")
#'   UseMethod("rqss")
#' }
#'
#' #' @export
#' rqss.default <- function(data, formula, ...) {
#'   rqss.data.frame(as.data.frame(data), formula, ...)
#' }
#'
#' #' @export
#' rqss.data.frame <- function(data, formula, ...) {
#'   quantreg::rqss(formula = formula, data = data, ...)
#' }
#'
#' #' @rdname rqss
#' #' @export
#' predict.rqss <- function(object, data, ...) {
#'   data <- predict_checks(data = data, ...)
#'   quantreg::predict.rqss(object, newdata = data, ...)
#' }
