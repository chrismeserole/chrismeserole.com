+++
title = "Installing Valgrind on Mac OS X Yosemite"
date = 2014-11-01
+++

I decided to learn a lower level like like C, in part because I want to learn about memory management, leaks, etc.

While following Zed Shaw's tutorial I got stuck on installing Valgrind, which isn't yet supported on Yosemite.

To get up and running, I generally followed Taras Kalapun's tutorial, which installs Valgrind from svn. However, initially I ran into issues because aclocal and autoconf weren't installed. Then I ran into issues because XCode wasn't installed.

Below is how I got everything work.

###ACLOCAL AND AUTOCONF

After tinkering with yet another tutorial, first I installed autoconf:

	curl -O http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz
	tar -xzvf autoconf-2.69.tar.gz
	cd autoconf-2.69
	./configure
	make
	make install

Second, I installed aclocal:

	curl -O http://ftp.gnu.org/gnu/automake/automake-1.14.1.tar.gz
	tar -xzvf automake-1.14.1.tar.gz
	cd automake-1.14.1
	./configure
	make
	make install

Finally, with both installed, I could now run Taras' tutorial:

	svn co svn://svn.valgrind.org/valgrind/trunk valgrind
	cd valgrind
	./autogen.sh
	./configure
	make
	make install

Just kidding! When I ran make, I got this error:

	Making all in coregrind
	make[2]: *** No rule to make target `/usr/include/mach/mach_vm.defs', needed by `m_mach/mach_vmUser.c'.  Stop.
	make[1]: *** [all-recursive] Error 1
	make: *** [all] Error 2

After some googling, it seemed the new problem was XCode.

###INSTALLING COMMAND LINE X-CODE

Thanks to Jinhui Zhang's tutorial, I realized that even though I had XCode installed in my applications, I didn't have it installed in my command line.

So, I ran:

	xcode-select --install

Then I got some coffee. xcode is a beast to install.

###MAKE VALGRIND

Once XCode was installed, I could finally finish the Valgrind install. I changed back to my valgrind directory, then ran:

	make
	make install

And with that, finally, Valgrind worked like it was supposed to. I ran Zed's tutorial and my output matched his.

Phew.