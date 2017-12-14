rm()
list(rm())
objects()
rm(list=ls(all=TRUE))
mydata = read.csv('http://www.ats.ucla.edu/stat/data/binary.csv')

mylogit = glm(admit~gre+gpa+as.factor(rank), family=binomial, data=mydata)

mle.logistic.regression = function(fmla, data)
{
    # Define the negative log likelihood function
    get_log_likelihood <- function(beta,x,y){

      # Use the log-likelihood of the Bernouilli distribution, where p is
      # defined as the logistic transformation of a linear combination
      # of predictors, according to logit(p)=(x%*%beta)
      loglik <- sum(-y*log(1 + exp(-(x%*%beta))) - (1-y)*log(1 + exp(x%*%beta)))
      return(-loglik)
    }

    # Prepare the data
    outcome = rownames(attr(terms(fmla),"factors"))[1]
    x = model.matrix(fmla, model.frame(data))
    y = as.numeric(data[,match(outcome,colnames(data))])

    # Define initial values for the parameters
    theta.start = rep(0,(dim(x)[2]))
    names(theta.start) = colnames(x)

    # Calculate the maximum likelihood
    mle = optim(theta.start,get_log_likelihood,x=x,y=y,hessian=T, control=list(trace=6), method="BFGS" )
    out = list(beta=mle$par,vcov=solve(mle$hessian),ll=2*mle$value)
}

mydata$rank = factor(mydata$rank) #Treat rank as a categorical variable
fmla = as.formula("admit~gre+gpa+rank") #Create model formula

mylogit = mle.logistic.regression(fmla, mydata) #Estimate coefficients
mylogit


t <- rexp(100, 2)
loglik <- function(theta) log(theta) - theta*t
gradlik <- function(theta) 1/theta - t
hesslik <- function(theta) -100/theta^2
## Estimate with numeric gradient and hessian
a <- maxLik(loglik, start=1, print.level=2)
print( a )
coef( a )