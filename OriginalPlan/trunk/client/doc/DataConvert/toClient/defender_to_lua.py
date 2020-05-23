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


#需要导入数据配置excel 文件名 (name.xlsx)，文件统一放置在docs目录 
excel_file_name = ur'defender'

#sheet名及对应导出的lua文件名
sheet2lua_dict = {ur"抵抗侵略基础配置表":ur"defender_cdTime",\
    ur"清楚冷却CD消耗":ur"defender_cost",\
	ur"任务主题配置表":ur"defender_theme",\
	ur"排行榜奖励配置":ur"defender_rankAward",\
	ur"波次奖励配置":ur"defender_passAward",\
	ur"敌人刷怪配置":ur"defender_monster",\
	ur"增援配置":ur"defender_mate",\
    }

def excel_to_lua(excelname, sheet2luas):
    workbook = load_excel(excelname)
    for sheet, filename in sheet2luas.iteritems():
        workbook_to_lua(workbook, sheet, filename)
    


def __main__():
    excel_to_lua(excel_file_name, sheet2lua_dict)
    
__main__()