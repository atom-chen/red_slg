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
#from libs.template import workbook_to_lua, workbook_suit_to_lua, workbook_array_to_lua, workbook_multi_key_to_lua
from libs.template import *
#import libs.template
import os


#需要导入数据配置excel 文件名 (name.xlsx)，文件统一放置在docs目录 
excel_file_name = ur'buildings'

#sheet名及对应导出的lua文件名
sheet2lua_dict = {ur"建筑tips":ur"building_tips_cfg"
    }

def excel_to_lua(excelname, sheet2luas):
    workbook = load_excel(excelname)
    workbook_multi_key_to_lua(workbook, ur"建筑升级配置", ur"building", ["id", "lv"])
    for sheet, filename in sheet2luas.iteritems():
        workbook_to_lua(workbook, sheet, filename)
    
    workbook_array_to_lua(workbook, ur'委托时间购买花费', ur'building_auto_time_buy')

def __main__():
    excel_to_lua(excel_file_name, sheet2lua_dict)
    
__main__()