#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
指引
@author: ZhaoMing
@deprecated: 2013-11-20
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"guide")

# Erlang模块头说明，主要说明该文件作用，会自动添加-module(module_name).
# module_header函数隐藏了第三个参数，是指作者，因此也可以module_header(ur"礼包数据", module_name, "King")


# Erlang需要导出的函数接口, append与erlang的++也点类似，用于python的list操作
# Erlang函数一些注释，可以不写，但建议写出来

# 生成枚举的工具函数
def enum(module, str_enum):
    str_enum = str_enum.replace(" ", "")
    str_enum = str_enum.replace("\n", "")
    idx = 0  
    for name in str_enum.split(","):  
        if '=' in name:  
            name,val = name.rsplit('=', 1)            
            if val.isalnum():               
                idx = eval(val)  
        setattr(module, name.strip(), idx)  
        idx += 1

## 必须和excel里面的列保持一致的顺序
BaseColumn = """
    id, desc, level, maxLevel, sys, dungeon, finishTask, finishActivity, 
    pre, next, repeatGuide, dialog, guideGold
"""
 
class FieldClassBase:
    def __init__(self):
        enum(FieldClassBase, BaseColumn)

# 生成域枚举           
BaseField = FieldClassBase()

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

guide_erl = "data_guide"
data_guide = module_header(ur"指引", guide_erl, "zm", "guide.xlsx", "data_guide.py")
data_guide.append("""
-export([
         gain_list/1
        ]).
""")

gain_list = []
gain_list.append("""
%% @doc 指引获得奖励
%% @spec gain_list(Guide::int()) -> list() """)

@load_sheel(work_book, ur"Sheet1")
def get_base(content):
    guide = int(content[BaseField.id])
    gold = int(get_value(content[BaseField.guideGold], 0))
    if gold != 0:
        gain_list.append("gain_list(Guide) when Guide =:= %d -> [{add_gold, %d}];"%(guide, gold))
    return []

get_base()

gain_list.append("gain_list(_) -> [].")
data_guide.extend(gain_list)

gen_erl(guide_erl, data_guide)
