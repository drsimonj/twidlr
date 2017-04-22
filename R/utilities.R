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
  if (!is(f, "formula"))
    stop("Please provide a formula object such as `y ~ x`")

  lhs <- c()
  rhs <- all.vars(f[[2]])
  if(length(f) == 3) {
    lhs <- rhs
    rhs <- all.vars(f[[3]])
  }

  list(lhs = lhs, rhs = rhs)
}

#' Convert a data frame and formula to input matrix and output vector
#'
#' Convert a data frame and formula of the form "\code{y ~ x1 + x2 + ... + xi}"
#' to a list containing all input variables as a matrix and the output variable
#' as a vector. These structures are commonly used by various modelling
#' functions such as \code{\link[glmnet]{glmnet}}
#'
#' @param data A data frame
#' @param formula A formula of the form \code{y ~ x1 + x2 + ... + xi}
#'
#' @return Two-element list containing output values as a vector named \code{y}
#'   and an input matrix called \code{X}
#'
#' @export
#'
#' @examples
#' unpack_data(mtcars, hp ~ mpg + wt + disp)
#' unpack_data(mtcars, hp ~ .)
#' unpack_data(mtcars, ~ .)
unpack_data <- function(data, f) {
  # Extract variables
  v <- unpack_formula(f)
  if (identical(v$rhs, '.')) {
    v$rhs <- names(data)
    if (!is.null(v$lhs))
      v$rhs <- v$rhs[v$rhs != v$lhs]
  }

  # Convert data frame to input matrix and label vector
  y <- NULL
  if (!is.null(v$lhs))
    y <- data[[v$lhs]]
  X <- data.matrix(data[v$rhs])

  list(y = y, X = X)
}
