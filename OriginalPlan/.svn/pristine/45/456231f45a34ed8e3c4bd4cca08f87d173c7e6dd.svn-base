#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
技能点购买配置
@author: ZhaoMing
@deprecated: 2014-07-08
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value,gen_php

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"skill")

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
    nth ,gold
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

skill_erl = "data_skill_point"
data_skill = module_header(ur"技能点购买配置", skill_erl, "lhh", "skill.xlsx", "data_skill_point.py")
data_skill.append("""
-include("skill.hrl").

-export([get/1]).

""")

stone_dict = {}
skill_base = []
skill_base.append("%% @spec get(Times::int()) -> Cost::int().")
@load_sheel(work_book, ur"技能点购买")
def get_base_cost(content):
    times = int(content[BaseField.nth])-1
    cost = int(content[BaseField.gold])
    skill_base.append("""get({0}) -> {1}; """.format(times, cost))
    return []

get_base_cost()
skill_base.append("get(_) -> 500.")
data_skill.extend(skill_base)

gen_erl(skill_erl, data_skill)