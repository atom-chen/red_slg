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
from libs.template import workbook_to_lua, workbook_suit_to_lua, workbook_array_to_lua, workbook_multi_key_to_lua
# lua模块名称定义，也是文件名
excel_file_name = ur'resource'

#sheet名及对应导出的lua文件名
sheet2lua_dict = {ur"Sheet1":ur"resource",
    }


def excel_to_lua(excelname, sheet2luas):
    workbook = load_excel(excelname)
    for sheet, filename in sheet2luas.iteritems():
        workbook_to_lua(workbook, sheet, filename)
    
def __main__():
    excel_to_lua(excel_file_name, sheet2lua_dict)
    
__main__()


 	




		


		