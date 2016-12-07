+++
date = 2013-12-10
title = "Part I: The I/O Problem, Or Why Big Data Takes Forever to Process"
+++

As I mentioned in the [introduction to this series](http://chrismeserole.com/signals/big-data-and-social-science-introduction/), large datasets are increasingly common in social science, but they're also difficult to deal with efficiently. 

In the next few posts I'll look at various solutions to that problem. First though we need to figure out what's causing it to begin with. 

### Big Data: What's the Problem? 

So: why exactly does it take so long to parse large datasets, even with modern computers?  

The intuitive answer is that the processor must be the problem. Get a newer, snappier processor, and surely the query time would come down. 

Yet it turns out the processor isn't really the problem. A *slow* processor today is 1GHz, meaning the processor can run through 1 billion  cycles per second. For a dataset with "only" 200 million observations, in theory even a slow computer should be able to subset it very quickly. 

Yet on a modern Macbook, a single pass through a dataset of that size can take 45 minutes rather than 4 to 5 seconds. So what's going on? 

In technical terms, large datasets face an [I/O-bound](https://en.wikipedia.org/wiki/I/O_bound) rather than a [CPU-bound](https://en.wikipedia.org/wiki/CPU_bound). Or in plain English: the bottleneck isn't in the processor, it's in getting the data to and from the processor. 

For most of your computer's billion-plus cycles each second, the processor is just twiddling its thumbs while waiting for the data to come in. Too much data has too far to travel (and on too few potential routes) to take advantage of how fast the processor is. 


### Hard Drives and ... Kitchens? ### {#kitchen}

By way of (a very rough) analogy, to understand the problem here think of how you get food in a buffet restaurant. In general there are three places where such a restaurant "stores" food: your plate, the buffet table, and the back kitchen. 

Similarly, in a computer there are three places that data is "stored." The first is [a small set of caches on the processor itself](http://en.wikipedia.org/wiki/CPU_cache). If the data the processor needs is already in the processor's cache, it can just take that data and immediately use it -- just like when the food you want is already on your plate, you can just go ahead and eat it. The only catch is that the speed comes with a cost: you can't store much data in your processor's cache, just as you can't store much food on a single plate.

Meanwhile, the second place the processor searches is ["main memory", or RAM](http://continuations.com/post/12194075974/tech-tuesday-main-memory-dumb-lazy-and-slow). In this case, data in RAM is analogous to food on a buffet table. Getting to it is still pretty fast, but it's at least an order of magnitude slower than if the data was already in the processor's cache.  Moreover, this level of storage is also constrained by size; you can fit a lot more data in memory than in the cache, but not as much data as you may need. 

Finally, the third place your computer stores data is your [hard drive](http://continuations.com/post/12510627878/tech-tuesday-storage-oh-my-how-it-has-grown). As with a restaurant kitchen, the advantage of this layer is that you can store a *lot* of data in it. Once again though, the catch is that it takes a lot more time to access. Think about what happens when you want some salad but there's none on your plate or the buffet table. In that case, someone has to go back into the kitchen, open the freezer, figure out where the salad is, and then grab it. The end result is that it's going to take several orders of magnitude longer to get your food. The same is true for your hard drive. Although you can speed things up somewhat by using an [SSD](http://en.wikipedia.org/wiki/Solid-state_drive), getting your data to and from the hard drive is still going to be orders of magnitude slower than getting the same data to and from the CPU cache or RAM. 

### GOING FORWARD

To sum up: the reason it takes so long to query big datasets is that shuffling data to and from your processor takes a while, particularly if the data is all the way over on the hard drive.

Obviously there's a bit more to the problem than that, but the gist is that size of big data compounds whatever I/O constraints your computer may have. Fortunately though there are a few things you can do to at least cut down on the query times, which we'll begin to look at in [the next post](http://chrismeserole.com/signals/big-data-on-the-desktop/).

