gini <-
function (x, weights = rep(1, length = length(x))) 
{
  ox <- order(x)
  x  <- x[ox]
  weights <- weights[ox] / sum(weights)
  p  <- cumsum(weights)
  nu <- cumsum(weights * x)
  n  <- length(nu)
  nu <- nu / nu[n]
  sum(nu[-1] * p[-n]) - sum(nu[-n] * p[-1])
}
# <environment: namespace:reldist>
gini2 <-
function(x, unbiased = TRUE, na.rm = FALSE){
  if (!is.numeric(x)){
    warning("'x' is not numeric; returning NA")
    return(NA)
  }
  if (!na.rm && any(na.ind <- is.na(x)))
    stop("'x' contain NAs")
  if (na.rm)
    x <- x[!na.ind]
  n  <- length(x)
  mu <- mean(x)
  N  <- if (unbiased) n * (n - 1) else n * n
  ox <- x[order(x)]
  dsum <- drop(crossprod(2 * 1:n - n - 1,  ox))
  dsum / (mu * N)
}
