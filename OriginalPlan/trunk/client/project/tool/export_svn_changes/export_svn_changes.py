#!/usr/bin/env python
# -*- coding: UTF-8 -*-
import glob
import os
import sys
import subprocess
import re

# export_changes.py repository target_dir old_ver [new_ver]
def __main__():
	print("useage:export_svn_changes.py repository target_dir old_ver [new_ver]")
	repository	=	sys.argv[1]
	target_dir	=	sys.argv[2]
	old_ver		=	sys.argv[3]
	new_ver		=	None
	if len(sys.argv) >= 5:
		new_ver		=	sys.argv[4]
	
	cmd			= ""
	if new_ver:
		cmd = "svn diff --summarize -r%s:%s %s"%(old_ver, new_ver, repository)
	else:
		cmd = "svn diff --summarize -r%s %s"%(old_ver, repository)
	
	ps = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)

	list = ps.stdout.read()
	
	#print list
	pattern = re.compile("^(A|AM|M)\s+([^\r\n]+)", re.I | re.M)
	list = pattern.findall(list)
	#print list
	#return
	pss = []
	for i in list:
		fullpath = i[1].replace(repository, target_dir)
		#print i[1], fullpath
		(fdir, fname)=os.path.split(fullpath)
		
		if not os.path.isdir(fdir):
			os.makedirs(fdir)
			if not os.path.isdir(fdir):
				print("mkdirs %s error"%(fdir))
				sys.exit(-1)
			
		if new_ver:
			cmd = "svn export --force -r %s \"%s\" \"%s\""%(new_ver, i[1], fullpath)
		else:
			cmd = "svn export --force \"%s\" \"%s\""%(i[1], fullpath)
		print(cmd)
		#pss.append(subprocess.Popen(cmd))
		ps = subprocess.Popen(cmd)
		ps.wait()
		
	#for ps in pss:
		#ps.wait()
		
__main__()
