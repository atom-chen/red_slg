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
module_name = "wboss"

 # 需要导入数据配置.xlsx，文件统一放置在docs目录
excel_file_name = ur"world_boss"
sheet2lua_dict = {ur"个人排行榜奖励配置":ur"wboss_rank",
	ur"公会奖励配置":ur"wboss_guild_mrank",
	ur"购买次数钻石":ur"wboss_times_buy",
	ur"boss配置":ur"wboss_cfg",
	ur"军团排名奖励":ur"wboss_guild_rank_reward",
    }

# 读取领取条件Sheel的内容，第一行标题行会省略不读，但一定要定义标题，方便理解
# 读取领取条件Sheel的内容，第一行标题行会省略不读，但一定要定义标题，方便理解
fields = []
typys = []

def basic2config(content, row ):
    global  fields
    global  typys

    result = []
    length = len( content )
    if '2' == str(row):
        for s in range( 0, length):
            fields.append(str(content[s]) )
        return result
    elif '3' == str(row) :
        for t in range( 0, length):
            typys.append(str(content[t])) 
        return result
    #print(row,content[0])
    #print('row:%s, len:%d'%(str(row), length))

    strcfg = '{'
    for k in range(0, length):
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
            strcfg = strcfg + '%s=%s,'%(name,float(content[k]))

    if strcfg == "{":
        return result
    strcfg = strcfg + '}'
    result.append(strcfg)
    return result

def workbook_basic_to_lua(workbook, sheetname, filename):
    global  fields
    global  typys
    fields = []
    typys = []
    cls = client_load_sheel(workbook, sheetname)
    tran = cls(basic2config)
    config_list = tran()
    data_cfg = []
    data_str = "return {"
    for item in config_list:
        data_str = data_str + str(item)
        data_str = data_str + ","
    data_str = data_str + "}"
    data_cfg.append(data_str)
    gen_lua(filename, data_cfg)


def base2config(content, row ):
    global  fields
    global  typys
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
        elif 'float' == typys[k]:
            strcfg = strcfg + '%s=%f,'%(name, float(content[k]))
    strcfg = strcfg + '}'
    result.append(strcfg)
    return result

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

def excel_to_lua(excelname, sheet2luas):
    workbook = load_excel(excelname)
    workbook_basic_to_lua(workbook,'世界boss基础配置表','wboss_system')
	
    for sheet, filename in sheet2luas.iteritems():
        workbook_to_lua(workbook, sheet, filename)
    
def __main__():
    excel_to_lua(excel_file_name, sheet2lua_dict)

__main__()


 	




		


		