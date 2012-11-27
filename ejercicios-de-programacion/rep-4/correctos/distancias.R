distancias <- function(pnt, p = c(0, 0), ver = TRUE) {
  if (!(class(pnt) %in% c('data.frame', 'matrix')) || !is.numeric(pnt) || ncol(pnt) != 2)
        stop('El objeto pnt no tiene el formato adecuado')
  if (!is.numeric(p) || length(p) != 2)
        stop('El objeto p no es numérico o tiene longitud != 2')
  mp <- matrix(p, nrow = nrow(pnt), ncol = 2, byrow = TRUE)
  catetos <- abs(pnt - mp)            
  ord <- t(apply(catetos, 1, sort))   
  r <- ord[,1] / ord[, 2]             
  dists <- ord[, 2] * sqrt(1 + r ^ 2) 
  i.max <- which.max(dists)
  i.min <- which.min(dists)
  d.max <- dists[i.max]
  d.min <- dists[i.min]
  pout <- pnt[c(i.max, i.min), ]
  rownames(pout) <- c('d.max', 'd.min')
  colnames(pout) <- c('x', 'y')
  if (ver) {
    plot(pnt, xlab = 'Longitud', ylab = 'Latitud')
    points(p[1], p[2], pch = 19)
    points(pnt[c(i.max, i.min), ], pch = 19, col = 2:3)
    segments(p[1], p[2], pout[, 1], pout[, 2], col = 2:3, lwd = 2)
  }
  cat('d.max =', round(d.max, 2), '- punto:', round(pout[1, ], 2), '\n')
  cat('d.min =', round(d.min, 2), '- punto:', round(pout[2, ], 2), '\n')
  list(dists = c(d.max = d.max, d.min = d.min),
       posiciones = c(i.max = i.max, i.min = i.min),
       puntos = pout, centro = p)
}
