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
from libs.template import workbook_to_lua, workbook_suit_to_lua, workbook_array_to_lua
import os
#需要导入数据配置excel 文件名 (name.xlsx)，文件统一放置在docs目录 
excel_file_name = ur'eqm'

#sheet名及对应导出的lua文件名
sheet2lua_dict = {ur"装备ID和属性":ur"eqm", 
#ur"装备强化上限":ur"eqm_strengthen_max", 
ur"提星的等级要求和加成属性":ur"eqm_up_star",
ur"装备强化需求经验":ur"eqm_strengthen",
ur"套装属性":ur"eqm_suit",
ur"装备品质属性和经验值":"eqm_quality_exp"}


def excel_to_lua(excelname, sheet2luas):
    workbook = load_excel(excelname)
    for sheet, filename in sheet2luas.iteritems():
        p=workbook_to_lua(workbook, sheet, filename)
        if filename == "eqm_suit":
            os.system("lua eqm.lua \"%s\" eqm_suit_index.lua"%(p))
    
    two_index_dict = {ur"装备提星消耗":ur"eqm_star"}
    for sheet, filename in two_index_dict.iteritems():
        workbook_suit_to_lua(workbook, sheet, filename, 2)
    workbook_array_to_lua(workbook, "强化消耗和强化上限", "eqm_cfg")    

def __main__():
    excel_to_lua(excel_file_name, sheet2lua_dict)

__main__()