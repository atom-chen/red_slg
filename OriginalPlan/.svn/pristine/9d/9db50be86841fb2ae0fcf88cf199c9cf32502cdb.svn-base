#!/usr/bin/env python
# -*- coding: UTF-8 -*-

# 导入要用到的函数
#!/usr/bin/env python
# -*- coding: UTF-8 -*-
# 导入要用到的函数
from libs.utils import load_excel, client_load_sheel, gen_lua, format_float
import traceback
import os
# 读取领取条件Sheel的内容，第一行标题行会省略不读，但一定要定义标题，方便理解
_fields = []
_typys = []
_re_array_replace_regex = None
def _array_replace(arrayStr):
    arrayStr = arrayStr.lstrip()
    arrayStr = arrayStr.rstrip()
    global _re_array_replace_regex
    if arrayStr[0] == "{" and arrayStr[-1] == "}":
        arrayStr = "[" + arrayStr[1:-1] + "]"
        
        if _re_array_replace_regex == None:
            import re 
            _re_array_replace_regex = re.compile(r'\}\s*,\s*{')    
        return _re_array_replace_regex.sub(r'],[', arrayStr)
    
    dot = False
    num = True
    for s in arrayStr:
        if s == '.':
            if dot == False:
                dot = True
            else:
                return arrayStr
        elif s in '0123456789':
            pass
        else:
            num = False
            break
    
    if num:
        return format_float(arrayStr)
    return arrayStr

def _checkArrayNoString(val, err):
    s = str(val)
    left = 0
    right = 0
    last = None
    braket = 0
    idx = 0
    for ch in s:
        idx = idx + 1
        if ch == '{':
            left = left + 1
            braket = braket + 1
            if last == '}':
                err.append('少了逗号","')
                err.append(s[:idx])
                return False
        elif ch == '}':
            right = right + 1
            braket = braket - 1
            if braket < 0:
                err.append('少了一个{')
                err.append(s[:idx])
                return False
        elif ch == ',' and last == ',':
            err.append('两个逗号')
            err.append(s[:idx])
            return False
        last = ch
        
    if braket < 0:
        err.append('少了%d个}'%(left-right))
        err.append(s)
        return False
    elif braket > 0:
        err.append('少了%d个{'%(right-left))
        err.append(s)
        return False
        
    return True

def _base2Config(content, row ):
    global  _fields
    global  _typys
    result = []
    length = len( content )
    #
    idx = 0
    if '2' == str(row):
        for s in range( 0, length):
            _fields.append(str(content[s]) )
        return result
    elif '3' == str(row):
        for t in range( 0, length):
            _typys.append(str(content[t])) 
        return result
    #print(row, content)
    if None == content[0]:
        return result
    if 'string' == _typys[0]:
        strcfg = '["%s"]={'%(str(content[0]) )
    elif 'int' == _typys[0]:
        strcfg = '[%d]={'%(int(content[0]) )
    elif 'float' == _typys[0]:
        strcfg = '[%s]={'%(format_float(content[0]))
    else:
        idx = 0
        strcfg = "{"
        
    for k in range(idx, length):
        if None == content[k] or content[k] == '':
            continue
        name = _fields[k]
        if 'None' == str(_fields[k]):
            continue
        if 'string' == _typys[k]:
            s = str(content[k])
            if s.find('\n') != -1 or s.find('\r') != -1:
                strcfg = strcfg + '["%s"]="%s",'%(name,s)
            else:
                strcfg = strcfg + '%s="%s",'%(name,s)
        elif 'array' == _typys[k]:
            str1 =str(content[k])
            strcfg = strcfg + '%s={%s},'%(name,str1)
        elif 'array_nostring' == _typys[k]:
            err = []
            if not _checkArrayNoString(content[k], err):
                raise Exception("错误行数:%s\r\n错误列:%s\r\n错误信息:%s\r\n错误所在地方:%s\r\n错误所在行内容:%s\n\n"%(row,name,err[0], err[1], strcfg))
            strcfg = strcfg + '%s={%s},'%(name, str(content[k]))
        elif 'int' == _typys[k]:
            #print("content[k]", content[k],name)
            strcfg = strcfg + '%s=%s,'%(name,format_float(content[k]))
        elif 'float' == _typys[k]:
            strcfg = strcfg + '%s=%s,'%(name, format_float(content[k]))

    strcfg = strcfg.rstrip(',') + '}'
    result.append(strcfg)
    return result

