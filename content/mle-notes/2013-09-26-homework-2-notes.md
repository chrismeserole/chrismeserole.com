+++
date = 2013-09-26
title = "Homework 2 Notes"
+++

For the most part this homework was good. 

In the first two questions, some people didn't realize that they had to draw the betas from the normal distribution as well, or did draw them from the normal distribution, but forgot to include them when they generated `y`. 

The Stata code should have been something like: 

	drawnorm x1 x2 b1 b2 alpha error, n(10000) means(2,5,2,-2,1,0) sds(10,2,10,2,10,20) 
	gen y = alpha + b1*x1 + b2*x2 + error

### Social Processes: Observed Variables vs Unobserved Variables

This question tripped some people up, so I want to walk through it in-depth. Put simply, the social processes underlying your observed variables are very likely different from the social processes underlying your unobserved variables. 

To get an intuitive sense of this, consider the effect of violent protest on foreign direct investment. A simple, common sense theory would suggest that the more violent protest events a country experiences, the less likely foreign investers will be to invest in that country. Moreover, it's likely that the effect of violent protest on FDI is fairly constant across countries, enough so anyway that we can reasonably model the effect of violent protest as being normally distributed around some negative mean. 

We can thus model this as follows: 

<div style="text-align: center;font-family: Georgia">FDI ~ N(&alpha; + &beta;<sub>protest</sub>*X<sub>protest</sub>, &sigma;)</div>

Where:

<div style="text-align: center;font-family: Georgia">&beta;<sub>protest</sub> ~ N(-&mu;, &sigma;<sub>&beta;</sub>)</div>

But what about the violent protests themselves? What are the social processes underlying that data? 

We can imagine a lot of reasons for why violent protests happen, from a food shortage to government repression. Theoretically, though, violent protest is costly for everyone, so we generally assume violent protests won't happen very often, but then when they do (since the government is unlikely to immediately give in), they'll probably happen a lot. A better distribution to model such a process is the Poisson.  We'll learn more about the Poisson and its variants later, but the gist here is that such a distribution can result in most countries having relatively low levels of violent protest, while a few have quite a lot. 

Formally, we would model this as: 

<div style="text-align: center;font-family: Georgia">X<sub>protest</sub> ~ Poisson(&lambda;)</div>

That's clearly a very different distribution than we think our <strong>B<sub><emph>protest</emph></sub></strong> adheres to.

To be clear, the differences between the distributions of our observed and unobserved data won't always be this extreme. For example, both your observed and unobserved variables may belong to the same family of distribution -- which is what we assumed in the homework when we drew both observed and unobserved variables from the normal distribution -- but the key point is that the social processes are generally separate/different, and as a result we ought to model our observed and unobserved variables separately too.