+++
date = 2013-09-20
title = "R Code for Class 1"
+++

Below I'm going to walk through some examples for how to do in R the kinds of things we covered in class using Stata. 

The whole .R file for this is [here](http://chrismeserole.com/code/MultivariateNormalDistributions.R).

### Simulate Data and Run Linear Regression

Here's how to simulate some basic data and run a regression: 

	set.seed(123)
	n <- 100
	x1 <- rnorm(n,0,1)
	x2 <- rnorm(n,3,5)
	error <- rnorm(n,0,10)
	y <- x1 + x2 + error

	model <- lm(y~x1+x2)
	summary(model)
	vcov(model)

One thing to pay attention to are the last two lines. In the variable `model`, you're storing in a single object all the data associated with your regression. `summary` and `vcov` perform operations on the data in that object, but you can also access those data directly. 

Try running the following and see what happens:

	model$coefficients
	model$residuals

### Simulate Data from a Multivariate Normal Distribution

In Stata, we learned how to use `drawnorm`. 

To do the same in R, you first need to install the [mtvnorm](http://cran.r-project.org/web/packages/mvtnorm/index.html) package. Then run the following:

	set.seed(123)
	n<-10000
	require(mvtnorm)
	my.means <- c(x1=0,x2=3,err=0)
	my.varcov <- matrix(c(3^2,0,0,0,5^2,0,0,0,10^2),ncol=3)
	my.data <- rmvnorm(n,my.means,my.varcov)
	my.data <- list(x1=my.data[,1],x2=my.data[,2],err=my.data[,3])
	attach(my.data)
	y <- x1 + x2 + err
	model<-lm(y~x1+x2)
	summary(model)
	vcov(model)

You should get fairly similar results compared with what you got above. Note that you're using the variance-covariance matrix though, not the correlation matrix, so you're not bounded -1 to 1.

### Checking Your Errors

R actually comes with a residual plotter built in. Run the following: 

	set.seed(123)
	x1 <- rnorm(1000)
	error <- rnorm(1000)
	y <- x1 + error
	qqnorm(y)
	qqline(y)

Now try again with heteroskedastic errors:

	y <- 2 + x1 + error*error
	qqnorm(y)
	qqline(y)

Needless to say, for linear models, this is a great way to visually verify the homoskedasticity assumption.