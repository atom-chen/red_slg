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

#需要导入数据配置excel 文件名 (name.xlsx)，文件统一放置在docs目录 
excel_file_name = ur'低端包skill'

lua_file_name="../../../../lowProject/game/res/config/skill"

#sheet名及对应导出的lua文件名
sheet2luas = [ur"主动技能", 
    ur"被动技能",ur"玩家技能"
    ]

# 读取领取条件Sheel的内容，第一行标题行会省略不读，但一定要定义标题，方便理解
fields = []
typys = []

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

star = 0
star_dist = {}
def buyskill2config(content, row ):
    global  fields
    global  typys
    global  star
    result = []
    length = len( content )
    #print('row:%s, len:%d'%(str(row), length))
    if '2' == str(row):
        for s in range( 0, length):
            if str(content[s]) == 'star':
                star = s
            fields.append(str(content[s]) )
        return result
    elif '3' == str(row) :
        for t in range( 0, length):
            typys.append(str(content[t])) 
        return result


    cur_quality = int(content[star])
    if star_dist.has_key(cur_quality) == False:
        star_dist[cur_quality] = []
        
    strcfg = '[%d]={'%(int(content[0]) )
    for k in range( 1, length):
        if None == content[k]:
            continue
        if star == k:
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

    star_dist[cur_quality].append(result)
    
    return result

    

def workbook_buyskill_to_lua(workbook, sheetname, filename):
    global  fields
    global  typys
    fields = []
    typys = []
    cls = client_load_sheel(workbook, sheetname)
    tran = cls(buyskill2config)
    config_list = tran()
    data_cfg = []
    data_str = "return {"
    for q,item in star_dist.iteritems():
        #data_str = data_str + '[%d]={'%(int(q))
        for v in item:
            data_str = data_str + v[0] + ","
        data_str = data_str
    data_str = data_str + "}"
    data_cfg.append(data_str)
    gen_lua(filename, data_cfg)


def workbook_to_lua(workbook, sheetname):
    global  fields
    global  typys
    fields = []
    typys = []
    cls = client_load_sheel(workbook, sheetname)
    tran = cls(base2config)
    config_list = tran()
    
    data_str = ""
    for item in config_list:
        data_str = data_str + str(item)
        data_str = data_str + ","
    
    return data_str
    

def excel_to_lua(excelname, sheetnames, lua_file_name):
    workbook = load_excel(excelname)
    data_cfg = []
    data_str = "return {"
    for sheet in sheetnames:
        str=workbook_to_lua(workbook, sheet)
        data_str = data_str + str
    data_str = data_str + "}"
    data_cfg.append(data_str)
    gen_lua(lua_file_name, data_cfg)
    
def __main__():
    excel_to_lua(excel_file_name, sheet2luas, lua_file_name)

__main__()