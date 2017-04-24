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
