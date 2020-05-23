#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
商店配置
@author: csh
@deprecated: 2014-07-29
'''
import os
# import random
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value, get_str

import time

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"shop")

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
BaseColumn1 = """
    shop_id
    ,itemID
    ,count
    ,costType
    ,costValue
    ,request
    ,pos
    ,maxBuyTimes
    ,accMaxBuyTimes
"""

class FieldClassBase1:
    def __init__(self):
        enum(FieldClassBase1, BaseColumn1)

# 生成域枚举           
BaseField = FieldClassBase1()

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

shop_erl = "data_shop"
data_shop = module_header(ur"商店配置", shop_erl, "zm", "shop.xlsx", "data_shop.py")
data_shop.append("""
-export([
         get_all_shop/0
         ,get_all_items/1
         ,get_max_times/3
         ,get_max_acc_times/3
         ,gain_loss_list/3
         ,cost/3
         ,one_buy_num/3
         ,condition/3
        ]).
""")


all_shop_list = []
all_items_list = {}
max_buy_times_list = []
max_buy_times_list.append("""
%% @doc 当日最大购买次数
%% @spec get_max_times(ShopID::int(), Pos::int(), ItemID::int()) -> int() """)

max_acc_buy_times_list = []
max_acc_buy_times_list.append("""
%% @doc 累计最大购买次数
%% @spec get_max_acc_times(ShopID::int(), Pos::int(), ItemID::int()) -> int() """)

gain_loss_list = []
gain_loss_list.append("""
%% @doc 购买获得消耗
%% @spec gain_loss_list(ShopID::int(), Pos::int(), ItemID::int()) -> list()""")

cost_list = []
cost_list.append("""
%% @doc 花费(只是给前端提供数据)
%% @spec cost(ShopID::int(), Pos::int(), ItemID::int()) -> {CostType::int(), CostValue::int()} """)

one_buy_num_list = []
one_buy_num_list.append("""
%% @doc 一次购买数量(只是给前端提供数据)
%% @spec one_buy_num(ShopID::int(), Pos::int(), ItemID::int()) -> int() """)

condition_list = []
condition_list.append("""
%% @doc 购买条件
%% @spec condition(ShopID::int(), Pos::int(), ItemID::int()) -> list()""")

@load_sheel(work_book, ur"商店配置表")
def get_data(content):
    shop_id = int(content[BaseField.shop_id])
    item_id = int(content[BaseField.itemID])
    count = int(content[BaseField.count])
    cost_type = int(content[BaseField.costType])
    cost_value = int(content[BaseField.costValue])
    request = get_str(content[BaseField.request], '')
    pos = int(content[BaseField.pos])
    max_buy_times = int(content[BaseField.maxBuyTimes])
    max_acc_buy_times = int(get_value(content[BaseField.accMaxBuyTimes], 999999999))
    all_shop_list.append("%d"%(shop_id))
    max_buy_times_list.append("get_max_times(%d, %d, %d) -> %d;"%(shop_id, pos, item_id, max_buy_times))
    max_acc_buy_times_list.append("get_max_acc_times(%d, %d, %d) -> %d;"%(shop_id, pos, item_id, max_acc_buy_times))
    cost_list.append("cost(%d, %d, %d) -> {%d, %d};"%(shop_id, pos, item_id, cost_type, cost_value))
    one_buy_num_list.append("one_buy_num(%d, %d, %d) -> %d;"%(shop_id, pos, item_id, count))
    condition_list.append("condition(%d, %d, %d) -> [%s];"%(shop_id, pos, item_id, request))
    all_items_list.setdefault(shop_id, [])
    if cost_type == 1: 
        loss_list = "[{del_gold, %d}]"%(cost_value) 
    elif cost_type == 2: 
        loss_list = "[{del_coin, %d}]"%(cost_value)
    elif cost_type == 3: 
        loss_list = "[{del_arena_coin, %d}]"%(cost_value)
    elif cost_type == 4:
        loss_list = "[{del_union_coin, %d}]"%(cost_value)
    elif cost_type == 5:
        loss_list = "[{del_prestige, %d}]"%(cost_value)

    all_items_list[shop_id].append("{%d, %d, %d}"%(shop_id, pos, item_id))
    gain_loss_list.append("gain_loss_list(%d, %d, %d) -> [{add_items, [{%d, %d}]}] ++ %s;"%(shop_id, pos, item_id, item_id, count, loss_list))
    return []
get_data()

gain_loss_list.append("gain_loss_list(_, _, _) -> [].")
max_buy_times_list.append("get_max_times(_, _, _) -> 0.")
max_acc_buy_times_list.append("get_max_acc_times(_, _, _) -> 0.")
cost_list.append("cost(_, _, _) -> {1, 0}.")
one_buy_num_list.append("one_buy_num(_, _, _) -> 0.")
condition_list.append("condition(_, _, _) -> [].")

data_shop.append("""
%% @doc 获取所有的商店列表
%% @spec get_all_shop() -> [int()] """)
data_shop.append("get_all_shop() -> [%s]."%(",".join(unique_list(all_shop_list))))
data_shop.extend(gain_loss_list)
data_shop.extend(max_buy_times_list)
data_shop.extend(max_acc_buy_times_list)
data_shop.extend(cost_list)
data_shop.extend(one_buy_num_list)
data_shop.extend(condition_list)

data_shop.append("""
%% @doc 商店所有物品
%% @spec get_all_items(ShopID::int()) -> [{ShopID::int(), Pos::int(), ItemID::int()}] """)
for (k, v) in all_items_list.items():
    data_shop.append("get_all_items(%d) -> [%s];"%(k, ",".join(v)))
data_shop.append("get_all_items(_) -> [].")

gen_erl(shop_erl, data_shop)
