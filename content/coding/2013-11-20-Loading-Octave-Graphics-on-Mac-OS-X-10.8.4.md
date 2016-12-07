+++
date = 2013-11-20
title = "Loading Octave Graphics on Mac OS X 10.8.4"
+++

I decided to try my hand at Octave today, to see if it simplifies model prototyping. 

One issue was that Octave wasn't connecting properly to its graphics library. Anytime I ran `hist()`, for example, I would get: 

	dyld: Library not loaded: /usr/X11/lib/libfreetype.6.dylib
	  Referenced from: /usr/X11R6/lib/libfontconfig.1.dylib
	  Reason: Incompatible library version: libfontconfig.1.dylib requires version 13.0.0 or later, but libfreetype.6.dylib provides version 10.0.0
	dyld: Library not loaded: /usr/X11/lib/libfreetype.6.dylib
	  Referenced from: /usr/X11R6/lib/libfontconfig.1.dylib
	  Reason: Incompatible library version: libfontconfig.1.dylib requires version 13.0.0 or later, but libfreetype.6.dylib provides version 10.0.0
	/Applications/Gnuplot.app/Contents/Resources/bin/gnuplot: line 71:   865 Trace/BPT trap          GNUTERM="${GNUTERM}" GNUPLOT_HOME="${GNUPLOT_HOME}" PATH="${PATH}" DYLD_LIBRARY_PATH="${DYLD_LIBRARY_PATH}" HOME="${HOME}" GNUHELP="${GNUHELP}" DYLD_FRAMEWORK_PATH="${DYLD_FRAMEWORK_PATH}" GNUPLOT_PS_DIR="${GNUPLOT_PS_DIR}" DISPLAY="${DISPLAY}" GNUPLOT_DRIVER_DIR="${GNUPLOT_DRIVER_DIR}" "${ROOT}/bin/gnuplot-4.2.6" "$@"
	/Applications/Gnuplot.app/Contents/Resources/bin/gnuplot: line 71:   871 Trace/BPT trap          GNUTERM="${GNUTERM}" GNUPLOT_HOME="${GNUPLOT_HOME}" PATH="${PATH}" DYLD_LIBRARY_PATH="${DYLD_LIBRARY_PATH}" HOME="${HOME}" GNUHELP="${GNUHELP}" DYLD_FRAMEWORK_PATH="${DYLD_FRAMEWORK_PATH}" GNUPLOT_PS_DIR="${GNUPLOT_PS_DIR}" DISPLAY="${DISPLAY}" GNUPLOT_DRIVER_DIR="${GNUPLOT_DRIVER_DIR}" "${ROOT}/bin/gnuplot-4.2.6" "$@"
	error: you must have gnuplot installed to display graphics; if you have gnuplot installed in a non-standard location, see the 'gnuplot_binary' function

So, after stumbling across this [SO question](http://stackoverflow.com/questions/4175411/plotting-with-octave-after-most-recent-mac-osx-update), here's how I resolved the issue. First, I ran: 

	vim /Applications/Gnuplot.app/Contents/Resources/bin/gnuplot

Then, in vim, I ran: 

	:%s/DYLD_LIBRARY_PATH/DYLD_FALLBACK_LIBRARY_PATH/gc
	:wq

That worked like a charm. 
