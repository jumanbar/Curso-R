tfinal <- 100
i <- 1
out <- 0.01
repeat {
  nuevo  <- out[i] * 1.2 * (1 - out[i])
  i <- i + 1
  out[i] <- nuevo
  if(i == tfinal)
    break
}
