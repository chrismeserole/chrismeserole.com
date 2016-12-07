+++
date = 2013-02-26
title = "Pushing Jekyll to s3"
+++

I have two workstations. The first is a custom built desktop that runs Windows (more on this later, hopefully). The second is an Asus laptop that primarily runs Linux. 

I recently moved my sites over to Jekyll. I host them locally in a Dropbox directory, then push them to s3. 

On Windows, I use jekyll-s3 to do the push. It's convenient and works well. Just run `gem install jekyll-s3` and then to push you run `jekyll-s3` (the first time you do this, it walks you through configuration).

On Ubuntu, I couldn't get the jekyll-s3 gem to install. So I use [s3cmd](http://s3tools.org/s3cmd). Installing was straightforward, just run:

	sudo apt-get install s3cmd

But configuring s3cmd I ran into a stupid roadblock: my Secret Access Key contains some `I` and `l` characters, which look exactly the same in my browser. I tried to configure my s3cmd in the terminal by guessing which were "L"s and which were "I"s, never correctly, before I finally realized I could cut and paste them out of the browser and into a text editor that would make the difference obvious. Why it took me that long to realize I don't know, but it worked like a charm once it did. 

For the encryption and other default config details, I followed the basic config setup for s3cmd using [this tutorial here](http://www.saltycrane.com/blog/2010/02/s3cmd-notes/).

Once it was configured, I saved the following as `create-md.sh` in the root folder for all my sites:
	
	#!/bin/bash
	cd /path/to/mysite.com
	jekyll --server

I also saved the following as `push-md.sh` in the root folder for all my sites:

	#!/bin/bash
	cd /path/to/mysite.com
	s3cmd put --delete-removed _site/ s3://mydomain.com
	echo 's3cmd has been processed'

Ideally I'd like to combine the scripts (or use a git hook), but I haven't found a way to programmaticaly shut down jekyll once it's regenerated the site. Doing it this way also lets me check the changes on a local server first. 

I then set an alias for each `.sh` file, so that all I have to do is open terminal and type `create-md`, check the site on a browser, and then `push-md` to push my site to s3. 

NB: A good list of all the options for the [s3cmd commands is here](http://manpages.ubuntu.com/manpages/intrepid/man1/s3cmd.1.html).  
