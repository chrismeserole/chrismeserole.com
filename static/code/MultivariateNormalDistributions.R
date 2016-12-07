
# simulate data and run OLS
set.seed(1234)
n <- 10000
x1 <- rnorm(n,0,3)
x2 <- rnorm(n,3,5)
error <- rnorm(n,0,10)

y <- x1 + x2 + error

model <- lm(y~x1+x2)
summary(model)
vcov(model)


# drawing from multivariate normal distribution
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

#To get the same results, you can also use:
set.seed(123)
n<-10000
require(mvtnorm)
my.means <- c(x1=0,x2=3,err=0)
my.varcov <- matrix(c(3^2,0,0,0,5^2,0,0,0,10^2),ncol=3)
my.data <- rmvnorm(n,my.means,my.varcov)
y <- my.data[,1] + my.data[,2] + my.data[,3]
model<-lm(y~my.data[,1] +my.data[,2])
summary(model)
vcov(model)

# error checking in R
set.seed(123)
x1 <- rnorm(1000)
error <- rnorm(1000)
y <- x1 + error
qqnorm(y)
qqline(y)

y <- 2 + x1 + error 
qqnorm(y)
qqline(y) #see how the y-axis shifts?
 
y <- 2 + x1 + error*error
qqnorm(y)
qqline(y) 