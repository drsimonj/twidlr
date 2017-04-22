#' Convert formula into a character list
#'
#' Convert a formula of the form \code{y ~ x} into a two-element list containing
#' the lefthand and righthand sides of the formula as character vectors
#'
#' @param f A formula
#'
#' @seealso \code{\link[lazyeval]{f_lhs}}
#'
#' @return Two-element list of character vectors corresponding to the lefthand
#'   and righthand sides of the formula
#'
#' @export
#'
#' @examples
#' unpack_formula(y ~ x)
#' unpack_formula(y ~ x1 + x2)
#' unpack_formula(y ~ .)
#' unpack_formula(~ "x")
unpack_formula <- function(f) {
  lhs <- as.character(lazyeval::f_lhs(f))
  rhs <- as.character(lazyeval::f_rhs(f))
  list(lhs = lhs, rhs = rhs)
}

#' Convert a data frame and formula to input matrix and output vector
#'
#' Convert a data frame and formula of the form "\code{output ~ feature_1 +
#' feature_2 + ... + feature_i}" to a list containing all input variables as a
#' matrix and the output variable as a vector. These structures are commonly
#' used by various modelling functions such as \code{\link[glmnet]{glmnet}}
#'
#' @param data A data frame
#' @param f A formula of the form \code{output ~ feature_1 + feature_2 + ... + feature_i}
#'
#' @return Two-element list containing output values as a vector named \code{y}
#'   and an input matrix called \code{X}
#'
#' @export
#'
#' @examples
#' unpack_data(mtcars, hp ~ .)
unpack_data <- function(data, f) {
  # Extract variables
  vars <- unpack_formula(f)
  if (identical(vars$rhs, '.'))
    vars$rhs <- names(data)[names(data) != vars$lhs]
  vars$rhs <- vars$rhs[vars$rhs != "+"]

  # Convert data frame to input matrix and label vector
  X <- data.matrix(data[, vars$rhs])
  y <- data[[vars$lhs]]

  list(y = y, X = X)
}
