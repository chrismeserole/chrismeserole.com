+++
title = "Poisson Saturated Log Likelihood"
date = "2015-08-31"
+++

I was poking around the web earlier for the saturated log-likehood in a poisson model, but couldn't find it. 

Here goes, using an example from [Millar's MLE Estimation and Inference](https://books.google.com/books?id=qvzUGYmChxUC&lpg=PT165&dq=negative%20binomial%20deviance%20R%20code&pg=PT165#v=onepage&q=negative%20binomial%20deviance%20R%20code&f=false):

```{r}
library(MASS)

z <- c(rep(0,19), 1,1,2,2,3,3,3,3,4,4,4,5,6,6,6,6,7,7,7,9,9)

mod <- glm(z~1,family="poisson")

z.pos <- z[(z>0)]

saturated.ll <- sum(z.pos*log(z.pos)-z.pos-log(factorial((z.pos))))
intercept.ll <- as.numeric(logLik(mod))

saturated.ll
intercept.ll
(my.null.deviance <- 2*(saturated.ll-intercept.ll))
mod$null.deviance
```

If it's easier to understand what's going on, also try this:

```{r}
total <- 0
for(i in 1:40){
  if(z[i]>0)
    total <- total + z[i]*log(z[i])-(z[i])-log(factorial(z[i]))
  else
    # can't evaluate log(0) ... also, note z[i] here will always be 0 too
    total <- total + 0 - z[i] - 0  
}
total
```

