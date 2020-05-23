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
from libs.template import *

#需要导入数据配置excel 文件名 (name.xlsx)，文件统一放置在docs目录 
excel_file_name = ur'adjunct'

#sheet名及对应导出的lua文件名
sheet2lua_dict = {ur"配件ID和属性":ur"adjunct_attr",\
    ur"增强物品":ur"adjunct_strengthen_item",\
    }

def excel_to_lua(excelname, sheet2luas):
    workbook = load_excel(excelname)
    for sheet, filename in sheet2luas.iteritems():
        workbook_to_lua(workbook, sheet, filename)

    #workbook_multi_key_to_lua(workbook, ur"配件ID和属性", "adjunct_hero", ["hero_id", "position", "adjunct"], False, ["quality_level"])
    workbook_multi_key_to_lua(workbook, ur"英雄配件绑定", "adjunct_hero", ["hero_id", "position"], False)
    
    
def __main__():
    excel_to_lua(excel_file_name, sheet2lua_dict)

__main__()