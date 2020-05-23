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
from libs.template import workbook_to_lua

#需要导入数据配置excel 文件名 (name.xlsx)，文件统一放置在docs目录 
excel_file_name = ur'arena'

#sheet名及对应导出的lua文件名
sheet2lua_dict = {ur"重置挑战次数元宝花费":ur"arena_resetCost",\
    ur"排名奖励":ur"arena_rank_reward",\
    ur"节点奖励":ur"arena_history_reward",\
	ur"竞技场挑战奖励":ur"arena_fight_reward",\
	ur"历史最高排名奖励":ur"arena_highest_reward",\
    }


def excel_to_lua(excelname, sheet2luas):
    workbook = load_excel(excelname)
    for sheet, filename in sheet2luas.iteritems():
        workbook_to_lua(workbook, sheet, filename)
    
    
def __main__():
    excel_to_lua(excel_file_name, sheet2lua_dict)

__main__()