def _array2Config(content, row ):
    global  _fields
    global  _typys
    result = []
    length = len( content )
    #print('row:%s, len:%d'%(str(row), length))

    if '2' == str(row):
        for s in range( 0, length):
            _fields.append(str(content[s]) )
        return result
    elif '3' == str(row):
        for t in range( 0, length):
            _typys.append(str(content[t])) 
        return result

    idx = 0
    strcfg = "{"
        
    for k in range(idx, length):
        if None == content[k]:
            continue
        name = _fields[k]
        if 'None' == str(_fields[k]):
            continue
        if 'string' == _typys[k]:
            s = content[k]
            if s.find('\n') != -1 or s.find('\r') != -1:
                strcfg = strcfg + '["%s"]="%s",'%(name,s)
            else:
                strcfg = strcfg + '%s=\"%s\",'%(name,s)
        elif 'array' == _typys[k]:
            str1 =str(content[k])
            strcfg = strcfg + '%s={%s},'%(name,str1)
        elif 'array_nostring' == _typys[k]:
            err = []
            if not _checkArrayNoString(content[k], err):
                raise Exception("错误行数:%s\r\n错误列%s\r\n错误信息:%s\r\n错误所在地方:%s\r\n错误所在行内容:%s\n\n"%(row,name,err[0], err[1], strcfg))
            strcfg = strcfg + '%s={%s},'%(name, str(content[k]))
        elif 'int' == _typys[k]:
            strcfg = strcfg + '%s=%s,'%(name,format_float(content[k]))
        elif 'float' == _typys[k]:
            strcfg = strcfg + '%s=%s,'%(name, format_float(content[k]))

    strcfg = strcfg.rstrip(',') + '}'
    result.append(strcfg)
    return result

_suit_dict = {}
def _suit2config(content, row, pos):
    global  _fields
    global  _typys
    global  star
    result = []
    length = len( content )
    #print('row:%s, len:%d'%(str(row), length))
    if '2' == str(row):
        for s in range( 0, length):
            _fields.append(str(content[s]) )
        return result
    elif '3' == str(row) :
        for t in range( 0, length):
            _typys.append(str(content[t]))
        return result
        
    dict = _suit_dict
    val_begin = 0
    if pos < 0:
        val_begin = length+pos
    else:
        val_begin = pos
    #print("#############", val_begin)
    # map
    for k in range(0, val_begin):
        if None == content[k]:
            continue

        name = _fields[k]
        kk = content[k]
        val = kk
        if 'None' == str(_fields[k]):
            continue
        if 'string' == _typys[k]:
            kk = str(val)
        elif 'int' == _typys[k]:
            kk = int(val)
        elif 'float' == _typys[k]:
            kk = float(val)
        
        if not dict.has_key(kk):
            dict[kk] = {}
        dict = dict[kk]
        
        
        
    for k in range(val_begin, length):
        val = content[k]
        if None == content[k]:
            continue
        if 'None' == str(_fields[k]):
            continue
        name = _fields[k]
        
#print(name)
        if 'None' == str(_fields[k]):
            continue
        if 'string' == _typys[k]:
           # strcfg = strcfg + '%s=\"%s\",'%(name, val)
            valstr = '"%s"'%(content[k])
        elif 'array' == _typys[k]:
          #  str1 =str(val)
          #  strcfg = strcfg + '%s={%s},'%(name,str1)
            valstr = '{%s}'%(val)
        elif 'array_nostring' == _typys[k]:
          #  str1 =str(val)
          #  strcfg = strcfg + '%s={%s},'%(name,str1)
          #  strcfg = strcfg + '%s={%s},'%(name,str1)
            err = []
            if not _checkArrayNoString(content[k], err):
                raise Exception("错误行数:%s\r\n错误列%s\r\n错误信息:%s\r\n错误所在地方:%s\r\n错误所在行内容:%s\n\n"%(row,name,err[0], err[1], strcfg))
            valstr = '{%s}'%(val)
        elif 'int' == _typys[k]:
           # strcfg = strcfg + '%s=%s,'%(name,str(int(val)))
            valstr = '%s'%(format_float(val))
        elif 'float' == _typys[k]:
            #strcfg = strcfg + '%s=%f,'%(name, float(val))
            valstr = '%s'%(format_float(val))
        dict[name] = valstr

    
    return result

