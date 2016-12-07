+++
title = "Example R and Python Code"
date = 2015-04-20
+++


In addition to Python, Lark now executes R at runtime as well, via [Knitr](http://yihui.name/knitr/). 

Still have an issue with Maplotlib, but otherwise things are looking good!

--------------

Here goes. First let's try R:

```{r}
x <- rnorm(100)
summary(x)
```

Now let's switch over to Python:

```Python
>>> x = 3
>>> x + 1
[should be 4]
>>> 2 + 2*x
missing or wrong results will be overwritten
```

Ok. Let's try plotting stuff. 

First in R: 

```{r}
plot(cars)
```

Now let's try a plot in Python ... 

```Python
>>> import matplotlib.pyplot as plt

>>> fig = plt.figure()
>>> plt.plot([1, 2, 3, 4, 5], [6, 7, 2, 4, 5])
>>> fig
```

Bummer. Looks like fig object exists, it's just not being passed properly to Lark.

Hopefully we should be able to sort it out in time. 