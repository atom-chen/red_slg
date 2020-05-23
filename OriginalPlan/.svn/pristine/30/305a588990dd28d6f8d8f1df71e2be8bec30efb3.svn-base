#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
王牌挑战
@author: ZhaoMing
@deprecated: 2015年01月21日
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"king_boss")

# Erlang模块头说明，主要说明该文件作用，会自动添加-module(module_name).
# module_header函数隐藏了第三个参数，是指作者，因此也可以module_header(ur"礼包数据", module_name, "King")


# Erlang需要导出的函数接口, append与erlang的++也点类似，用于python的list操作
# Erlang函数一些注释，可以不写，但建议写出来

# 生成枚举的工具函数
def Field(module, str_enum):
    class_module = __builtin__.type(module, (object,), {})
    str_enum = str_enum.replace(" ", "")
    str_enum = str_enum.replace("\n", "")
    idx = 0
    for name in str_enum.split(","):  
        if '=' in name:  
            name,val = name.rsplit('=', 1)            
            if val.isalnum():               
                idx = eval(val)
        setattr(class_module, name.strip(), idx)  
        idx += 1
    return class_module

BaseIndex = """
    dungeonID, items, gold, coin, dailog, icon
"""

ResetIndex = """
    resetCount, gold
"""

BaseField    = Field('BaseField'    , BaseIndex)
ResetField   = Field('ResetField'   , ResetIndex)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

king_boss_erl = "data_king_boss"
data_king_boss = module_header(ur"王牌挑战", king_boss_erl, "zm", "king_boss.xlsx", "data_king_boss.py")

data_king_boss.append("""
-export([
         reset_cost/1,
         first_pass_gain/1
        ]).
"""
)

first_pass_gain_list = []
first_pass_gain_list.append("""
%% @doc 首次通关奖励
%% @spec first_pass_gain(DungeonID::int()) -> list() """)

@load_sheel(work_book, ur"首次通关奖励")
def get_base(content):
    dungeon_id = int(content[BaseField.dungeonID])
    items = get_str(content[BaseField.items], '')
    gold = int(get_value(content[BaseField.gold], 0))
    coin = int(get_value(content[BaseField.coin], 0))
    first_pass_gain_list.append("first_pass_gain(%d) -> [{add_items, [%s]}, {add_gold, %d}, {add_coin, %d}];"%(dungeon_id, items, gold, coin))
    return []

get_base()
first_pass_gain_list.append("first_pass_gain(_) -> [].")

data_king_boss.extend(first_pass_gain_list)

reset_cost_list = []
reset_cost_list.append("""
%% @doc 重置花费
%% @spec reset_cost(Nth::int()) -> list() """)

@load_sheel(work_book, ur"重置花费")
def get_cost(content):
    nth = int(content[ResetField.resetCount])
    gold = int(content[ResetField.gold])
    reset_cost_list.append("reset_cost(%d) -> [{del_gold, %d}];"%(nth, gold))
    return []

get_cost()

reset_cost_list.append("reset_cost(_) -> [].")

data_king_boss.extend(reset_cost_list)

gen_erl(king_boss_erl, data_king_boss)
