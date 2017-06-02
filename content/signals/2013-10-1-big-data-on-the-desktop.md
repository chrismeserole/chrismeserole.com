+++
date = 2013-10-01
title = "Part II: Big Data on the Desktop"
slug = "part-ii-big-data-on-the-desktop"
draft = false
+++

As [the previous post in this series](http://chrismeserole.com/signals/the-i-o-problem-or-why-big-data-takes-forever-to-process/) notes, large data takes a while to process not because processors are too slow, but because getting data from the hard drive to the processor takes a while. 

Ultimately the best way to deal with such data will probably be to shift your processing to a computer cluster, but if that's not an option, there are still a few things you can do to cut down query times dramatically. 

This post profiles two in particular: adding RAM, and parallelizing your code.


### ADDING RAM

As the [prior post mentions](http://chrismeserole.com/signals/the-i-o-problem-or-why-big-data-takes-forever-to-process/#kitchen), there are three places a computer "stores" data: the CPU cache, RAM (also known as memory), and the hard drive. Each of those places holds orders of magnitude more data than the last, but each is also orders of magnitude slower to access -- meaning the hard drive can hold way more data than the cache or RAM, but also takes way longer to reach.

One obvious way to speed things up then is to just [increase the amount of RAM on your computer](https://duckduckgo.com/?q=upgrade+ram+tutorial). The more RAM you have, the more data you can store in memory as opposed to the hard drive, and the faster you can process it.

Fortunately upgrading RAM is pretty straightforward, with the notable exception of unibody laptops. Most modern computers can also handle between 8GB and 32GB of total RAM, so if your data is big but not *that* big, buying more RAM is probably the way to go. 

That said, there is one caveat to all this: datasets can "blow up" by several multiples when you store them in memory, meaning a 5GB dataset can take up more than 10GB of RAM. Add in the fact that most operating systems now take up significant space as well, and you'll quickly hit limits on how much data you can actually store in memory on your personal computer. 

### PARALLELIZE WHERE POSSIBLE

If upgrading RAM isn't an option, another thing you can do is to 'parallelize' your queries, or spread them across all the cores of your processor. In the restaurant analogy I used in the last post, it's (very loosely) akin to having multiple waiters go and get your food rather than just one. As a result it can dramatically reduce query times on a local computer. 

To take advantage of all your computer's cores, there are two issues: first, you need to be doing operations that can actually be spread across multiple cores; second, you need to be using software that allows for parallelization. 

For basic data exploration, parallelizing your operations is usually possible. In common languages like [R](http://r-project.org) or [Python](http://www.python.org), it's just a question of installing the right packages and structuring both your code and data appropriately. By way of example, see [John Beieler's tutorial](http://johnbeieler.org/blog/2012/12/07/parallel-data-subsetting/) on how to subset the popular [GDELT dataset](http://gdelt.utdallas.edu/) using Python's [joblib library](http://pythonhosted.org/joblib/index.html). 

Parallelizing your operations won't get you down to second-level latency, but the improvements can still be impressive. On my desktop, for example, parallelizing alone cut the time it takes to subset GDELT by half. Meanwhile, both adding RAM *and* parallelizing the code cut the same operation by over two-thirds.

### BEST PRACTICES

If there's a specific subset of your data that you're interested in, you'll probably want to make a slow initial cut through the data, and then explore the subset using Python or R. 

By contrast, if you don't know which subset you want to use or the subset won't fit in RAM, then it's going to be tough to get the latency to the point where you can quickly interact with and explore the data on just your local machine alone. 

In that case, to explore your data efficiently, you can either draw and explore a random subset of your data, or you can shift the processing to a cluster, [which I discuss in the next post](http://chrismeserole.com/signals/big-data-in-the-cloud). 


