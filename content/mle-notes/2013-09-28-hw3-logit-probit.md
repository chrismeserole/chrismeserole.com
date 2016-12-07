+++
date = 2013-09-28
title = "Homework 3 Notes"
+++

In general the homeworks were good again. 

Just one note: from here on out, always write a brief description for each question. 

Even if you're just writing a function -- as in question 1 -- be sure to write out at least one or two sentences about what the function is doing. Likewise, if the HW asks for a graph or table, assume that you're also implicitly being asked to discuss it for a bit. The goal isn't to trip you up, but to make sure you've got some kind of intuition about what you've just done. 

A couple other notes about the homework follow below ... they're kind of long-ish, so see the sidebar if you want to skip around.


### LOGIT vs Probit ### {#logit-probit}

A few people read too much into the different sizes of the logit vs. probit coefficients. 

Remember, for logit the [coefficients are log-odds ratios](http://en.wikipedia.org/wiki/Odds_ratio#Role_in_logistic_regression), while for probit, the coefficients are [z-scores](http://en.wikipedia.org/wiki/Standard_score). In themselves, they're not going to tell you much. All you should pay attention to are the direction (ie, positive or negative) and, in some cases, the statistical significance.

The coefficients only become meaningful when we move into the probability space, at which point we can in fact start to talk about the size of a parameter's effect and whether or not it is substantively significant.

(Note: for more on the different between logit and probit, [I highly recommend reading this answer on CrossValidated](http://stats.stackexchange.com/a/30909).)


### GRADIENTS ### {#gradients}

Thankfully pretty much everyone recognized that the gradients were getting smaller as the log-likelihood converged on its maximum.

After digging into gradients a lot more, I think the best way to explain them is to imagine you're hiking in the Appalachians but you're not allowed to use a footpath. What's the best way to reach the nearest peak? 

One way would be to take the gradient with respect to height at your starting point -- ie, the exact direction in the north-south/east-west plane that the mountain rises the fastest -- and begin climbing in that direction.  

Pretty soon you'll face a problem though: how far do you keep travelling in that direction? Unless by some miracle the mountain is symmetrical, the first gradient you measure will not point you in the exact direction of the summit. (And even if it is symmetrical, the gradient still won't tell you how far to travel to get to the top.)

To reach the peak, then, you need to stop and calculate the gradient every so often. Unfortunately, there's no perfect way to know how often to do this: depending on the contour of the mountain, it might be better to find the gradient every 100 feet, or it might be better to find it every 1000. Or it might be best to do it every thousand feet at first, and then every few feet at the top. Or it might be some other combination. 

You probably already realized where this is heading. Instead of a mountain in a three-dimensional space of length, width and height, imagine plotting a dataset in the three-dimensional space of age, income and education. 

The way you know you've reached a peak in that space (or a valley; see below) is when the rate of change in each dimension approaches zero at the same time. 

The question is how to get to such a peak from any given starting point. As with our mountain, the best way to get there will depend on the specific contour of the surface connecting our data. Sometimes you'll want to calculate a gradient vector early and often, other times you'll want to do it less. 

Since it's not always clear what the most efficient way is to arrive at the peak, you want multiple ways of trying to get there -- which is why multiple algorithms have been developed, such as the [Newton-Raphson](https://en.wikipedia.org/wiki/Newton's_method), [BFGS](http://en.wikipedia.org/wiki/Broyden%E2%80%93Fletcher%E2%80%93Goldfarb%E2%80%93Shanno_algorithm), etc.


### HESSIAN ### {#hessian-matrix}

So where does the Hessian come in? 

As I hinted at above, a three-dimensional space of age, income and education is the same, mathematically, as a three-dimensional space of length, width and height. The difference is that when we deal with length, width and height, we've got a very clear sense -- thanks to both our eyes and the wonders of gravity -- of what a peak is and what a valley is. 

In any other space though we can't rely on those senses. Instead we need a way of distinguishing peaks from valleys mathematically.

And the way we do that is with the [Hessian matrix](http://en.wikipedia.org/wiki/Hessian_matrix). Along its diagonal are the second partial derivatives for each variable, which tell us the rate of change of the rate of change for each dimension. 

If the rate of change of our function is zero in all dimensions and the diagonals along the Hessian are all positive, then we know we've hit a valley. If they're all negative, then we know we've hit a peak. 



### HESSIAN AND VARIANCE

Finally, the other thing the Hessian does is provide cross-partial second derivatives. These are the points off the diagonal, and they tell us about our function with respect to the rate of change in one dimension times the rate of change in another. 

If you think of what covariance is -- ie, how two variables move together in your space -- you can see how such cross-partials would be useful. The information they provide about simultaneous rates of change is what makes it possible to then use the Hessian to calculate the variance-covariance matrix for our parameters. 

The ability to use the Hessian in this way is why you can think of the Hessian as the "variance". 