def _multiKeyArray2config(content, row, keylist, keyInItem=False, valueList=None, oneValueOptimize=False):
    global  _fields
    global  _typys
    global  star
    result = []
    length = len( content )
    #print('row:%s, len:%d'%(str(row), length))
    if '2' == str(row):
        for s in range( 0, length):
            _fields.append(str(content[s]) )
        return result
    elif '3' == str(row) :
        for t in range( 0, length):
            _typys.append(str(content[t]))
        return result
        
    dict = _suit_dict
    #print("#############", val_begin)
    # map
    kk = None
    val = None
    for i,key in enumerate(keylist):
        for k in range(0, length):
            if None == content[k]:
                continue

            name = _fields[k]
          #  print(name, key, 1)
            if name != key:
                continue
         #   print(name, key, 2)
            kk = content[k]
            val = kk
            if 'None' == str(_fields[k]):
                continue
            if 'string' == _typys[k]:
                kk = str(val)
            elif 'int' == _typys[k]:
                kk = int(val)
            elif 'float' == _typys[k]:
                kk = float(val)
            
            if not dict.has_key(kk):
                if i+1 == len(keylist):
                    dict[kk] = []
            dict = dict[kk]
        
        
    dictValue = None
    for k in range(0, length):
        val = content[k]
        if None == content[k]:
            continue
        if 'None' == str(_fields[k]):
            continue
        name = _fields[k]

        if not keyInItem and name in keylist:
            continue
#print(name)
        if valueList and name not in valueList:
            continue
        if 'None' == str(_fields[k]):
            continue
        if dictValue == None:
            dictValue = {}
        if 'string' == _typys[k]:
           # strcfg = strcfg + '%s=\"%s\",'%(name, val)
            valstr = '"%s"'%(content[k])
        elif 'array' == _typys[k]:
          #  str1 =str(val)
          #  strcfg = strcfg + '%s={%s},'%(name,str1)
            valstr = '{%s}'%(val)
        elif 'array_nostring' == _typys[k]:
          #  str1 =str(val)
          #  strcfg = strcfg + '%s={%s},'%(name,str1)
          #  strcfg = strcfg + '%s={%s},'%(name,str1)
            err = []
            if not _checkArrayNoString(content[k], err):
                raise Exception("错误行数:%s\r\n错误列%s\r\n错误信息:%s\r\n错误所在地方:%s\r\n错误所在行内容:%s\n\n"%(row,name,err[0], err[1], strcfg))
            valstr = '{%s}'%(val)
        elif 'int' == _typys[k]:
           # strcfg = strcfg + '%s=%s,'%(name,str(int(val)))
            valstr = '%s'%(format_float(val))
        elif 'float' == _typys[k]:
            #strcfg = strcfg + '%s=%f,'%(name, float(val))
            valstr = '%s'%(format_float(val))
        if oneValueOptimize and valueList and len(valueList) == 1:
            dictValue = valstr
        else:
            dictValue[name] = valstr
    if dictValue:
        dict.append(dictValue)
    return result

