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

#需要导入数据配置excel 文件名 (name.xlsx)，文件统一放置在docs目录 
excel_file_name = ur'dungeon'

#sheet名及对应导出的lua文件名
sheet2lua_dict = {ur"副本配置":ur"dungeon",\
			ur"星级条件":ur"dungeon_star_request",\
			ur"战斗形式配置":ur"dungeon_fight_type",\
			ur"精英副本买次数收费":ur"dungeon_elite_cost",\
    }

def excel_to_lua(excelname, sheet2luas):
    workbook = load_excel(excelname)
    for sheet, filename in sheet2luas.iteritems():
        print(sheet, filename)
        workbook_to_lua(workbook, sheet, filename)
   
    
    
def __main__():
    excel_to_lua(excel_file_name, sheet2lua_dict)

__main__()