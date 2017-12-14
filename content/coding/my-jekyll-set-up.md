+++
title = "My Jekyll Set-Up"
date = "2013-02-16"
+++

I was pretty frustrated with how slowly this site was running, so I recently followed the herd and moved over to Jekyll. 

The transition was pretty smooth, but there were two issues I encountered. 

### Redirecting the Index

I wanted the homepage for `chrismeserole.com` to forward to my `/about/` page. In wordpress, this is pretty trivial -- I think it was just a check box in the settings tab. 

But for Jekyll it's not so simple. I'm sure there's a better way to do this, but for now the best I could manage was to overwrite the `index.html` file in the root directory with this: 

	<!DOCTYPE html>
	<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="refresh" content="0;url=/about" />
	</head>
	</html>

### Setting up category blogs

The other challenge was setting up what are, in effect, separate blogs: one for my thoughts on life, politics, culture, reviews, etc, and another for everything related to coding. Since I wanted the layout/design to remain consistent though, I also wanted to do this with a single jekyll install. 

The best way to do that was to setup separate sub-directories in the root, one for `/life` and another for `/coding`. Each of those folders then has its own `_posts` sub-directory, as well as its own `index.html` and `feed.xml`. 

To make sure the urls work, I then added the following line to `_config.yml`: 

	permalinks: /:categories/:title

The other thing to note is that this means that any posts in the root `_posts` sub-directory effectively serve as pages, provided there's no category listed in the yml front matter.

### Going Forward

There's still a little more I'd like to do, such as setting up separate sidebars and archives for each category, etc. 

I'll update this post as I get to them. 
