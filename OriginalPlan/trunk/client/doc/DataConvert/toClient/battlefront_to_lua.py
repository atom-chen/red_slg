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
excel_file_name = ur'battlefront'

#sheet名及对应导出的lua文件名
sheet2lua_dict = {ur"城市配置":ur"battlefront_city",\
                ur"派遣幻影":ur"battlefront_accredit",\
                ur"复活购买价格":ur"battlefront_regen",\
                ur"刺探钻石花费":ur"battlefront_spy",\
                ur"行动力购买":ur"battlefront_action",\
                ur"排行榜奖励":ur"battlefront_rank_reward",\
    }

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

quality = 0
dist = {}
def quality2config(content, row ):
    global  fields
    global  typys
    global  quality
    result = []
    length = len( content )
    #print("row:%d len:%d"%(row, length))
    if '2' == str(row):
        for s in range( 0, length):
            if str(content[s]) == 'quality':
                quality = s
            fields.append(str(content[s]) )
        return result
    elif '3' == str(row) :
        for t in range( 0, length):
            typys.append(str(content[t])) 
        return result


    cur_quality = int(content[quality])
    if dist.has_key(cur_quality) == False:
        dist[cur_quality] = []
        
    strcfg = '[%d]={'%(int(content[0]) )
    for k in range( 1, length):
        if None == content[k]:
            continue
        if quality == k:
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

    dist[cur_quality].append(result)
    
    return result

star = 0
star_dist = {}
def star2config(content, row ):
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


def workbook_quality_to_lua(workbook, sheetname, filename):
    global  fields
    global  typys
    fields = []
    typys = []
    cls = client_load_sheel(workbook, sheetname)
    tran = cls(quality2config)
    config_list = tran()
    data_cfg = []
    data_str = "return {"
    for q,item in dist.iteritems():
        data_str = data_str + '[%d]={'%(int(q))
        for v in item:
            data_str = data_str + v[0] + ","
        data_str = data_str + "},"
    data_str = data_str + "}"
    data_cfg.append(data_str)
    gen_lua(filename, data_cfg)
    

def workbook_star_to_lua(workbook, sheetname, filename):
    global  fields
    global  typys
    fields = []
    typys = []
    cls = client_load_sheel(workbook, sheetname)
    tran = cls(star2config)
    config_list = tran()
    data_cfg = []
    data_str = "return {"
    for q,item in star_dist.iteritems():
        data_str = data_str + '[%d]={'%(int(q))
        for v in item:
            data_str = data_str + v[0] + ","
        data_str = data_str + "},"
    data_str = data_str + "}"
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

def excel_to_lua(excelname, sheet2luas):
    workbook = load_excel(excelname)
    for sheet, filename in sheet2luas.iteritems():
        workbook_to_lua(workbook, sheet, filename)
   
    
    
def __main__():
    excel_to_lua(excel_file_name, sheet2lua_dict)

__main__()