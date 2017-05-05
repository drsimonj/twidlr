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
  UseMethod("t.test")
}

#' @export
t.test.default <- function(data, formula, ...) {
  t.test.data.frame(as.data.frame(data), formula, ...)
}

#' @export
t.test.data.frame <- function(data, formula, ...) {
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
#' @export
predict.lm <- function(object, data, ...) {
  data <- predict_checks(data = data, ...)
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
#' @export
predict.glm <- function(object, data, ...) {
  data <- predict_checks(data = data, ...)
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
#' @param formula One-sided \code{\link[stats]{formula}} (optional). If omitted,
#'   all variables in "data" will be included.
#' @export
#'
#' @examples
#' # Standard kmeans
#' kmeans(iris, centers = 3)
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
kmeans <- function(data, formula = ~., ...) {
  check_pkg("stats")
  UseMethod("kmeans")
}

#' @export
kmeans.default <- function(data, formula = ~., ...) {
  kmeans.data.frame(as.data.frame(data), formula, ...)
}

#' @export
kmeans.data.frame <- function(data, formula = ~., ...) {
  x <- model_as_xy(data, formula)$x
  object <- stats::kmeans(x = x, ...)
  attr(object, "formula") <- formula
  object
}

#' @rdname kmeans
#' @export
predict.kmeans <- function(object, data, ...) {
  data <- predict_checks(data = data, ...)
  data <- model_as_xy(data, attr(object, "formula"))$x

  centers   <- object[["centers"]]
  n_centers <- nrow(centers)
  distances <- matrix(0, nrow = nrow(data), ncol = n_centers)

  for (i in seq(n_centers)) {
    distances[,i] <- sqrt(rowSums(t(t(data) - centers[i,])^2))
  }

  apply(distances, 1, which.min)
}

#' data.frame-first formula-second method for \code{\link[stats]{prcomp}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[stats]{prcomp}}.
#'
#' @seealso \code{\link[stats]{prcomp}}
#'
#' @inheritParams twidlr_defaults
#' @param formula a formula with no response variable, referring only to numeric
#'   variables
#' @export
#'
#' @examples
#' prcomp(mtcars)
#'
#' fit <- prcomp(mtcars, ~ .*.)
#' predict(fit, mtcars[1:5,])
prcomp <- function(data, formula = ~., ...) {
  check_pkg("stats")
  UseMethod("prcomp")
}

#' @export
prcomp.default <- function(data, formula = ~., ...) {
  prcomp.data.frame(as.data.frame(data), formula, ...)
}

#' @export
prcomp.data.frame <- function(data, formula = ~., ...) {
  object <- stats:::prcomp.formula(formula = formula, data = data, ...)
  attr(object, "formula") <- formula
  object
}

#' @rdname prcomp
#' @export
predict.prcomp <- function(object, data, ...) {
  data <- predict_checks(data = data, ...)
  data <- model_as_xy(data, attr(object, "formula"))$x
  stats:::predict.prcomp(object = object, newdata = data, ...)
}

#' data.frame-first formula-second method for \code{\link[stats]{aov}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[stats]{aov}}.
#'
#' @seealso \code{\link[stats]{aov}}
#'
#' @inheritParams twidlr_defaults
#' @export
#'
#' @examples
#' fit <- aov(mtcars, hp ~ am * cyl)
#' summary(fit)
#' predict(fit, mtcars)
aov <- function(data, formula, ...) {
  check_pkg("stats")
  UseMethod("aov")
}

#' @export
aov.default <- function(data, formula, ...) {
  aov.data.frame(as.data.frame(data), formula, ...)
}

#' @export
aov.data.frame <- function(data, formula, ...) {
  stats::aov(formula = formula, data = data, ...)
}

# predict method for aov is predict.lm
