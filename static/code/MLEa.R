require(arm)

ml.logit <- function(specification, data, betas.init, method) { 

	beta.iterations		<- matrix(nrow=0,ncol=dim(data)[2])
	loglik.iterations 	<- numeric(0)
	 
	sumloglik <- function(beta, y, x){ 
	    loglik <- sum(-y*log(1 + exp(-(x%*%beta))) - (1-y)*log(1 + exp(x%*%beta)))
	     	
	    loglik.iterations 	<<- c(loglik.iterations, loglik)
		beta.iterations		<<- rbind(beta.iterations, betas=beta)

		return(-loglik) # switch sign b/c optim() minimizes rather than maximizes
	} 

	# hack to get the dependent variable name
	dv = rownames(attr(terms(specification),"factors"))[1]
	# now get dependent variable data
	y = as.numeric(data[,match(dv,colnames(data))])

	# now get all our independent variable data ... 
	# note: model.matrix() creates a matrix with an intercept vector of 1s 
	# and all corresponding vectors in "data" for right-hand side 
	# variables in "specification"
    x = model.matrix(specification, model.frame(data))
	
	# name betas
	names(betas.init) = colnames(x) 
	 
	mle = optim(betas.init,sumloglik,x=x,y=y,hessian=T, control=list(trace=6),method=method)
	return(list(betas=mle$par,vcov=solve(mle$hessian),log.likelihood=-mle$value, beta.iterations = beta.iterations, loglik.iterations=loglik.iterations))

} 

n <- 1000
x1 <- rnorm(n,0,3) 
x2 <- rnorm(n,0,5)
y <- rbinom(n,1,invlogit(x1-x2))

data <- data.frame(x1=x1,x2=x2,y=y)
specification <- as.formula("y~x1+x2")

betas.init <- rep(0,dim(data)[2]) # length works b/c y dropped, but intercept added
method <- "Nelder-Mead" # also try "BFGS", "CG", "L-BFGS-B", "SANN", "Brent"
model <- ml.logit(specification,data,betas.init,method)
model$betas
model$vcov
model$log.likelihood

# check against regular logit
(model2 <- glm(y~x1+x2,family="binomial"(link="logit")))

# plot evolution of likelihood and parameters
par(mfrow=c(2,2))
plot(model$loglik.iterations, xlab="Iteration", ylab="Log-Likelihood", cex=.6)
plot(model$beta.iterations[,1], xlab="Iteration", ylab="Intercept Estimate", cex=.6) # evolution of Intercept
plot(model$beta.iterations[,2], xlab="Iteration", ylab="b1 Estimate", cex=.6) # evolution of b1
plot(model$beta.iterations[,3], xlab="Iteration", ylab="b2 Estimate", cex=.6) # evolution of b2


