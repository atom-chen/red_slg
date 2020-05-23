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
import os

#需要导入数据配置excel 文件名 (name.xlsx)，文件统一放置在docs目录 
excel_file_name = ur'hero_inst'

#sheet名及对应导出的lua文件名
sheet2lua_dict = {ur"子项目&属性系数":ur"inst_attr",
                   ur"等级属性":ur"inst_level",
                   ur"英雄界面":ur"inst_layout",
				    ur"点数购买":ur"inst_buy",
    }

# 读取领取条件Sheel的内容，第一行标题行会省略不读，但一定要定义标题，方便理解

def excel_to_lua(excelname, sheet2luas):
    workbook = load_excel(excelname)
    for sheet, filename in sheet2luas.iteritems():
        workbook_to_lua(workbook, sheet, filename)
    
    workbook_suit_to_lua(workbook, ur"英雄获得配置", "inst_up", 2)
    workbook_array_to_lua(workbook, ur"共享数据", "inst_common")
    workbook_multi_key_to_lua(workbook, ur"英雄编制扩充", ur"inst_hero_max_num", ["hero_id", "max_num"])
    workbook_multi_key_to_lua(workbook, ur"英雄生产", ur"inst_produce_hero", ["hero_id", "hero_num"])
    workbook_multi_key_to_lua(workbook, ur"建筑解锁英雄", ur"inst_unlock_hero", ["id", "level"])




def __main__():
    excel_to_lua(excel_file_name, sheet2lua_dict)
    
__main__()