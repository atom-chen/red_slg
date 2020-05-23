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
from libs.utils import load_excel
from libs.template import workbook_to_lua, workbook_suit_to_lua, workbook_array_to_lua
import os


#需要导入数据配置excel 文件名 (name.xlsx)，文件统一放置在docs目录 
excel_file_name = ur'leader'

#sheet名及对应导出的lua文件名
sheet2lua_dict = {ur"将领升级":ur"leader_exp",
                    ur"洗练经验及消耗":ur"leader_smelt_exp",
					ur"将领基础信息":ur"leader_basic"
    }
"""
# 读取领取条件Sheel的内容，第一行标题行会省略不读，但一定要定义标题，方便理解
fields = []
typys = []

def base2config(content, row ):
    global  fields
    global  typys
    result = []
    length = len( content )
    #print('row:%s, len:%d'%(str(row), length))
    idx = 1
    if '2' == str(row):
        for s in range( 0, length):
            fields.append(str(content[s]) )
        return result
    elif '3' == str(row):
        for t in range( 0, length):
            typys.append(str(content[t])) 
        return result
    
    if 'string' == typys[0]:
        strcfg = '["%s"]={'%(str(content[0]) )
    elif 'int' == typys[0]:
        strcfg = '[%d]={'%(int(content[0]) )
    elif 'float' == typys[0]:
        strcfg = '[%f]={'%(float(content[0]) )
    else:
        idx = 0
        strcfg = "{"
        
    for k in range(idx, length):
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
        elif 'float' == typys[k]:
            strcfg = strcfg + '%s=%f,'%(name, float(content[k]))
    strcfg = strcfg + '}'
    result.append(strcfg)
    return result


suit_dict = {}
def suit2config(content, row, pos):
    global  fields
    global  typys
    global  star
    result = []
    length = len( content )
    #print('row:%s, len:%d'%(str(row), length))
    if '2' == str(row):
        for s in range( 0, length):
            fields.append(str(content[s]) )
        return result
    elif '3' == str(row) :
        for t in range( 0, length):
            typys.append(str(content[t])) 
        return result
        
    dict = suit_dict
    val_begin = pos
    # map
    for k in range(0, val_begin):
        if None == content[k]:
            continue

        name = fields[k]
        kk = content[k]
        val = kk
        if 'None' == str(fields[k]):
            continue
        if 'string' == typys[k]:
            kk = str(val)
        elif 'int' == typys[k]:
            kk = int(val)
        elif 'float' == typys[k]:
            valstr = float(val)
        
        if not dict.has_key(kk):
            dict[kk] = {}
        dict = dict[kk]
        
        
        
    for k in range(val_begin, length):
        val = content[k]
        if None == content[k]:
            continue
            
        name = fields[k]
        valstr = '""'
        if 'None' == str(fields[k]):
            continue
        if 'string' == typys[k]:
           # strcfg = strcfg + '%s=\"%s\",'%(name, val)
            valstr = '\"%s\"'%(val)
        elif 'array' == typys[k]:
          #  str1 =str(val)
          #  strcfg = strcfg + '%s={%s},'%(name,str1)
            valstr = '{%s}'%(str(val))
        elif 'int' == typys[k]:
           # strcfg = strcfg + '%s=%s,'%(name,str(int(val)))
            valstr = '%s'%(int(val))
        elif 'float' == typys[k]:
            #strcfg = strcfg + '%s=%f,'%(name, float(val))
            valstr = '%f'%(float(val))
        dict[name] = valstr

    
    return result

import types
def key_to_string(data):
    s = ""
    #print(type(data), data)
    if type(data) is types.StringType:
        s = str(data)
    else:
        s = "[" + str(data) + "]"
    return s

def dict_to_string(data):
    s = ""
    #print(type(data), data)
    if type(data) is types.DictType:
        s = s + "{"
        for k,v in data.iteritems():
            s = s + key_to_string(k) + "=" + dict_to_string(v) + ","
        s = s + "}"
    elif type(data) is types.ListType:
        s = s + "{"
        for v in data:
            s = s + dict_to_string(v) + ","
        s = s + "}"
    else:
        s = str(data)
    return s
    

def workbook_suit_to_lua(workbook, sheetname, filename):
    global  fields
    global  typys
    global  suit_dict
    suit_dict = {}
    fields = []
    typys = []
    cls = client_load_sheel(workbook, sheetname)
    tran = cls(suit2config, 2)
    config_list = tran()
    data_cfg = []
    data_str = "return " + dict_to_string(suit_dict)
    data_cfg.append(data_str)
    gen_lua(filename, data_cfg)

def workbook_to_lua(workbook, sheetname, filename):
    global  fields
    global  typys
    fields = []
    typys = []
    cls = client_load_sheel(workbook, sheetname)
    tran = cls(base2config)
    config_list = tran()
    data_cfg = []
    data_str = "return {"
    for item in config_list:
        data_str = data_str + str(item)
        data_str = data_str + ","
    data_str = data_str + "}"
    data_cfg.append(data_str)
    gen_lua(filename, data_cfg)
"""
#r"宝物基础信息":ur"precious_basic"
def excel_to_lua(excelname, sheet2luas):
    workbook = load_excel(excelname)
    for sheet, filename in sheet2luas.iteritems():
        workbook_to_lua(workbook, sheet, filename)
    
    workbook_suit_to_lua(workbook, ur"洗练属性",ur"leader_smelt_attr", 2)
    
def __main__():
    excel_to_lua(excel_file_name, sheet2lua_dict)

__main__()