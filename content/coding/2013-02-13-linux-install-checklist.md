+++
date = "2013-02-13"
title = "Linux Install Checklist"
+++

*Last Updated: Feb 16, 2013.*

Just installed Ubuntu 12.10 for the first time, on my Asus UL30VT from an external DVD.

The following is a checklist I've been putting together for how to set up a Linux install. 


####Get Spotify Working

First, open `/etc/apt/sources.list`. This will open a dialog box asking for a repository. Type this: 

	deb http://repository.spotify.com stable non-free

Then, open terminal and run: 

	sudo apt-get update
	sudo apt-get install spotify-client	

That should do it. More on Spotify and Linux [here](https://www.spotify.com/us/download/previews/) and [here](https://www.spotify.com/us/blog/archives/2010/07/12/linux/).
 

###Get Flash working

Here's the contents from an `install_flash.sh` script I put together:

	sudo apt-add-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
	sudo apt-get update
	sudo apt-get install flashplugin-installer

That said ... unlike the rest of these I'm writing about the Flash installation long after the fact. If memory serves, I had to manually move a `flashplayer.so` file into the `chromium/plugin` directory, and then manually enable it from the browser. 


###Adjust the launchbar

Go to `System Settings -> Appearances -> Behaviors` and set the launch bar on the left to hide automatically.

###Install git & vim:

This fairly straightforward:

	sudo apt-get install git-core
	sudo apt-get install gitk

Install vim:

	sudo apt-get install vim

### Get Wuala

Download [Wuala for Linux](http://www.wuala.com/en/download/linux). Wuala requires Java, but Java 7 comes pre-installed with Ubuntu so there's no need to download it.


### Setup Rails and Jekyll
Get rails and jekyll going:

	sudo apt-get install rubygems
	sudo apt-get install rails
	sudo apt-get install ruby1.9.1-dev
	gem install jekyll
	gem install rdiscount

Note: not sure rubygems is needed for install, since we're not running the standard gem install rails

### Install R


First, open the file `/etc/apt/sources.list`. Click on the "Other Software" tab. Then click the "Add" button and enter the following:

	deb http://watson.nci.nih.gov/cran_mirror/bin/linux/ubuntu quantal/

At that point you should be prompted to enter your password. 

Once the repository has been added, run this in terminal:

	sudo apt-get update
	sudo apt-get install r-base

That might take a while, but when it's done, you should have R installed on your system. 

However, at this point you can only run it via command line. For a GUI, there are two options. The first and probably best is to download and install [RStudio](http://www.rstudio.com/ide/download/desktop). 

The other option is install rkward, which can be done as follows:

	sudo apt-get install rkward

UPDATE: You should probably be able to simply adding the repository as follows: 

	sudo apt-add-repository "deb http://watson.nci.nih.gov/cran_mirror/bin/linux/ubuntu quantal/"


