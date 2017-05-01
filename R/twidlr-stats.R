#' data.frame-first formula-second method for \code{\link[stats]{t.test}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[stats]{t.test}}.
#'
#' @seealso \code{\link[stats]{t.test}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' t.test(iris[1:100,], Petal.Width ~ Species)
#'
#' # Help page for function being twiddled
#' ?stats::t.test
t.test <- function(data, formula, ...) {
  check_pkg("stats")
  UseMethod("ttest")
}

#' @export
t.test.default <- function(data, formula, ...) {
  ttest.data.frame(as.data.frame(data), formula, ...)
}

#' @export
ttest.data.frame <- function(data, formula, ...) {
  stats:::t.test.formula(formula = formula, data = data, ...)
}

#' data.frame-first formula-second method for \code{\link[stats]{lm}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[stats]{lm}}.
#'
#' @seealso \code{\link[stats]{lm}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' fit <- lm(mtcars, hp ~ .)
#' summary(fit)
#'
#' # Help page for function being twiddled
#' ?stats::lm
lm <- function(data, formula, ...) {
  check_pkg("stats")
  UseMethod("lm")
}

#' @export
lm.default <- function(data, formula, ...) {
  lm.data.frame(as.data.frame(data), formula, ...)
}

#' @export
lm.data.frame <- function(data, formula, ...) {
  stats::lm(formula = formula, data = data, ...)
}

#' @rdname lm
#' @export predict.lm
predict.lm <- function(object, data, ...) {
  check_alt_data(...)
  if (missing(data)) stop("Please specify 'data'")
  stats::predict.lm(object, newdata = data, ...)
}


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
#' predict(fit mtcars[1:5,])
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
  stats::glm(formula = formula, data = data, ...)
}

#' @rdname glm
#' @export predict.glm
predict.glm <- function(object, data, ...) {
  check_alt_data(...)
  if (missing(data)) stop("Please specify 'data'")
  stats::predict.glm(object, newdata = data, ...)
}

#' data.frame-first formula-second method for \code{\link[stats]{kmeans}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[stats]{kmeans}}.
#'
#' @seealso \code{\link[stats]{kmeans}}
#'
#' @inheritParams twidlr_defaults
#' @param formula One-sided \code{\link[stats]{formula}}
#' @export
#'
#' @examples
#' # Standard kmeans
#' kmeans(iris, ~., centers = 3)
#'
#' # formula interface can be used to select certain variables
#' kmeans(iris, ~ Petal.Width + Sepal.Width, centers = 3)
#'
#' #... or create new variables. Consider non-linear example:
#'
#' # Create data for two circles
#' x <- matrix(rnorm(300),nc=2)
#' y <- x/sqrt(rowSums(x^2))
#' d <- data.frame(rbind(y, y*5))
#' plot(d)
#'
#' library(broom)
#' library(ggplot2)
#' # Show clustering with X and Y dimensions
#' tmp <- augment(kmeans(d, ~., 2), d)
#' ggplot(tmp, aes(X1, X2, color = .cluster)) +
#'   geom_point()
#'
#' # Show clustering where formula used to add a quadratic component
#' tmp <- augment(kmeans(d, ~ X1 + X2 + I(X1^2 + X2^2), 2), d)
#' ggplot(tmp, aes(X1, X2, color = .cluster)) +
#'   geom_point()
#'
#' # Help page for function being twiddled
#' ?stats::kmeans
kmeans <- function(data, formula, ...) {
  check_pkg("stats")
  UseMethod("kmeans")
}

#' @export
kmeans.default <- function(data, formula, ...) {
  kmeans.data.frame(as.data.frame(data), formula, ...)
}

#' @export
kmeans.data.frame <- function(data, formula, ...) {
  x <- model_as_xy(data, formula)$x
  stats::kmeans(x = x, ...)
}
