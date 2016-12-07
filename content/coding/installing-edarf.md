+++
title = "Installing Edarf"
date = 2015-10-21
+++

I've been meaning to check out random forests in general and the [edarf package](https://github.com/zmjones/edarf) in particular for a while now -- at least since [Zach Jones](https://twitter.com/joneszm) and [Fridolin Linder](https://twitter.com/fridolinlinder) posted [their paper on Random Forests and EDA](http://media.wix.com/ugd/13cbcb_b644c0023366475ab6cb640969303a62.pdf) last spring.

I finally had a chance to go through package, and it's as great as I'd hoped it would be. The standard errors and partial dependence plots point toward a future where ML plays a much larger role in political science overall rather than just the subset devoted to prediction. 

All that said though, edarf is still early going. 

For anyone trying to get up and running with edarf as well, below are a few issues I ran into while walking through Zach's [IMC tutorial for how to use edarf](https://github.com/zmjones/imc/blob/master/edarf.R). 

See the appendix for my exact R and OS versions.


##### 1. Fortan compiler

I started by running:

	devtools::install_github("zmjones/edarf")

That produced the following error message:

	ld: warning: directory not found for option '-L/usr/local/lib/gcc/x86_64-apple-darwin13.0.0/4.8.2'
	ld: library not found for -lgfortran
	clang: error: linker command failed with exit code 1 (use -v to see invocation)
	make: *** [edarf.so] Error 1
	ERROR: compilation failed for package 'edarf'

Based on the `clang: error` and initial path it seemed like the compiler was having an issue finding the right version of fortran. I'd updated to 10.10 lately and reinstalled Xcode, so I thought that might have something to do with it.

After a bit of googling, it looks like the issue was that edarf relies on RcppArmadillo, which in turn relies on a version of gfortran that is not shipped with Mac OS X 10.9. Either the bug also applies to 10.10 or I botched the upgrade.

At any rate, [to fix the issue I ran](http://thecoatlessprofessor.com/programming/rcpp-rcpparmadillo-and-os-x-mavericks-lgfortran-and-lquadmath-error/): 

	curl -O http://r.research.att.com/libs/gfortran-4.8.2-darwin13.tar.bz2
	sudo tar fvxz gfortran-4.8.2-darwin13.tar.bz2 -C /

Installing edarf worked like a charm after that.


##### 2. Version of party()

edarf also relies on a forked version of the [party package](https://cran.r-project.org/web/packages/party/):

	devtools::install_github("zmjones/party", subdir = "pkg")

The package installed ok, but I couldn't call the library at first. 

I'd already called `library(party)` in my environment -- I think while I was going through [Zach's great international methods colloquium presentation](http://www.methods-colloquium.com/#!Zachary-Jones-Data-Mining-as-Exploratory-Data-Analysis/clv6/560ee37a0cf2f0ed7a2d727b) -- and there seemed to be a conflict I couldn't get around. 

After restarting R though I could load the library fine.


##### 3. plot_imp() error

Most of the plots in the tutorial worked well. But then I ran the following (lines 30-31):

	imp <- variable_importance(fit, features, type = "local", oob = TRUE, parallel = TRUE)
	plot_imp(imp)

That yielded this:
	
	Error in as.character(x$label) : 
	cannot coerce type 'closure' to vector of type 'character'

Based on the coercion/closure issue, my hunch is that `plot_imp()` is trying to coerce some function itself to character rather than that function's output.


##### 4. RStudio Abort Cycle

After working through the tutorial and then using my own data, eventually I somehow got into a cycle in RStudio where something in my current project environment was causing RStudio to abort, but then since RStudio auto-loads the last project environment, it would immediately run into the same issue again. 

Eventually I just had to shut down the computer and restart everything. 

I didn't bother trying to reproduce the issue, which I think had something to do with socket settings and not edarf.


##### Conclusion

Bugs aside the package is great. Can't wait to see where it goes.

--

APPENDIX

Mac OS X version: 10.10.4

R Version Info:

	platform       x86_64-apple-darwin13.4.0   
	arch           x86_64                      
	os             darwin13.4.0                
	system         x86_64, darwin13.4.0        
	status                                     
	major          3                           
	minor          2.1                         
	year           2015                        
	month          06                          
	day            18                          
	svn rev        68531                       
	language       R                           
	version.string R version 3.2.1 (2015-06-18)
	nickname       World-Famous Astronaut   