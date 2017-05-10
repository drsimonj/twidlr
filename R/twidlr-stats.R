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
#' ttest(iris[1:100,], Petal.Width ~ Species)
ttest <- function(data, formula, ...) {
  check_pkg("stats")
  UseMethod("ttest")
}

#' @export
ttest.default <- function(data, formula, ...) {
  ttest.data.frame(as.data.frame(data), formula, ...)
}

#' @export
ttest.data.frame <- function(data, formula, ...) {
  stats::t.test(formula = formula, data = data, ...)
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
#' @export predict.lm
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
#' predict(fit, mtcars[1:5,])
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
#' @export predict.glm
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
#' fit <- kmeans(d, centers = 2)
#' plot(d, col = predict(fit, d))
#'
#' fit <- kmeans(d, ~ X1 + X2 + I(X1^2 + X2^2), centers = 2)
#' plot(d, col = predict(fit, d))
kmeans <- function(data, formula = ~., ...) {
  check_pkg("stats")
  UseMethod("kmeans")
}

#' @export
kmeans.default <- function(data, formula = ~., ...) {
  kmeans.data.frame(as.data.frame(data), formula = formula, ...)
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
#' @export predict.kmeans
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
  prcomp.data.frame(data = as.data.frame(data), formula = formula, ...)
}

#' @export
prcomp.data.frame <- function(data, formula = ~., ...) {
  object <- stats:::prcomp.formula(formula = formula, data = data, ...)
  attr(object, "formula") <- formula
  object
}

#' @rdname prcomp
#' @export
#' @export predict.prcomp
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
  prcomp.data.frame(data = as.data.frame(data), formula = formula, ...)
}

#' @export
prcomp.data.frame <- function(data, formula = ~., ...) {
  object <- stats:::prcomp.formula(formula = formula, data = data, ...)
  attr(object, "formula") <- formula
  object
}

#' @rdname prcomp
#' @export
#' @export predict.prcomp
predict.prcomp <- function(object, data, ...) {
  data <- predict_checks(data = data, ...)
  data <- model_as_xy(data, attr(object, "formula"))$x
  stats:::predict.prcomp(object = object, newdata = data, ...)
}


#' data.frame-first formula-second method for \code{\link[stats]{factanal}}
#'
#' This function passes a data.frame, formula, and additional arguments to
#' \code{\link[stats]{factanal}}.
#'
#' @seealso \code{\link[stats]{factanal}}
#'
#' @inheritParams unsupervised_twidlr_defaults
#' @export
#'
factanal <- function(data, formula = ~., ...) {
  check_pkg("stats")
  UseMethod("factanal")
}

#' @export
factanal.default <- function(data, formula = ~., ...) {
  factanal.data.frame(data = as.data.frame(data), formula = formula, ...)
}

#' @export
factanal.data.frame <- function(data, formula = ~., ...) {
  stats::factanal(x = formula, data = data, ...)
}
