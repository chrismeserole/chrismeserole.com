---
title: "What Went Wrong"
date: "2016-11-09T19:39:59-04:00"
---

In 1936, the Literary Digest infamously predicted a [landslide win][landon] for Alf Landon over FDR. In 1948, Gallup even more infamously had Dewey decisively [besting Truman][tribune]. And now, in 2016, yet another reckoning: "Clinton Trumps Trump" has yielded to "[Trump Triumphs][nyt head]." 

[landon]: https://www.qualtrics.com/blog/the-1936-election-a-polling-catastrophe/
[tribune]: http://www.chicagotribune.com/news/nationworld/politics/chi-chicagodays-deweydefeats-story-story.html
[nyt head]: http://money.cnn.com/2016/11/09/media/election-2016-election-night-newspaper-headlines/

No doubt it would be easy to lump these failures together. However, it would also be a mistake. Landon's hopes and Dewey's aspirations ultimately lost out to fundamental errors in polling methodology. By contrast, Clinton fell prey to something far more befitting the 21st century. The problem wasn't with the polls, but with how they were aggregated --- or more specifically, with the sophisticated models that were built on top of them. 

Where the models went wrong was this: they assumed that the fifty state elections were largely independent. Think of the election as a series of fifty coin flips. One way to model that series is by flipping fifty distinct coins exactly once, with each coin biased in a way that's both unique and random. The allure of this model is its simplicity. If each state's bias is independent from the others, then over fifty states the biases will ultimately cancel out, and the actual results will fall in a narrow band around the national polling average. (As best I can tell, this is why Huff Post's model had a [win probability for Hillary][hp] of 98%.) 

[hp]: http://www.huffingtonpost.com/entry/nate-silver-election-forecast_us_581e1c33e4b0d9ce6fbc6f7f

However, that model is almost certainly not true. In reality, many state elections are likely to be biased in a similar way. In that case, the election overall is more like fifty flips of the same biased coin. If we model the election that way, then the actual election results will converge on the polling average *plus the consistent bias*. The polls for PA, NC, FL, MI, and WI, among others, suggest that this is likely what happened: the polling error in each of these states [moved in the same way][graph], due to mistaken likely-voter estimates for white citizens without a college degree. In that regard, it's not a concidence that Nate Silver, the aggregator who most strongly accounted for the possibility of correlated state-level errors, also had the greatest uncertainty in his forecasts.

[graph]: https://twitter.com/jameskanag/status/796303144351399936

So where to go from here? 

To be sure, the polls themselves could be improved. \[1\] But again, they were not the problem. The median polling error was only around 4%, and even then the polls got the popular vote right. It's the aggregation that needs work. And to be clear, it's not that the aggregators should have identified the specific bias among white, non-college voters --- it's that they should have accounted for the possibility that that kind of bias might exist. In the next election, aggregators either need to pay more attention to how they model correlated errors, or publish clear disclaimers about potential sources of uncertainty that are not represented in their models. 

Finally, one last point. This is the same mistake that contributed to the housing bubble a decade ago, just prior to Obama entering office. As with the aggregators today, the banks back then assumed that state and regional real estate markets were all independent --- many separate coins, so to speak, rather than one coin flipped many times. In retrospect treating sub-national errors in this way was clearly wrong then and is clearly wrong now. \[2\]  

The first time we made this mistake it was devastating for millions. But at least then we could argue, with something of a straight face, that we didn't know better. 

We have no such luxury here.


<br />

NOTES

[1] In particular, there need to be greater incentives for pollsters to release their raw data. When the Times commissioned a [survey of Florida voters][nyt] last September and asked five separate teams to analyze it, it's telling that the one team who got Florida "right" also used a unique likely voter screen. Ideally, this kind of open analysis should be the norm, not the exception. 

[wiki]: https://en.wikipedia.org/wiki/Social_desirability_bias
[nyt]: http://www.nytimes.com/interactive/2016/09/20/upshot/the-error-the-polling-world-rarely-talks-about.html
[imai]: http://imai.princeton.edu/research/files/comp.pdf

[2] I'd also go a step further than this, and suggest that in this case the bias probably wasn't just correlated across states in the U.S. If you had tried to model U.S. and U.K. politics together one year ago, you likely would have found that the national-level errors were correlated too --- i.e., that the polls had a similar downward bias in their likely-voter screens for white non-college voters.
