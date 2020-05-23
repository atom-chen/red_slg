#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
体力消耗转换活跃度比率配置
@author: csh
@deprecated: 2015-01-20
'''
import os
# import random
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

import time

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"power_to_liveness")

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
# 好友基础配置表
BaseColumn1 = """
    rate
"""

 
class FieldClassBase1:
    def __init__(self):
        enum(FieldClassBase1, BaseColumn1)

# 生成域枚举           
BaseField1 = FieldClassBase1()

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

power_to_liveness_erl = "data_power_to_liveness"
data_power_to_liveness = module_header(ur"体力消耗转换活跃度比率配置", power_to_liveness_erl, "csh", "power_to_liveness.xlsx", "data_power_to_liveness.py")
data_power_to_liveness.append("""
-export([
        get_rate/0
        ]).
""")

# 获取最小等级
power_to_liveness_rate = []
power_to_liveness_rate.append("\n\n%% 获取体力消耗转换活跃度比率")
power_to_liveness_rate.append("%%@spec get_rate() -> rate :: int()")
@load_sheel(work_book, ur"Sheet1")
def get_rate(content):
    rate = int(get_value(content[BaseField1.rate], 0))
    power_to_liveness_rate.append("""get_rate() -> {0}.""".format(rate))
    return []
get_rate()
data_power_to_liveness.extend(power_to_liveness_rate)



gen_erl(power_to_liveness_erl, data_power_to_liveness)

