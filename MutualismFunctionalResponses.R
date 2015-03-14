# adapted from Holland et al., Ecology, 2002

#paramters
	alpha <- 1
	delta <-  -2
	beta <- -0.8
	epsilon <- 1 #slope of saturating functions
	zeta <- 2 #difference in slopes for the saturating curves

	min <- 0
	max <- 10


# functions
	linear <- function(N2 , alpha = 0 , beta = 0  , delta = 0){
		N1 <- alpha*N2 - (beta*N2 + delta)
	}

	saturate <- function(N2 , asymptote , slope){
		N1 <- (asymptote*N2)/(slope + N2)
	}

	hyperbolic <- function(N2 , asymptote , slope){
		N1 <- (asymptote)/(slope + N2)
	}


# figure
	# setwd("/Users/christophermoore/Desktop/")
	# pdf("MutFuncResp.pdf" , width = 6 , height = 4)
	par(mfrow = c(2,3) , mar = rep(1 , 4) , oma = rep(2 , 4)) # to mimic holland et al. 2002
	# A. NE lineraly increase with constant cost
	curve(linear(N2 = x , alpha = alpha) , from = min , to = max , xaxt = "n" , yaxt = "n" , xlab = "" , ylab = "" , lwd = 2 , col = "#0000FF" , yaxs = "i" , xaxs = "i" , frame = F)
	curve(linear(N2 = x , delta = delta) , from = min , to = max , add = T ,  lwd = 2 , col = "#FF0000")
	curve(linear(N2 = x , alpha = alpha)-linear(N2 = x , delta = delta) , from = min , to = max , xaxt = "n" , yaxt = "n" , xlab = "" , ylab = "" , lwd = 2 , col = "#FF00FF" , add = T)
	abline(v = 0 , h = 0 , col = "#000000" , lwd = 2)
	legend("topleft" , lwd = 2 , col = c("#0000FF" , "#FF0000" , "#FF00FF") , legend = c("benefit" , "cost" , "net effect") , bty = "n")

	# B. NE lineraly increase
	curve(linear(N2 = x , alpha = alpha) , from = min , to = max , xaxt = "n" , yaxt = "n" , xlab = "" , ylab = "" , lwd = 2 , col = "#0000FF" , yaxs = "i" , xaxs = "i" , frame = F)
	curve(linear(N2 = x , beta = beta) , from = min , to = max , add = T ,  lwd = 2 , col = "#FF0000")
	curve((linear(N2 = x , alpha = alpha)-linear(N2 = x , beta = beta)) , from = min , to = max , lwd = 2 , col = "#FF00FF" , add = T)
	abline(v = 0 , h = 0 , col = "#000000" , lwd = 2)

	# C. NE constant
	curve(linear(N2 = x , alpha = alpha) , from = min , to = max , xaxt = "n" , yaxt = "n" , xlab = "" , ylab = "" , lwd = 2 , col = "#0000FF" , yaxs = "i" , xaxs = "i" , frame = F)
	curve(linear(N2 = x + delta, beta = beta), from = min , to = max , add = T ,  lwd = 2 , col = "#FF0000")
	curve(linear(N2 = x , alpha = alpha)-ifelse(linear(N2 = x + delta, beta = beta) <0 , 0 , linear(N2 = x + delta, beta = beta)) , from = min , to = max , lwd = 2 , col = "#FF00FF" , add = T)
	abline(v = 0 , h = 0 , col = "#000000" , lwd = 2)

	# D. NE saturate
	curve(saturate(N2 = x , asymptote = alpha , slope = epsilon) , from = min , to = max , xaxt = "n" , yaxt = "n" , xlab = "" , ylab = "" , lwd = 2 , col = "#0000FF" , yaxs = "i" , xaxs = "i" , frame = F)
	curve(saturate(N2 = x , asymptote = -beta , slope = epsilon) , from = min , to = max , add = T ,  lwd = 2 , col = "#FF0000")
	curve(saturate(N2 = x , asymptote = alpha , slope = epsilon)-saturate(N2 = x , asymptote = -beta , slope = epsilon) , from = min , to = max , lwd = 2 , col = "#FF00FF" , add = T)
	abline(v = 0 , h = 0 , col = "#000000" , lwd = 2)

	# E. NE saturate + constant
	curve(saturate(N2 = x , asymptote = 1 , slope = epsilon) , from = min , to = max , xaxt = "n" , yaxt = "n" , xlab = "" , ylab = "" , lwd = 2 , col = "#0000FF" , yaxs = "i" , xaxs = "i" , frame = F)
	curve(hyperbolic(N2 = x, asymptote = 1 , slope = epsilon) , from = min , to = max , add = T ,  lwd = 2 , col = "#FF0000")
	curve(saturate(N2 = x, asymptote = 1 , slope = epsilon)-hyperbolic(N2 = x, asymptote = 1 , slope = epsilon) , from = min , to = max , lwd = 2 , col = "#FF00FF" , add = T)
	abline(v = 0 , h = 0 , col = "#000000" , lwd = 2)

	# F. NE unimodal
	curve(saturate(N2 = x , asymptote = 1 , slope = epsilon) , from = min , to = max , xaxt = "n" , yaxt = "n" , xlab = "" , ylab = "" , lwd = 2 , col = "#0000FF" , yaxs = "i" , xaxs = "i" , frame = F)
	curve(saturate(N2 = x, asymptote = 1 , slope = epsilon*zeta) , from = min , to = max , add = T ,  lwd = 2 , col = "#FF0000")
	curve(saturate(N2 = x, asymptote = 1 , slope = epsilon)-saturate(N2 = x, asymptote = 1 , slope = epsilon*zeta) , from = min , to = max , lwd = 2 , col = "#FF00FF" , add = T)
	abline(v = 0 , h = 0 , col = "#000000" , lwd = 2)

	# looking pretty
	mtext(expression(Population~size~of~N[2]) , side = 1 , outer = T)
	mtext(expression(Effect~on~population~size~of~N[1]) , side = 2 , outer = T)
	mtext(expression(Mutualism~functional~responses~from~Holland~italic(et~al.)~2002) , side = 3 , outer = T)
	# dev.off()