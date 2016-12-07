+++
date = 2013-02-16
title = "Installing Jekyll on Windows"
+++

There are two ways to install jekyll: the easy way and the (relatively) hard way. 

####THE EASY WAY

The easy way is to download [Railsinstaller](http://railsinstaller.org). It sets up ruby, rails, bundler and other packages in `C:\Railsinstaller`. (Note: since I already have `git` installed elsewhere, I unchecked the install dialog box for `git` and `ssh`.) 

Once you've got Railsinstaller up and running, open powershell and run:

	cd C:/Railsinstaller 
	gem install jekyll

I tried to run `gem install rdiscount` as well, but couldn't get it to work. As a result, in the `_config.yml` file for any jekyll project I create, I have to add `markdown: kramdown`. (The other option is `markdown: maruku`, but that also doesn't work on Windows.)


####THE (RELATIVELY) HARDER WAY

(*Note*: since Railsinstaller alters the `PATH`, if you've ever installed ruby before, [make sure you amend](http://www.computerhope.com/issues/ch000549.htm) your `PATH` variable to not include ruby before you start this.)

First, go to [rubyinstaller.org/downloads](http://rubyinstaller.org/downloads). 

Then, download ruby 1.9.3 *as well as* the dev kit. 

Run the ruby-1.9.3 executable. When prompted, be sure to check the box for adding ruby to your path; without this, ruby commands won't work in powershell. Also check the other boxes. Finally, specify that the ruby files should be installed to `C:/ruby193`. 

Now extract the devkit files into `C:\RubyDevKit`.

Open powershell and run:
 
	cd C:\RubyDevKit
	ruby dk.rb init
	ruby dk.rb install

From within the same devkit directory, now run:

	gem install jekyll
	gem install rdiscount

Note: as with the easy method, I couldn't get `rdiscount` to work here either. So I also had to add `markdown: kramdown` to the `_config.yml` file of my projects using this method as well. 
