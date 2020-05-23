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
from libs.template import workbook_to_lua, workbook_suit_to_lua, workbook_array_to_lua, workbook_multi_key_to_lua
#import libs.template
#import libs.template
import os


#需要导入数据配置excel 文件名 (name.xlsx)，文件统一放置在docs目录 
excel_file_name = ur'tips'

#sheet名及对应导出的lua文件名
sheet2lua_dict = {ur"提示配置":ur"tips"
    }

def excel_to_lua(excelname, sheet2luas):
    workbook = load_excel(excelname)
    workbook_multi_key_to_lua(workbook, ur"提示配置", ur"tips", ["needLv", "id"])
    


def __main__():
    excel_to_lua(excel_file_name, sheet2lua_dict)
    
__main__()