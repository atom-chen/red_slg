#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
点金石配置
@author: ZhaoMing
@deprecated: 2013-11-20
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"gold2coin")

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
    ,pre_task_id
    ,min_role_lev
    ,item_reward
    ,coin_reward
    ,gold_reward
    ,energy_reward
    ,target
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

gold2coin_erl = "data_gold2coin"
data_gold2coin = module_header(ur"任务配置", gold2coin_erl, "zm", "gold2coin.xlsx", "data_gold2coin.py")
data_gold2coin.append("""
-export([
         cost_gold/1
         ,get_coin/1
         ,add_coin/1
         ,get_weight/2
         ,add_coin_by_build_lev/1
        ]).
""")

cost_gold = []
cost_gold.append("%% @spec cost_gold(Count :: int()) -> Gold :: int().")
get_coin = []
get_coin.append("%% @spec get_coin(Count :: int()) -> Coin :: int().")
count_list = []
@load_sheel(work_book, ur"基础配置")
def get_base(content):
    count = int(content[0])
    gold = int(content[1])
    coin = int(content[2])
    cost_gold.append("cost_gold(%d) -> %d;"%(count, gold))
    get_coin.append("get_coin(%d) -> %d;"%(count, coin))
    count_list.append(count)
    return []

get_base()
cost_gold.append("cost_gold(_) -> cost_gold(%d)."%(max(count_list)))
get_coin.append("get_coin(_) -> get_coin(%d)."%(max(count_list)))
data_gold2coin.extend(cost_gold)
data_gold2coin.extend(get_coin)

add_coin = []
add_coin.append("%% @spec add_coin(RoleLev::int()) -> Coin::int().")
role_lev_list = []
@load_sheel(work_book, ur"金币补偿")
def get_add_coin(content):
    role_lev = int(content[0])
    coin = int(content[1])
    add_coin.append("add_coin(%d) -> %d;"%(role_lev, coin))
    role_lev_list.append(role_lev)
    return []

get_add_coin()
add_coin.append("add_coin(_) -> add_coin(%d)."%(min(role_lev_list)))
data_gold2coin.extend(add_coin)

weight_list = []
weight_list.append("""
%% @doc 铸币心得权重配置
%% @spec get_weight(Mul::int(), Assign::int()) -> Weight::int() """)
@load_sheel(work_book, ur"铸币心得配置")
def get_weight(content):
    assign = int(content[0])
    mul_2 = int(content[1])
    mul_3 = int(content[2])
    mul_10 = int(content[3])
    weight_list.append("get_weight(Mul, Assign) when Mul =:= 2, Assign =:= %d -> %d;"%(assign, mul_2))
    weight_list.append("get_weight(Mul, Assign) when Mul =:= 3, Assign =:= %d -> %d;"%(assign, mul_3))
    weight_list.append("get_weight(Mul, Assign) when Mul =:= 10, Assign =:= %d -> %d;"%(assign, mul_10))
    return []

get_weight()
weight_list.append("get_weight(_, _) -> 0.")
data_gold2coin.extend(weight_list)

build_add_coin_list = []
build_add_coin_list.append("""
%% @doc 建筑等级附加金币
%% @spec add_coin_by_build_lev(BuildLev::int()) -> Coin::int() """)

@load_sheel(work_book, ur"建筑等级对应的金币增加量")
def get_build_add_coin(content):
    lev = int(content[0])
    coin = int(content[1])
    build_add_coin_list.append("add_coin_by_build_lev(BuildLev) when BuildLev =:= %d -> %d;"%(lev, coin))
    return []

get_build_add_coin()
build_add_coin_list.append("add_coin_by_build_lev(_) -> 0.")
data_gold2coin.extend(build_add_coin_list)

gen_erl(gold2coin_erl, data_gold2coin)
