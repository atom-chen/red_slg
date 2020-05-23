#!bin/sh

scons -c

scons -j18 -Q release=1
scons install -Q release=1
	
cd ../../lib/internal
svn ci -m ""
cd -