+++
date = 2013-02-12
title = "Git and Github Notes"
+++

*These are just notes of my experience with git and github. If you know of better/best practices, by all means let me know.*

Initially I had trouble running `fetch` or `push` to my github repository. Every time I ran fetch, for instance, I got:

	fatal: The remote end hung up unexpectedly

The reason I was getting this -- I think -- is that I ran

	git remote add origin git://github.com/username/myrepo

whereas if you visited `http://github.com/username/myrepo`, the setting was for `https` rather than `git`.
Regardless, I got fetching to work by running:

	git remote add origin https://github.com/username/myrepo

The moral of the story: pay attention to the protocol.

#### commit changes efficiently
Using `-a` automatically stages any files you previously tracked.

	git commit -a -m 'added new edit'

The benefit: you don't have to run `git add` for every file you change. 

Remove file from staging area but leave on hard drive:

	git rm --cached somefile.txt

Create and move to new branch: 

	git checkout -b newbranchname


Show the diffs from the last two commits:
	
	git log -p -2


More on [git logs here](http://git-scm.com/book/en/Git-Basics-Viewing-the-Commit-History).

How to [unmodify a modified file here](http://git-scm.com/book/en/Git-Basics-Undoing-Things) (ie, how to change back to previous version). 

[Stackoverflow post](http://stackoverflow.com/questions/292357/whats-the-difference-between-git-pull-and-git-fetch) on the difference between `git pull` and `git fetch`: basically, `pull` both fetches *and* merges from remote into local. 

