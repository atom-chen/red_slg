#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
VIP购买体力配置表
@author: ZhaoMing
@deprecated: 2013-11-20
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"vip_buy_energy")

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

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

vip_erl = "data_vip_buy_energy"
data_vip_buy_energy = module_header(ur"VIP购买体力", vip_erl, "zm", "vip_buy_energy.xlsx", "data_vip_buy_energy.py")
data_vip_buy_energy.append("""
-export([get_cost_gold/1]).
""")

cost_gold = []
cost_gold.append("%% @doc 获取单次消耗的元宝")
cost_gold.append("%% @spec get_cost_gold(Nth::int()) -> Gold::int()")
@load_sheel(work_book, ur"单次消耗")
def get_cost_gold(content):
    count = int(content[0])
    gold = int(content[1])
    cost_gold.append("get_cost_gold({0}) -> {1};".format(count, gold))
    return []
get_cost_gold()
cost_gold.append("get_cost_gold(_) -> 99999.")
data_vip_buy_energy.extend(cost_gold)

gen_erl(vip_erl, data_vip_buy_energy)
