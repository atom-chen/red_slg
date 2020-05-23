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
from libs.template import *#workbook_to_lua, workbook_suit_to_lua, workbook_array_to_lua

#需要导入数据配置excel 文件名 (name.xlsx)，文件统一放置在docs目录 
excel_file_name = ur'hero'

#sheet名及对应导出的lua文件名
sheet2lua_dict = {ur"英雄基础信息配置表":ur"hero_info",\
    #ur"英雄基础信息配置表":ur"hero_attr",\
    ur"英雄升级配置表":ur"hero_lv",\
   # ur"英雄获得配置表":ur"hero_gain",\
    ur"英雄军衔与颜色对应关系":ur"hero_quality_color",\
    ur"英雄星级":ur"hero_star_limit",\
  #  ur"技能升级消耗":ur"skill_up_expend",\
    }

def excel_to_lua(excelname, sheet2luas):
    workbook = load_excel(excelname)
    for sheet, filename in sheet2luas.iteritems():
        workbook_to_lua(workbook, sheet, filename)
    

    workbook_multi_key_to_lua(workbook, ur"英雄军衔配置表", ur"hero_quality",['quality', 'hero_id'])
    workbook_multi_key_to_lua(workbook, ur"星级属性", ur"hero_star_attr",['id', 'star'])
    workbook_one_kv_to_lua(workbook, ur"星级经验", ur"hero_star_exp", 'star', 'exp')
    workbook_array_to_lua(workbook, ur"星级消耗物品", ur"hero_star_cfg")
    workbook_multi_key_to_lua(workbook, ur"精英", ur"hero_quality_elite", ['hero_id', 'eliteLevel'])
    
    
def __main__():
    excel_to_lua(excel_file_name, sheet2lua_dict)

__main__()