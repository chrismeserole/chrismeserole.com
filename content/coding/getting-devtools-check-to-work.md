+++
title = "Rd2pdf bug in devtools::check()"
date = "2015-04-13"
+++

I'm currently trying to compile my first package in RStudio. 

I was consistently getting the following warning: 

	* checking PDF version of manual ... 
	WARNING LaTeX errors when creating PDF version.

I didn't have a clue what was going on, and I wasn't having any success following Hadley Wickham's advice to check my LaTeX logs; I didn't even know where the logs were. 

Thankfully though, a bit of google discovered the problem: as [Matt Bannert noted](http://stackoverflow.com/a/29277121) in R 3.1.3 the commands `R CMD Rd2pdf` and `R CMD Check` expected `texi2dvi` to be in `/usr/bin/local/`, even though it was actually in `/usr/bin`. 

To fix it, I followed Matt's suggestion:

	# to check whether the same issue exists for you
	which texi2dvi
	# if so
	cd /usr/local/bin
	ln -s /usr/bin/texi2dvi

Worked like a charm, thankfully. After setting the symlink I haven't run into the same warning again.
