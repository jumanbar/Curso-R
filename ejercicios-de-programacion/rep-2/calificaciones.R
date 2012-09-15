cal <- rpois(260 + sample(20, 1), 6)
cal[cal > 12] <- 12
cal[cal == 0] <- 1
gen <- sample(c('V', 'M'), length(cal), replace=TRUE)
