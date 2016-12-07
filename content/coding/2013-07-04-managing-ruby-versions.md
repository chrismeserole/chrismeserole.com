+++
date = 2013-07-04
title = "Managing Ruby Versions"
+++

For a project I'm working on, I needed to install the [command line interface](http://docs.aws.amazon.com/ElasticMapReduce/latest/DeveloperGuide/emr-cli-install.html) for AWS Elastic MapReduce.

The catch is that the CLI requires using ruby 1.8.7, and is not compatible with later versions. Bummer, because when I ran `ruby -v` I learned I was using 1.9.3. 

However, I had a vague memory of upgrading to 1.9.3 when I was either playing with Rails or installing Jekyll a couple months back. I also had a vague memory of upgrading using [RVM](http://rvm.io), the Ruby Version Manager.

To check, I ran `rvm -v`, and sure enough I'd already installed it. This was good news, because it makes managing multiple versions of ruby *much* easier. 

In my case, from here there were two ways to get to running 1.8.7.  

###The lazy way 

It turns out that RVM doesn't touch the original system ruby or its gems. So getting back to 1.8.7, which was preinstalled on my Macbook, was simple. All I had to do was run: 

	rvm use system
	ruby -v

Sure enough, I was back to 1.8.7. To get back to the 1.9.3, all I had to do was then run 
	
	rvm use default

But switching back and forth from the system ruby to versions controlled by the RVM didn't seem right. It felt like a better approach in the long run would be to run a version of 1.8.7 that RVM itself controlled.

### The better way

So, I switched back to back my rvm ruby and ran: 

	rvm install 1.8.7
	rvm use 1.8.7

That's it, surprisingly. 

Installing the new version takes a while, obviously, but it's time well spent. I feel like I'm on much more solid footing now, and not just for making use of the Amazon EMR CLI.
	