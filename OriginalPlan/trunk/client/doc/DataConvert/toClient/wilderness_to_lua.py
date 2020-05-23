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
from libs.template import *

#需要导入数据配置excel 文件名 (name.xlsx)，文件统一放置在docs目录 
excel_file_name = ur'wilderness'

#sheet名及对应导出的lua文件名
sheet2lua_dict = {ur"核打击技能":ur"wilder_skill",\
    ur"部队基本配置":ur"wilder_army",\
    ur"矿基本配置":ur"wilder_mine",\
	ur"距离挂钩":ur"wilder_distance",\
	ur"野外资源购买":ur"wilder_buy",\
	ur"地表块配置":ur"wilderness_map_block",\
	ur"地表元素索引表":ur"wilderness_map_block_elem",\
	ur"图片索引表":ur"wilderness_map_resource",\
	ur"大地图地表配置":ur"wilderness_map_config",\
	ur"刷野怪配置":ur"wilder_monster",\
	ur"野怪奖励配置":ur"wilder_monster_reward",\
	ur"城防基础":ur"wilder_camp_defend",\
	ur"维修战力对应所需要铁矿":ur"wilder_army_fix",\
	ur"战功领奖":ur"wilder_feat",\
    }


def excel_to_lua(excelname, sheet2luas):
    workbook = load_excel(excelname)
    for sheet, filename in sheet2luas.iteritems():
        workbook_to_lua(workbook, sheet, filename)
    
def __main__():
    excel_to_lua(excel_file_name, sheet2lua_dict)

__main__()