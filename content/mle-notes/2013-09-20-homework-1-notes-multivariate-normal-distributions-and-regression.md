+++
date = 2013-09-20
title = "Homework 1 Notes"
+++

Thankfully everyone did pretty well on this. There are a few minor points that came up often though.

### Coefficient Standard Errors
So. Fortunately everyone seemed to understand what happens to `b1`'s standard error when you increase the variance of `x1` on the one hand and of the error term on the other. But no one included the formal explanation, so here it is: 

<img align="center" src="/assets/regression_coefficient_se.png" />

Note that within the square root you've really got a fraction, with the model variance in the numerator and the *jj*-th element of the model's variance-covariance matrix (ie, the `(X'X)`) in the denominator. Since the model variance is on the top of the fraction, any increase in it will lead to an increase in all standard errors, while since the variance of a particular `x(j)` will be on the bottom of the fraction, increasing it will lead to a *decrease* in the standard error of the corresponding coefficient. 

Finally, while it may be clear from the equation why a 10x increase in the overall model standard error leads to a correspondng 10x increase in the coefficient standard errors (namely, you've got a square within a square root, so the exponents cancel out), it's probably less obvious from the equation as shown that the cells along the diagonal of the variance-covariance matrix are themselves squared, which is why you also get a similar 10x decrease in coefficient standard error when you increase the standard deviation of a particular `x(j)` by exactly 10x.

For more on this, see [Wikipedia](http://en.wikipedia.org/wiki/Ordinary_least_squares#CITEREFHayashi2000) or work through the R code in [this answer](http://stats.stackexchange.com/a/44842) on [a question about regression coefficient standard errors](http://stats.stackexchange.com/questions/44838/how-are-the-standard-errors-of-coefficients-calculated-in-a-regression) on the cross-validation forum. 

### Biased Models (Correlated Errors) vs Inefficient Models (Heteroskedastic Errors)

This one gives me a headache every time I think about it. In fact, I even have a vague memory of confusing them in the first lab. 

But here's the deal. 

Correlating the error term with `x1` or `x2` generates biased estimated coefficients. In a word, your betas themselves are going to be off.

By contast, heteroskedasticizing (is that a word?) your error term generates inefficient standard errors for your estimated coefficients. This is different from bias. Your estimates can still be right, but it's going to take more information for you to be as confident that they are right. Put differently, with heteroskedastic errors, with a large enough N you'll end up with the same coefficients, but your standard errors are going to be bigger than they would be if the model was homoskedastic. The only way to get the standard errors down in that case is to keep increasing your N (the need for more data for the same result is why the term 'inefficient' is used.)

One last point about this: OLS can handle some types of heteroskedasticity, provided that you correct for it appropriately in your model. So heteroskedastic errors do not immediately rule out OLS as an option. They only rule it out if there's no way to correct for them fully (as is the case, say, with binary data).

### Endogeneity

A few people said something to the effect of, "correlated errors so omitted variable bias so OMG ENDOGENEITY AHHH!' 

That's true as far as it goes. Endogeneity is in fact present when one variable is informed/determined by another variable in your system. 

The issue is that there's two very different kinds of endogeneity. The endogeneity that is really problematic is when your `y` is influencing your `x1`. Since the whole point of this social science thing is causal inference, when your IVs are endogenous with your DV, that's a HUGE problem. That's why when a senior prof goes off on endogeneity in someone's model at a job talk and things get super awkward, this is almost always the kind of endogeneity being discussed. 

By contrast, when an IV is endogenous with an omitted variable, that's problematic, but it's problematic because it's messing with your estimate of an IV's causal effect, not because it's throwing into doubt the entire direction of the causal relationship between your IV and DV.

I guess what I'm saying is: be careful when you throw up your hands and shout 'endogeneity!' It only really merits the shout if the dependent variable might be involved. 