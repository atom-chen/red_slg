#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
Excel转化为lua脚本

@author: zhangzhen
@deprecated: 2014-5-19
'''
# 导入要用到的函数
#!/usr/bin/env python
# -*- coding: UTF-8 -*-
# 导入要用到的函数
from libs.utils import load_excel, client_load_sheel, gen_lua

# lua模块名称定义，也是文件名
module_name = "magic"

 # 需要导入数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"magic")

# 读取领取条件Sheel的内容，第一行标题行会省略不读，但一定要定义标题，方便理解
fields = []
typys = []

@client_load_sheel(work_book, ur"Sheet1")
def base2config(content, row ):
	global  fields
	global  typys
	result = []
	length = len( content )
	if '2' == str(row):
		for s in range( 0, length):
			fields.append(str(content[s]))
		return result
	elif '3' == str(row) :
		for t in range( 0, length):
			typys.append(str(content[t])) 
		return result

	strcfg = '[%d]={'%(int(content[0]) )
	for k in range( 1, length):
		if None == content[k]:
			continue
		name = fields[k]
		if 'None' == str(fields[k]):
			continue
		if 'string' == typys[k]:
			strcfg = strcfg + '%s=\"%s\",'%(name,content[k])
		elif 'array' == typys[k]:
			str1 =str(content[k])
			strcfg = strcfg + '%s={%s},'%(name,str1)
		elif 'int' == typys[k]:
			strcfg = strcfg + '%s=%s,'%(name,str(int(content[k])))
	strcfg = strcfg + '}'
	result.append(strcfg)
	return result

def __main__():
	config_list = base2config()
	data_cfg = []
	data_str = "return {"
	for item in config_list:
		data_str = data_str + str(item)
		data_str = data_str + ","
	data_str = data_str + "}"
	data_cfg.append(data_str)
	gen_lua(module_name, data_cfg)

__main__()


 	




		


		