def _multiKey2config(content, row, keylist, keyInItem=False, valueList=None, oneValueOptimize=False):
    global  _fields
    global  _typys
    global  star
    result = []
    length = len( content )
    #print('row:%s, len:%d'%(str(row), length))
    if '2' == str(row):
        for s in range( 0, length):
            _fields.append(str(content[s]) )
        return result
    elif '3' == str(row) :
        for t in range( 0, length):
            _typys.append(str(content[t]))
        return result
        
    dict = _suit_dict
    #print("#############", val_begin)
    # map
    kk = None
    val = None
    dict_parent = dict
    for key in keylist:
        for k in range(0, length):
            if None == content[k]:
                continue

            name = _fields[k]
          #  print(name, key, 1)
            if name != key:
                continue
         #   print(name, key, 2)
            kk = content[k]
            val = kk
            if 'None' == str(_fields[k]):
                continue
            if 'string' == _typys[k]:
                kk = str(val)
            elif 'int' == _typys[k]:
                kk = int(val)
            elif 'float' == _typys[k]:
                kk = float(val)
            
            if not dict.has_key(kk):
                dict[kk] = {}
            dict_parent = dict
            dict = dict[kk]
        
        
        
    for k in range(0, length):
        val = content[k]
        if None == content[k]:
            continue
        if 'None' == str(_fields[k]):
            continue
        name = _fields[k]

        if not keyInItem and name in keylist:
            continue
#print(name)
        if valueList and name not in valueList:
            continue
        if 'None' == str(_fields[k]):
            continue
        if 'string' == _typys[k]:
           # strcfg = strcfg + '%s=\"%s\",'%(name, val)
            valstr = '"%s"'%(content[k])
        elif 'array' == _typys[k]:
          #  str1 =str(val)
          #  strcfg = strcfg + '%s={%s},'%(name,str1)
            valstr = '{%s}'%(val)
        elif 'array_nostring' == _typys[k]:
          #  str1 =str(val)
          #  strcfg = strcfg + '%s={%s},'%(name,str1)
          #  strcfg = strcfg + '%s={%s},'%(name,str1)
            err = []
            if not _checkArrayNoString(content[k], err):
                raise Exception("错误行数:%s\r\n错误列%s\r\n错误信息:%s\r\n错误所在地方:%s\r\n错误所在行内容:%s\n\n"%(row,name,err[0], err[1], strcfg))
            valstr = '{%s}'%(val)
        elif 'int' == _typys[k]:
           # strcfg = strcfg + '%s=%s,'%(name,str(int(val)))
            valstr = '%s'%(format_float(val))
        elif 'float' == _typys[k]:
            #strcfg = strcfg + '%s=%f,'%(name, float(val))
            valstr = '%s'%(format_float(val))
        dict[name] = valstr
        if oneValueOptimize and valueList and len(valueList) == 1:
            dict_parent[kk] = valstr
        else:
            dict[name] = valstr
    
    return result

import types
def _key_to_string(data):
    s = ""
    #print(type(data), data)
    if type(data) is types.StringType:
        s = str(data)
    else:
        s = "[" + str(data) + "]"
    return s

def _dist_to_string(data):
    s = ""
    #print(type(data), data)
    if type(data) is types.DictType:
        s = s + "{"
        array_count = 0
        val = data.get(array_count+1, None)
        while val:
            s = s + _dist_to_string(val) + ","
            array_count = array_count + 1
            val = data.get(array_count+1, None)
            
        for k,v in data.iteritems():
            if type(k) == type(array_count) and k <= array_count and k > 0:
                continue
            s = s + _key_to_string(k) + "=" + _dist_to_string(v) + ","
      #  for k,v in data.iteritems():
      #      s = s + _key_to_string(k) + "=" + _dist_to_string(v) + ","
        s = s.rstrip(',') + "}"
    elif type(data) is types.ListType:
        s = s + "{"
        for v in data:
            s = s + _dist_to_string(v) + ","
        s = s.rstrip(',') + "}"
    else:
        s = str(data)
    return s
    

def _workbook_suit_to_lua(workbook, sheetname, filename, begin=2):
    global  _fields
    global  _typys
    global  _suit_dict
    _suit_dict = {}
    _fields = []
    _typys = []
    cls = client_load_sheel(workbook, sheetname)
    tran = cls(_suit2config)
    config_list = tran(begin)
    data_cfg = []
    data_str = "return " + _dist_to_string(_suit_dict)
    data_cfg.append(data_str)
    return gen_lua(filename, data_cfg)

