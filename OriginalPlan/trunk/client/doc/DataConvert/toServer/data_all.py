#!/usr/bin/env python
# -*- coding: UTF-8 -*-

'''
生成所有配置
'''
# 导入要用到的函数
import os, glob

def gen_one(pyfile):
    if pyfile != "data_all":
        print "正在生成 [" + pyfile + "]"
        os.system("python {0}.py".format(pyfile))
        os.system("cp ./erl/{0}.erl E:/server/trunk/gameserver/src/data".format(pyfile))
        if pyfile == "data_md5":
            os.system("cp ./erl/{0}.erl E:/server/trunk/loginserver/src/data".format(pyfile))

	

file_list = glob.glob('*.py')

for f in file_list:
    gen_one(f.replace('.py', ''))

print "全部配置生成完成!!"
