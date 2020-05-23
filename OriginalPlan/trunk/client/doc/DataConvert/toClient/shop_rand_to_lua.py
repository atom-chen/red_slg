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
import traceback
#需要导入数据配置excel 文件名 (name.xlsx)，文件统一放置在docs目录 
excel_file_name = ur'shop_rand'

#sheet名及对应导出的lua文件名
sheet2lua_dict = {ur"随机商店-手动刷新消耗":ur"shop_rand_refresh"
    }

# 读取领取条件Sheel的内容，第一行标题行会省略不读，但一定要定义标题，方便理解

def excel_to_lua(excelname, sheet2luas):
    workbook = load_excel(excelname)
    for sheet, filename in sheet2luas.iteritems():
        workbook_to_lua(workbook, sheet, filename)

def __main__():
    excel_to_lua(excel_file_name, sheet2lua_dict)
    
__main__()