def _workbook_multi_key_array_to_lua(workbook, sheetname, filename, keylist, keyInItem, valueList, oneValueOptimize):
    global  _fields
    global  _typys
    global  _suit_dict
    _suit_dict = {}
    _fields = []
    _typys = []
    cls = client_load_sheel(workbook, sheetname)
    tran = cls(_multiKeyArray2config)
    config_list = tran(keylist, keyInItem, valueList, oneValueOptimize)
    data_cfg = []
    data_str = "return " + _dist_to_string(_suit_dict)
    data_cfg.append(data_str)
    return gen_lua(filename, data_cfg)

def _workbook_multi_key_to_lua(workbook, sheetname, filename, keylist, keyInItem, valueList,oneValueOptimize):
    global  _fields
    global  _typys
    global  _suit_dict
    _suit_dict = {}
    _fields = []
    _typys = []
    cls = client_load_sheel(workbook, sheetname)
    tran = cls(_multiKey2config)
    config_list = tran(keylist, keyInItem, valueList, oneValueOptimize)
    data_cfg = []
    data_str = "return " + _dist_to_string(_suit_dict)
    data_cfg.append(data_str)
    return gen_lua(filename, data_cfg)


def _workbook_to_lua(workbook, sheetname, filename):
    global  _fields
    global  _typys
    _fields = []
    _typys = []
    cls = client_load_sheel(workbook, sheetname)
    tran = cls(_base2Config)
    config_list = tran()
    data_cfg = []
    data_str = "return {"
    for item in config_list:
        data_str = data_str + str(item)
        data_str = data_str + ","
    data_str = data_str.rstrip(',') + "}"
    data_cfg.append(data_str)
    return gen_lua(filename, data_cfg)

def _workbook_array_to_lua(workbook, sheetname, filename):
    global  _fields
    global  _typys
    _fields = []
    _typys = []
    cls = client_load_sheel(workbook, sheetname)
    tran = cls(_array2Config)
    config_list = tran()
    data_cfg = []
    data_str = "return {"
    for item in config_list:
        data_str = data_str + str(item)
        data_str = data_str + ","
    data_str = data_str.rstrip(',') + "}"
    data_cfg.append(data_str)
    return gen_lua(filename, data_cfg)

def workbook_multi_key_to_lua(workbook, sheetname, filename, keylist, keyInItem=False, valueList=None, oneValueOptimize=False):
    try:
        return _workbook_multi_key_to_lua(workbook, sheetname, filename, keylist, keyInItem, valueList, oneValueOptimize)
    except Exception,e:
        print sheetname.encode('gbk'), filename, u" 错误!!!\r\n".encode("gbk"),traceback.format_exc().encode("gbk")
        os.system("pause")

def workbook_multi_key_array_to_lua(workbook, sheetname, filename, keylist, keyInItem=False, valueList=None, oneValueOptimize=False):
    try:
        return _workbook_multi_key_array_to_lua(workbook, sheetname, filename, keylist, keyInItem, valueList, oneValueOptimize)
    except Exception,e:
        print sheetname.encode('gbk'), filename, u" 错误!!!\r\n".encode("gbk"),traceback.format_exc().encode("gbk")
        os.system("pause")

def workbook_suit_to_lua(workbook, sheetname, filename, begin=2):
    try:
        return _workbook_suit_to_lua(workbook, sheetname, filename, begin)
    except Exception,e:
        print sheetname.encode('gbk'), filename, u" 错误!!!\r\n".encode("gbk"),traceback.format_exc().encode("gbk")
        os.system("pause")

def workbook_to_lua(workbook, sheetname, filename):
    try:
        return _workbook_to_lua(workbook, sheetname, filename)
    except Exception,e:
        print sheetname.encode('gbk'), filename, u" 错误!!!\r\n".encode("gbk"),traceback.format_exc().encode("gbk")
        os.system("pause")
        
def workbook_array_to_lua(workbook, sheetname, filename):
    try:
        return _workbook_array_to_lua(workbook, sheetname, filename)
    except Exception,e:
        print sheetname.encode('gbk'), filename, u" 错误!!!\r\n".encode("gbk"),traceback.format_exc().encode("gbk")
        os.system("pause")

#example:[level]={exp=xxx} = > [level]=xxx
def workbook_one_kv_to_lua(workbook, sheetname, filename, key, value):
    workbook_multi_key_array_to_lua(workbook, sheetname, filename, [key], False, [value], True)