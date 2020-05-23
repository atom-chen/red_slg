#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
@author: dzw
@deprecated: 2013-11-7 17:07:43
'''
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml
from openpyxl.reader.excel import load_workbook
from collections import defaultdict
from collections import OrderedDict
import time
import types
import os
import sys
import locale
import platform
import unicodedata

reload(sys)
sys.setdefaultencoding('utf-8') #IGNORE:E1101
locale.setlocale(locale.LC_ALL, "")

########## 转换一个excel sheet ##########################
## excel_file 	EXCEL文件名
## excel_sheet  EXCEL sheet 名
## ConvertOneLineFun 转换一行的回调函数

class convert_excel_sheet(object):
	def __init__(self, excel_file, excel_sheet):
		self.excel_file = excel_file
		self.excel_sheet = excel_sheet
		self.is_finish = 0 			# parse结束标记
		self.line_index = 0			# excel当前行 0开始
		self.field_count = 0 		# 字段数
		self.field_name_dict = {}	# 字段name列表 下标->name
		self.field_type_dict = {}	# 字段type列表 下标->type
		self.field_for_dict = {}	# 字段for列表 下标->for
	
	def __call__(self, func):
		work_book = load_excel(self.excel_file)
		
		@load_sheel(work_book, self.excel_sheet)
		def content_line_parser(content=0):
			self.line_index = self.line_index + 1
			
			# 扫描除去标题行的第一行 生成字段名和类型字典
			if self.line_index == 1:
				(self.field_count, self.field_name_dict, self.field_type_dict, self.field_for_dict) = scan_get_name_type_arr(content)
				return[]
				
			# 第1列为空 则整个EXCEL结束
			if self.is_finish == 1 or content[0] == None:
				self.is_finish = 1
				return []
			
			# 解析一个数据行
			# ED - erlang name-value字典
			# XD - xml name-value字典
			(ED, XD) = scan_get_value_arr(content, self.field_count, self.field_name_dict, self.field_type_dict, self.field_for_dict)
			
			# 转换处理
			func(ED, XD)
			
			return []
		content_line_parser()

class convert_excel_sheet2(object):	# 支持一条数据记录占excel多行 但要用[END]标识sheet结束
	def __init__(self, excel_file, excel_sheet):
		self.excel_file = excel_file
		self.excel_sheet = excel_sheet
		self.is_finish = 0 			# parse结束标记
		self.line_index = 0			# excel当前行 0开始
		self.field_count = 0 		# 字段数
		self.field_name_dict = {}	# 字段name列表 下标->name
		self.field_type_dict = {}	# 字段type列表 下标->type
		self.field_for_dict = {}	# 字段for列表 下标->for
		self.sum_content = {}		# 累计多行的content
	
	def __call__(self, func):
		work_book = load_excel(self.excel_file)
		
		@load_sheel(work_book, self.excel_sheet)
		def content_line_parser(content=0):
			self.line_index = self.line_index + 1
			
			# 扫描除去标题行的第一行 生成字段名和类型字典
			if self.line_index == 1:
				(self.field_count, self.field_name_dict, self.field_type_dict, self.field_for_dict) = scan_get_name_type_arr(content)
				return[]
			
			# 如已扫描结束 直接return
			if self.is_finish == 1:
				return []
			 
			if content[0] != None:
				# 第1列不为空
				# 解析
				if len(self.sum_content) != 0:
					# ED - erlang name-value字典
					# XD - xml name-value字典
					(ED, XD) = scan_get_value_arr(self.sum_content, self.field_count, self.field_name_dict, self.field_type_dict, self.field_for_dict)
					func(ED, XD)

				# 开始新累计
				for i in range(0, self.field_count):
					self.sum_content[i] = ("" if content[i] == None else str(content[i]).strip())
				
				# 特殊标记，如果是[END]，则sheet结束
				if content[0] == "[END]":
					self.is_finish = 1
			else:
				# 第1列为空，继续累计
				for i in range(0, self.field_count):
					if content[i] != None and str(content[i]).strip() != "":
						self.sum_content[i] = self.sum_content[i] + "\n" + str(content[i]).strip()
			return []
		content_line_parser()
		
######## 扫描生成字段name和type数组 ####
## excel第一行为标题
## excel第二行为name:type
## 本函数传入excel第二行content
## 返回(字段数, name[], type[], for[])

def scan_get_name_type_arr(content):
	field_count = 0
	name_dict = {}
	type_dict = {}
	for_dict = {}

	for i in range(0, 256):
		if i >= len(content) or content[i] == None:	 ### 遇到空列 结束
			field_count = i
			break
		arr = content[i].split(':')
		if len(arr) >= 2:
			name_dict[i] = arr[0]
			type_dict[i] = arr[1]
		else:
			name_dict[i] = arr[0]
			type_dict[i] = "int"
		if name_dict[i][0:2] == '__':		# for server only
			for_dict[i] = 2
			name_dict[i] = name_dict[i][2:]
		elif name_dict[i][0:1] == '_':		# for client only
			for_dict[i] = 1
			name_dict[i] = name_dict[i][1:]
		elif name_dict[i][0:1] == '~':		# for temp only
			for_dict[i] = 0
			name_dict[i] = name_dict[i][1:]
		else:								# for both server & client by default 
			for_dict[i] = 3
			
	return (field_count, name_dict, type_dict, for_dict)		### 返回 字段总数, name[], type[], for[] (for[]仅用于SERVER_LIST CLIENT_LIST)

######## 扫描生成字段value数组 ####
### 传入excel第三行起的content
### 返回 name_erl_value_dict, name_xml_value_dict
### name_erl_value_dict: erlang名字值对应字典
### name_xml_value_dict: xml名字值对应字典

def scan_get_value_arr(content, field_count, name_dict, type_dict, for_dict):
	erl_value_dict = {}			## 下标对应erl_value
	name_erl_value_dict = {}	## 字段名对应erl_value
	xml_value_dict = {}			## 下标对应xml_value
	name_xml_value_dict = {}	## 字段名对应xml_value
	
	for i in range(0, field_count):
		erl_value = str_to_erl_value((content[i-1] if type_dict[i] == 'spec' else type_dict[i]), ("" if content[i] == None else str(content[i]).strip()))
		erl_value_dict[i] = erl_value
		name_erl_value_dict[name_dict[i]] = erl_value
		
		xml_value = str_to_xml_value((content[i-1] if type_dict[i] == 'spec' else type_dict[i]), ("" if content[i] == None else str(content[i]).strip()))
		xml_value_dict[i] = xml_value
		name_xml_value_dict[name_dict[i]] = xml_value
	
	# 自动生成两个内置数据: SERVER_LIST CLIENT_LIST
	# SERVER_LIST : name=value, name=value, ...
	# CLIENT_LIST: <name>value</name> <name>value</name> 
	is_first = 1
	server_list = ""
	for i in range(0, len(for_dict)):
		if for_dict[i] == 3 or for_dict[i] == 2:
			if is_first == 0:
				server_list += "\n,"
			server_list += "{0} = {1}".format(name_dict[i], erl_value_dict[i])
			is_first = 0
	name_erl_value_dict["SERVER_LIST"] = server_list
	
	is_first = 1
	client_list = ""
	for i in range(0, len(for_dict)):
		if for_dict[i] == 3 or for_dict[i] == 1 :
			if is_first == 0:
				client_list += "\n"
			client_list += "<{0}>{1}</{0}>".format(name_dict[i], xml_value_dict[i])
			is_first = 0
	name_xml_value_dict["CLIENT_LIST"] = client_list
		
	# print "******************"
	# print field_count
	# print name_dict
	# print type_dict
	# print erl_value_dict
	# print name_erl_value_dict
	# print xml_value_dict
	# print name_xml_value_dict
	# print "******************"
	
	return (name_erl_value_dict, name_xml_value_dict)

######## 模板替换 ##################
## 传入模板字符串template_str, 和name-value字典
## 把 $$name$$ 替换为对应的value
## 返回替换后的字符串

def fill_template_str(template_str, name_value_dict):
	# print "**********************"
	# print name_value_dict
	# print name_dict
	# print "**********************"
	
	outstr = template_str
	for k in name_value_dict.keys():  
		to_replace = "$$" + k + "$$"
		outstr = smart_replace(outstr, to_replace, name_value_dict[k])
		
	return inner_format(outstr)

# 辅助函数
# 字符串宽度 (汉字按2计 英文按1计)
def get_hz_string_width(text):
	w = 0  
	for ch in text:  
		if isinstance(ch, unicode):  
			if unicodedata.east_asian_width(ch) != 'Na':
				w += 2
			else:  
				w += 1
		else:  
			w += 1
	return w

# 解释替换内部格式串 @@[Fmt,Arg,Arg..]XXX@@
def inner_format(outstr):
	ReplaceOk = True
	while ReplaceOk:
		ReplaceOk = False
		pos1 = outstr.find("@@[")
		if pos1 >= 0:
			pos2 = outstr.find("]", pos1 + 1)
			pos3 = outstr.find("@@", pos1 + 1)
			if pos2 > pos1 and pos3 > pos2:
				newstr = do_inner_format(outstr[pos1 + 3 : pos2], outstr[pos2 + 1:pos3])
				outstr = outstr[0:pos1] + newstr + outstr[pos3+2:]
				ReplaceOk = True
				
	return outstr
	
def do_inner_format(Fmt, str):
	arr = strip_split(Fmt, ",")
	if arr[0] == "W":
		return do_inner_format_W(int(arr[1]), str)
	elif arr[0] == 'lower':
		return do_inner_format_lower(str)
	elif arr[0] == 'upper':
		return do_inner_format_upper(str)
	return str

def do_inner_format_W(Width, str):
	w = get_hz_string_width(str)
	if w >= Width:
		return str
	return str + "{{0:{0}}}".format(Width - w).format("")
	
def do_inner_format_lower(str):
	return str.lower()

def do_inner_format_upper(str):
	return str.upper()
			
# 替换 (根据to_replace在str中的位置,调整newstr,以适合缩进)
def smart_replace(str, to_replace, newstr):
	index = str.find(to_replace)
	if index < 0:
		return str
	blank = ""
	for i in range(1, index):
		if str[index - i] == "\r" or str[index - i] == "\n": # 向前找到换行
			for j in range(index - i + 1, index + 1):        # 再向后找到非空格 从而计算出缩进
				if str[j] == '\t' or str[j] == ' ':
					blank += str[j]
				else:
					break
			# blank = str[index - i + 1 : index]
			break
			
	return str.replace(to_replace, newstr.replace("\n", "\n" + blank))

# split并且strip并去掉为空的项
def strip_split(str, splitter):
	arr = str.split(splitter)
	n = len(arr)
	for i in range(0, n):
		index = n - 1 - i
		arr[index] = arr[index].strip()
		if arr[index] == "":
			del arr[index]
	return arr

######## 按type转换一个字段 ##########
def str_to_erl_value(ftype, strvalue):
	if ftype == "meta":
		return to_meta_erl(strvalue)
	elif ftype == "int":
		return to_int_erl(strvalue)
	elif ftype == "float":
		return to_float_erl(strvalue)
	elif ftype == "bool":
		return to_bool_erl(strvalue)
	elif ftype == "str":
		return to_str_erl(strvalue)
	elif ftype == "pair":
		return to_pair_erl(strvalue)
	elif ftype == "arr":
		return to_arr_erl(strvalue)
	elif ftype[0:4] == "arr(":
		return to_arr2_erl(strvalue, ftype[4:len(ftype)-1])
	elif ftype[0:5] == "list(":
		listdesc = strip_split(ftype[5:len(ftype)-1], ",")
		return to_list_erl(strvalue, listdesc[0], (listdesc[1] if len(listdesc) > 1 else ""))
	elif ftype == "loss":
		return to_loss_erl(strvalue)
	elif ftype == "gain":
		return to_gain_erl(strvalue)
	else:
		return strvalue

def str_to_xml_value(ftype, strvalue):
	if ftype == "meta":
		return to_meta_xml(strvalue)
	elif ftype == "int":
		return to_int_xml(strvalue)
	elif ftype == "float":
		return to_float_xml(strvalue)
	elif ftype == "bool":
		return to_bool_xml(strvalue)	
	elif ftype == "str":
		return to_str_xml(strvalue)
	elif ftype == "pair":
		return to_pair_xml(strvalue)
	elif ftype == "arr":
		return to_arr_xml(strvalue)
	elif ftype[0:4] == "arr(":
		return to_arr2_xml(strvalue, ftype[4:len(ftype)-1])
	elif ftype[0:5] == "list(":
		listdesc = strip_split(ftype[5:len(ftype)-1], ",")
		return to_list_xml(strvalue, listdesc[0], (listdesc[1] if len(listdesc) > 1 else ""))
	elif ftype == "loss":
		return to_loss_xml(strvalue)
	elif ftype == "gain":
		return to_gain_xml(strvalue)
	else:
		return strvalue

######## 各种type的转换实现 ##########

### meta #####
def to_meta_erl(strvalue):
	return strvalue

def to_meta_xml(strvalue):
	return strvalue

### int #####
def to_int_erl(strvalue):
	if strvalue.find(":") >= 0:
		arr = strvalue.split(":")
		return "{0:d}".format(int(eval(arr[0])))
	return "{0:d}".format(int(eval(strvalue)))
	
def to_int_xml(strvalue):
	if strvalue.find(":") >= 0:
		arr = strvalue.split(":")
		return "{0:d}".format(int(eval(arr[0])))
	return "{0:d}".format(int(eval(strvalue)))

### float #####
def to_float_erl(strvalue):
	return "{0}".format(float(strvalue))

def to_float_xml(strvalue):
	return "{0}".format(float(strvalue))

### bool #####
def to_bool_erl(strvalue):
	if strvalue == "":
		return "false"
	if int(eval(strvalue)) == 1:
		return "true"
	return "false"

def to_bool_xml(strvalue):
	if strvalue == "":
		return "0"
	if int(eval(strvalue)) == 1:
		return "1"
	return "0"

### str #####
def to_str_erl(strvalue):
	return "<<\"" + strvalue + "\">>"

def to_str_xml(strvalue):
	return strvalue

### pair #####
## excel: key#value
## erlang: {key, value}
## xml: <key>value</key>
## 
def to_pair_erl(strvalue):
	arr = strip_split(strvalue, "#")
	return "{{{0}, {1}}}".format(arr[0], arr[1])

def to_pair_xml(strvalue):
	arr = strip_split(strvalue, "#")
	if arr[0][0] == "?":
		arr[0] = arr[0][1:]
	return "<{0}>{1}</{0}>".format(arr[0], arr[1])

### arr #####
## 逗号(或指定分隔符)分割的简单list
## excel: A,B
## erlang: [A,B]
## xml: 
##       <item>A</item>
##       <item>B</item>
def to_arr_erl(strvalue):
	return "[" + strvalue.lstrip('[').rstrip(']') + "]"

def to_arr_xml(strvalue):
	itemarr = strip_split(strvalue.lstrip('[').rstrip(']'), ",")
	retvalue = ""
	for kk in range(0, len(itemarr)):
		retvalue += "<item>{0}</item>".format(itemarr[kk]) 
	return retvalue

def to_arr2_erl(strvalue, splitter):
	itemarr = strip_split(strvalue.lstrip('[').rstrip(']'), splitter)
	retvalue = "["
	for kk in range(0, len(itemarr)):
		if kk > 0:
			retvalue += ","
		retvalue += itemarr[kk]
	retvalue += "]"
	return retvalue

def to_arr2_xml(strvalue, splitter):
	itemarr = strip_split(strvalue.lstrip('[').rstrip(']'), splitter)
	retvalue = ""
	for kk in range(0, len(itemarr)):
		retvalue += "<item>{0}</item>".format(itemarr[kk]) 
	return retvalue	

### list(type) ###	
## \n分隔的list 每一项是指定的type
def to_list_erl(strvalue, type, nodename):
	arr = strip_split(strvalue, "\n")
	if len(arr) <= 0:
		return []
	outstr = "[\n"
	for i in range(0, len(arr)):
		outstr += "\t"
		if i > 0:
			outstr = outstr + ","
		outstr = outstr + str_to_erl_value(type, arr[i]) + "\n"
	outstr = outstr + "]"
	return outstr
	
def to_list_xml(strvalue, type, nodename):
	arr = strip_split(strvalue, "\n")
	if len(arr) <= 0:
		return ""
	outstr = "\n"
	for i in range(0, len(arr)):
		outstr += "\t"
		if nodename == "":
			outstr = outstr + str_to_xml_value(type, arr[i]) + "\n"
		else:
			outstr = outstr + "<" + nodename + ">" + str_to_xml_value(type, arr[i]) + "</" + nodename + ">" + "\n"
	return outstr
	
### loss ####
## 用于配置消耗
## excel: 标签#值
## erlang: #loss{}
## xml: <loss><item_id></item_id><num></num></loss>
## 
## excel            erlang                          xml
## gold#100			#loss{label=gold, val=100}      <loss><item_id>1</item_id><num>100</num></loss>
## bgold#100        #loss{label=bgold, val=100}     <loss><item_id>2</item_id><num>100</num></loss>
## coin#100         #loss{label=coin, val=100}      <loss><item_id>3</item_id><num>100</num></loss>
## exp#100          #loss{label=exp, val=100}       <loss><item_id>4</item_id><num>100</num></loss>
## scope#100        #loss{label=scope, val=100}     <loss><item_id>5</item_id><num>100</num></loss>
## 10000#1,20000#2  #loss{label=items_bind_fst, val={?storage_bag, [{10000, 1}, {20000, 2}]}}     <loss><item_id>10000</item_id><num>1</num></loss> <loss><item_id>20000</item_id><num>2</num></loss>

def to_loss_erl(str):
	outstr = ""
	arr = strip_split(str, "#")
	if arr[0].isdigit():	# 物品列表  id#num,id#num,...
		itemlist = strip_split(str, ",")
		itemlist_str = ""
		for i in range(0, len(itemlist)):
			if i > 0:
				itemlist_str += ","
			arr2 = strip_split(itemlist[i], "#")
			itemlist_str += "{{{0},{1}}}".format(arr2[0], arr2[1])
		outstr = "#loss{{label=items_bind_fst, val={{?storage_bag, [{0}]}}}}".format(itemlist_str)
	else: #虚拟物品 label#val
		outstr = "#loss{{label={0}, val={1}}}".format(arr[0], arr[1])
	return outstr

def to_loss_xml(str):
	outstr = ""
	arr = strip_split(str, "#")
	if arr[0].isdigit():	# 物品列表  id#num,id#num,...
		itemlist = str.split(",")
		for i in range(0, len(itemlist)):
			#if i > 0:
			#	outstr += "\n"
			arr2 = strip_split(itemlist[i], "#")
			outstr += "<loss><item_id>{0}</item_id><num>{1}</num></loss>".format(arr2[0], arr2[1])
	else: #虚拟物品 label#val
		outstr = "<loss><item_id>{0}</item_id><num>{1}</num></loss>".format(get_virtual_item_id(arr[0]), arr[1])
	return outstr

### gain ####
## 用于配置奖励
## excel: 标签#值#是否绑定
## erlang: #gain{}
## xml: <gain><item_id></item_id><num></num><is_bind></is_bind></gain>
## 
## excel            erlang                          xml
## gold#100			#gain{label=gold, val=100}      <gain><item_id>1</item_id><num>100</num><is_bind>0</is_bind></gain>  注:is_bind对虚拟物品无实际意义
## bgold#100        #gain{label=bgold, val=100}     <gain><item_id>2</item_id><num>100</num><is_bind>1</is_bind></gain>
## coin#100         #gain{label=coin, val=100}      <gain><item_id>3</item_id><num>100</num><is_bind>1</is_bind></gain>
## exp#100          #gain{label=exp, val=100}       <gain><item_id>4</item_id><num>100</num><is_bind>0</is_bind></gain>
## scope#100        #gain{label=scope, val=100}     <gain><item_id>5</item_id><num>100</num><is_bind>0</is_bind></gain>
## 10000#99#1       #gain{label=item, val={?storage_bag, {10000, 1, 99}}}     <gain><item_id>10000</item_id><num>99</num><is_bind>1</is_bind></gain></gain>
##
## 注意: 和loss不同, 目前一行只能配一个物品!
## 
def to_gain_erl(str):
	outstr = ""
	arr = strip_split(str, "#")
	if arr[0].isdigit():	# 物品列表  id#num,id#num,... (目前只能一个id#num)
		itemlist = strip_split(str, ",")
		itemlist_str = ""
		for i in range(0, len(itemlist)):
			if i > 0:
				itemlist_str += ","
			arr2 = strip_split(itemlist[i], "#")
			itemlist_str += "{{{0},{1},{2}}}".format(arr2[0], arr2[2] if len(arr2)>=3 else 0, arr2[1])
		outstr = "#gain{{label=item, val={{?storage_bag, {0}}}}}".format(itemlist_str)
	else: #虚拟物品 label#val
		outstr = "#gain{{label={0}, val={1}}}".format(arr[0], arr[1])
	return outstr

def to_gain_xml(str):
	outstr = ""
	arr = strip_split(str, "#")
	if arr[0].isdigit():	# 物品列表  id#num#bind,id#num#bind,... (目前只能一个id#num)
		itemlist = str.split(",")
		for i in range(0, len(itemlist)):
			#if i > 0:
			#	outstr += "\n"
			arr2 = strip_split(itemlist[i], "#")
			outstr += "<gain><item_id>{0}</item_id><num>{1}</num><is_bind>{2}</is_bind></gain>".format(arr2[0], arr2[1], arr2[2] if len(arr2) >= 3 else 0)
	else: #虚拟物品 label#val
		outstr = "<gain><item_id>{0}</item_id><num>{1}</num><is_bind>{2}</is_bind></gain>".format(get_virtual_item_id(arr[0]), arr[1], get_virtual_item_bind(arr[0]))
	return outstr

### 扩展其它type ####
## 每个type需给出详细格式说明:
## excel :
## erlang:
## xml:


### 游戏相关辅助函数 ##############################################
## 注意保持和游戏一致 !!
## 定义了就不要改动   !!
## 

# 虚拟物品id -> label
def get_virtual_item_id(label):
	if label == "gold":
		return 1
	elif label == "bgold":
		return 2
	elif label == "coin":
		return 3
	elif label == "exp":
		return 4
	elif label == "scope":
		return 5
	else:
		return label

# 虚拟物品id -> is_bind
# is_bind 对虚拟物品实际无意义
def get_virtual_item_bind(label):
	if label == "gold":
		return 0
	else:
		return 1

