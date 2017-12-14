+++
title = "Git Workflow with Jekyll"
date = "2013-02-13"
+++

Early in 2013 I switched over to using Jekyll for this site and a couple others. 

Here's the workflow I use to edit one of the sites. First, I open terminal or Powershell and start a new branch: 

	cd ~Dropbox/Sites/mysite
	git checkout -b draft

Then I edit relevant files and commit the changes: 

	git commit -a -m 'Edited such-and-such file'

Or I'll add a file and commit the change: 

	git add path/to/file
	git commit -m 'Added file'

To preview the changes, I'll rebuild the site: 

	jekyll --server

And then head to `localhost:4000` in Chrome. 

If satisfied, I'll commit the changes again: 

	git commit -a -m 'Rebuilt site'

If I'm done, I'll then merge the changes into the master: 

	git checkout master
	git merge draft
	git branch -d draft

If I created or modified content only and I'm done for the day, I'll then tag it by date: 

	git tag d01-01-13

If I modified the structure or style at all, I'll then also tag it using versions: 

	git tag v0.1
