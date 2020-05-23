# -*- coding: UTF-8 -*-
import glob
import os
import sys
import subprocess

def __main__():
	if len(sys.argv) < 3:
		print('参数过少')
		sys.exit(-1)
	
	srcdir = sys.argv[1]
	destdir = sys.argv[2]
	if not os.path.isdir(srcdir):
		sys.exit(-1)
	
	#for fn in glob.glob(srcdir + os.sep + '*'):
	#	print fn
	
	
	if not os.path.isdir(destdir):
		print(os.makedirs(destdir))
		#sys.exit(-1)
	
	cmd = "del /f /q \"%s\\*.*\""%(destdir)
	print(cmd)
	os.system(cmd)
	
	#for root, dirs, files in os.walk(srcdir + os.sep):
	pss = []
	for fpath in glob.glob(srcdir + os.sep + '*.png'):
		(fdir, fname)=os.path.split(fpath)
		print fdir, fname, os.path.splitext(fname)
		cmd = '"D:\\Program Files (x86)\\CodeAndWeb\\TexturePacker\\bin\\TexturePacker" --sheet "' + destdir + os.sep + os.path.splitext(fname)[0] + '.pvr.ccz" --format cocos2d --max-width 2048 --max-height 2048 ' + '--shape-padding 0 --border-padding 0 --inner-padding 0 --disable-rotation --trim-mode None --size-constraints AnySize ' +	'--opt RGBA8888 "' + fpath + '"'
		print(cmd)
		#os.system(cmd)
		pss.append(subprocess.Popen(cmd))
		#for fname in files:
		#	print fname
	for ps in pss:
		ps.wait()
		
	for fpath in glob.glob(srcdir + os.sep + '*.jpg'):
		(fdir, fname)=os.path.split(fpath)
		print fdir, fname, os.path.splitext(fname)
		cmd = '"D:\\Program Files (x86)\\CodeAndWeb\\TexturePacker\\bin\\TexturePacker" --sheet "' + destdir + os.sep + os.path.splitext(fname)[0] + '.pvr.ccz" --format cocos2d --max-width 2048 --max-height 2048 ' + '--shape-padding 0 --border-padding 0 --inner-padding 0 --disable-rotation --trim-mode None --size-constraints AnySize ' +	'--opt RGBA5551 "' + fpath + '"'
		print(cmd)
		#os.system(cmd)
		pss.append(subprocess.Popen(cmd))
		#for fname in files:
		#	print fname
	for ps in pss:
		ps.wait()
	#sys.exit(0)
	
	
	
__main__()