#!bin/sh

scons -c

scons -j18 -Q
scons install -Q
	
cd ../../lib/internal
svn ci -m ""
cd -