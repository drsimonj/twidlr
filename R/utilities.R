#' Pipe operator
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL



#' Convert data frame and model \code{\link[stats]{formula}} to input matrix and
#' output vector list
#'
#' Convert a data frame and model \code{\link[stats]{formula}} to a list
#' containing the input variables as a matrix \code{x} and the output variable
#' as a vector \code{y}. These structures are commonly used by various modelling
#' functions such as \code{\link[glmnet]{glmnet}}.
#'
#' All operators made available by \code{\link[stats]{formula}} are allowed.
#'
#' @param data A data frame
#' @param formula A \code{\link[stats]{formula}}
#'
#' @return Two-element list containing input variables as a matrix \code{x}, and
#'   output variable as a vector \code{y}
#'
#' @export
#'
#' @seealso \code{\link[stats]{formula}} \code{\link[stats]{model.matrix}}
#'
#' @examples
#' model_as_xy(mtcars, hp ~ mpg)
#' model_as_xy(mtcars, hp ~ .)
#' model_as_xy(mtcars, hp ~ mpg * hp)
#' model_as_xy(mtcars, ~ .)
model_as_xy <- function(data, formula) {

  if (!is.data.frame(data) | !methods::is(formula, "formula"))
    stop("Please provide a data frame and formula (see ?stats::formula)")

  # Convert data frame to input matrix and label vector
  x <- stats::model.matrix(object = formula, data = data)[,-1]
  y <- NULL
  if (length(formula) == 3) {
    y <- data[[as.character(formula[[2L]])]]
    y <- y[rownames(data) %in% rownames(x)]  # Handle removal of missing values
  }

  list(x = x, y = y)
}

#' Check for required package
#'
#' Check if package is locally installed and call `stop()` with an error message
#' if not
#'
#' @param pkg_name Character of the package name to check
#'
#' @examples
#' check_pkg("stats")
#' check_pkg("dplyr")
#' check_pkg("zzz")
check_pkg <- function(pkg_name) {
  if (!requireNamespace(pkg_name, quietly = TRUE)) {
    stop("The '", pkg_name, "' package is needed. Please install it.", call. = FALSE)
  }
}

#' Check if argument(s) are given as alternatives to another
#'
#' Check for certain arguments that, if present, will result in function
#' producing an error and stopping the function if desired.
#'
#' @param ... Named arguments. Typically passed from another function.
#' @param target String of variable for which alternatives may be present.
#' @param alts Character vector of arguments that may act as alternatives to the target
#' @param stop Boolean. If True, \code{\link[base]{stop}}() is called with an
#'   error message. If False, \code{\link[base]{warning}}() is called with an
#'   error message.
#'
#' @examples
#' check_alt_args(a = 10, target = "a", alts = c("b"))
#' check_alt_args(b = 10, target = "a", alts = c("b"))
#' check_alt_args(b = 10, target = "a", alts = c("b"), stop = FALSE)
check_alt_args <- function(..., target, alts, stop = TRUE) {
  checks <- alts %in% names(c(...))
  if (any(checks)) {
    if (stop)
      stop("Please specify '", target, "' instead of '", alts[checks], "'")

    warning("", target, " is preferable to '", alts[checks], "'")
  }
}

#' Run checks for twidlr predict functions and invisibly return 'data' coerced
#' to a data frame
predict_checks <- function(data, ...) {
  # Check that 'data' exists and alternatives do not
  if (missing(data)) stop("'data' is missing")
  check_alt_args(..., target = "data", alts = c("newx", "newdata"), stop = TRUE)

  # Coerce data to data frame
  data <- as.data.frame(data)
  invisible(data)
}
