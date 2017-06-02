+++
date = 2013-12-12
title = "Part III: Big Data in the Cloud"
slug = "part-iii-big-data-in-the-cloud"
+++

As I mention [in the previous post](http://chrismeserole.com/signals/big-data-on-the-desktop/), there are a few ways you can speed up analysis of big data on your desktop or laptop.

However, the fastest/most efficient solution is often to just shift data storage and processing to a networked computer cluster. Generally speaking, this solves the [I/O problem](http://chrismeserole.com/signals/the-i-o-problem-or-why-big-data-takes-forever-to-process/) by splitting the processing across multiple computers rather than one.

Fortunately there are now several options available for large-scale data storage and analysis, with varying degrees of cost-effectiveness. Most solutions use Hadoop for data storage and then one of the following open-source solutions for analysis: 

* [Hive](http://hive.apache.org/)
* [Pig](http://pig.apache.org/)
* [Impala](https://github.com/cloudera/impala)
* [Spark](http://spark.incubator.apache.org/) / [Shark](https://github.com/amplab/shark)
* [Presto](https://www.facebook.com/notes/facebook-engineering/presto-interacting-with-petabytes-of-data-at-facebook/10151786197628920)

With the exception of Presto, which was recently released by Facebook and is designed more for petabyte-scale analysis, I profile each of those options below. 

### Hadoop + Hive

At this point, probably the most straightforward way to analyze your data in the cloud is to use [Hadoop](http://hadoop.apache.org/) to store your data and then [Hive](http://hive.apache.org/) to query it.

Fortunately, companies such as Amazon have now abstracted away most of the pain points involved with setting up your own Hadoop cluster, so getting up and running with Hadoop is relatively painless. If you're looking for a way to try out Hadoop and Hive, I highly recommend [this excellent tutorial by John Beieler](http://johnbeieler.org/blog/2013/06/16/using-hive-with-social-science-data/).

### Hadoop + Impala + Parquet

Although Hadoop and Hive are great, for even a 50GB dataset it can still take a few minutes for queries to finish. 

However, since exploring data is generally an iterative process, getting the query time down as low as possible makes a huge difference. 

At present probably the most cost-effective way to reduce the query time is to use a combination of [Impala](https://github.com/cloudera/impala) and [Parquet](https://github.com/Parquet). The former is an improved query engine developed by [Cloudera](http://www.cloudera.com/content/cloudera/en/products/cdh/impala.html). The [latter is a novel storage format](http://blog.cloudera.com/blog/2013/07/announcing-parquet-1-0-columnar-storage-for-hadoop/) developed by both [Cloudera and Twitter](http://blog.cloudera.com/blog/2013/03/introducing-parquet-columnar-storage-for-apache-hadoop/) that stores data in columns rather than rows, and as a result allows queries to be run as [vectorized operations](http://en.wikipedia.org/wiki/Vectorization_(parallel_computing)). (There's a lot of other fancy stuff it does too, but the gist is that Parquet is a storage format that makes data retrieval/processing really, really efficient.)

All told, the performance gains are significant: using Impala and Parquet, [Travis Pinney](https://twitter.com/tlpinney) was able to get query times down to a few seconds or less. 

To try Impala and Parquet yourself, either follow [Travis's instructions on Github here](https://github.com/tlpinney/funnelcloud/tree/master/clouds/gdelt) or a more fleshed-out [tutorial by Pierre-Yves Taunay on the GDELT blog](http://gdeltblog.wordpress.com/2013/11/06/fast-gdelt-queries-using-impala-and-parquet/).

### Spark/Shark ### {#spark-shark}

Another way to reduce the query time dramatically (for GDELT, also in the single seconds) is to use Hadoop coupled with either [Spark](http://spark.incubator.apache.org/) or [Shark](https://github.com/amplab/shark).

Run out of [Berkeley's AMPLab](https://amplab.cs.berkeley.edu/), what Spark/Shark does is load your dataset into memory *across an entire cluster*. In a way, it's very similar to Hive --- Shark even uses the identical syntax --- except instead of having each machine query the portion of data that's on its hard drive, each machine instead queries the data that's in its RAM. 

The one catch is that because RAM is comparatively expensive, if all you're interested in are basic counts, subsetting, etc, Spark is not cost-effective compared with Impala and Parquet, much less Hive. It'll cost up to 10x more for the same performance times. 

However, the real value of Spark isn't just its basic query speeds. Instead, it's that because the entire dataset resides in memory, you can, for instance, run a k-means algorithm or fit a hierarchical model without constantly shuffling data in and out of memory. Further, since Spark has a Python API, you can use any of Python's scientific computing libraries to analyze the in-memory datastore as well. 

If you want try out Spark/Shark, [see the next post](http://chrismeserole.com/signals/shark-spark-gdelt-tutorial) or [the Shark documentation](https://github.com/amplab/shark/wiki#user-documentation). 
For more about the project itself, this [Wired article](http://www.wired.com/wiredenterprise/2013/06/yahoo-amazon-amplab-spark/) is a good place to start. 

### Best Practices

At this point, for basic data exploration using Impala and Parquet is probably the most cost-effective way to query or subset large datasets. 

However, once you have a small dataset that you want to query quickly or run more sophisticated operations on, it may be worth spinning up a small cluster and switching to Spark/Shark. 

Accordingly, the next post is [a tutorial for getting Shark up and running with the popular GDELT dataset](http://chrismeserole.com/signals/shark-spark-gdelt-tutorial).