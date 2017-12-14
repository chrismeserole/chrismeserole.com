require(mvtnorm) # for rmvnorm() 
require(Matrix)  # for diagonal matrix

# create the data
n <- 1000
sds <- c(1,2,3,5,2,1)
means <- c(rep(0,length(sds)))
cov.matrix <- as.matrix(Diagonal(length(sds),sds))
mydata <- rmvnorm(n,means,cov.matrix)

# label the data
colnames(mydata) <- c("alpha","x1","x2","b1","b2","error")
mydata <- data.frame(mydata)
attach(mydata)

# show b1
summary(b1)
plot(density(b1))

# create and show y
y <- alpha + b1*x1 + b2*x2 + error
summary(y)
plot(density(y))



# now use correlation matrix instead

cor_to_cov <- function (sds,cor.matrix) {
	diag.matrix <- Diagonal(length(sds),sds)
	return(as.matrix(diag.matrix %*% cor.matrix %*% diag.matrix))
}

n <- 1000
cor.matrix <- matrix(c( 1, 0.1, 0.1,
					  0.1,   1, 0.1,
					   0.1,  0.1,  1),3)
sds <- c(1,2,1)
means <- c(rep(0,length(sds)))
mydata <- rmvnorm(n,means,cor_to_cov(sds,cor.matrix))
colnames(mydata) <- c("alpha","x1","b1")
summary(mydata[,"b1"])
plot(density(mydata[,"b1"]))


