#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
随机商店配置
@author: csh
@deprecated: 2014-07-29
'''
import os
import __builtin__
# import random
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value, get_str

import time

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"shop_rand")

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

## 必须和excel里面的列保持一致的顺序
BaseColumn1 = """
    shop_id
    ,postion
    ,itemID
    ,count
    ,weight
    ,costType
    ,costValue
    ,request
    ,maxBuyTimes
    ,accMaxBuyTimes
"""

CostColumn = """
    nth, cost
"""

RefreshColumn = """
    shopID, autoRefreshTime
"""

BaseField    = Field('BaseField'    , BaseColumn1)
CostField    = Field('CostField'    , CostColumn)
RefreshField = Field('RefreshField' , RefreshColumn)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

rand_shop_erl = "data_rand_shop"
data_rand_shop = module_header(ur"商店配置", rand_shop_erl, "zm", "shop_rand.xlsx", "data_rand_shop.py")
data_rand_shop.append("""
-export([
         get_all_shop/0
         ,get_all_pos/1
         ,get_max_times/3
         ,get_max_acc_times/3
         ,gain_list/3
         ,cost_type_code/3
         ,cost_type/3
         ,cost_value/3
         ,one_buy_num/3
         ,condition/3
         ,refresh_cost/1
         ,auto_refresh_time_list/1
         ,rand_item/2
        ]).
""")


all_shop_list = []
all_items_weight_list_by_pos = {}
all_pos_list = {}
max_buy_times_list = []
max_buy_times_list.append("""
%% @doc 当日最大购买次数
%% @spec get_max_times(ShopID::int(), Pos::int(), ItemID::int()) -> int() """)

max_acc_buy_times_list = []
max_acc_buy_times_list.append("""
%% @doc 累计最大购买次数
%% @spec get_max_acc_times(ShopID::int(), Pos::int(), ItemID::int()) -> int() """)


gain_list = []
gain_list.append("""
%% @doc 购买获得
%% @spec gain_list(ShopID::int(), Pos::int(), ItemID::int()) -> list()""")

code_type_code_list = []
code_type_code_list.append("""
%% @doc 花费(只是给前端提供数据)
%% @spec cost_type_code(ShopID::int(), Pos::int(), ItemID::int()) -> int() """)

code_type_list = []
code_type_list.append("""
%% @doc 花费(只是给前端提供数据)
%% @spec cost_type(ShopID::int(), Pos::int(), ItemID::int()) -> atom() """)

cost_value_list = []
cost_value_list.append("""
%% @doc 花费(只是给前端提供数据)
%% @spec cost_value(ShopID::int(), Pos::int(), ItemID::int()) -> int() """)


one_buy_num_list = []
one_buy_num_list.append("""
%% @doc 一次购买数量(只是给前端提供数据)
%% @spec one_buy_num(ShopID::int(), Pos::int(), ItemID::int()) -> int() """)

condition_list = []
condition_list.append("""
%% @doc 购买条件
%% @spec condition(ShopID::int(), Pos::int(), ItemID::int()) -> list()""")



@load_sheel(work_book, ur"随机商店-基础配置")
def get_data(content, all_content, row):
    shop_id = int(prev(all_content, row, BaseField.shop_id))
    item_id = int(content[BaseField.itemID])
    count = int(content[BaseField.count])
    weight = int(content[BaseField.weight])
    cost_type = int(content[BaseField.costType])
    cost_value = get_str(content[BaseField.costValue], '')
    request = get_str(content[BaseField.request], '')
    pos = int(prev(all_content, row, BaseField.postion))
    max_buy_times = int(content[BaseField.maxBuyTimes])
    max_acc_buy_times = int(get_value(content[BaseField.accMaxBuyTimes], 999999999))
    all_shop_list.append("%d"%(shop_id))
    max_buy_times_list.append("get_max_times(%d, %d, %d) -> %d;"%(shop_id, pos, item_id, max_buy_times))
    max_acc_buy_times_list.append("get_max_acc_times(%d, %d, %d) -> %d;"%(shop_id, pos, item_id, max_acc_buy_times))
    code_type_code_list.append("cost_type_code(%d, %d, %d) -> %d;"%(shop_id, pos, item_id, cost_type))
    one_buy_num_list.append("one_buy_num(%d, %d, %d) -> %d;"%(shop_id, pos, item_id, count))
    condition_list.append("condition(%d, %d, %d) -> [%s];"%(shop_id, pos, item_id, request))
    shop_pos = "ShopID =:= %d, Pos =:= %d"%(shop_id, pos)
    all_items_weight_list_by_pos.setdefault(shop_pos, [])
    all_pos_list.setdefault(shop_id, [])
    all_pos_list[shop_id].append("%d"%(pos))
    if cost_type == 1: 
        cost_type_str = "del_gold" 
    elif cost_type == 2: 
        cost_type_str = "del_coin"
    elif cost_type == 3: 
        cost_type_str = "del_arena_coin"
    elif cost_type == 4:
        cost_type_str = "del_union_coin"
    elif cost_type == 5:
        cost_type_str = "del_prestige"

    code_type_list.append("cost_type(%d, %d, %d) -> %s;"%(shop_id, pos, item_id, cost_type_str))
    cost_value_list.append("cost_value(%d, %d, %d) -> Index = util:get_weight(1, [W ||{_, W} <- [%s]]), {Value, _} = lists:nth(Index, [%s]), Value;"%(shop_id, pos, item_id, cost_value, cost_value))
    all_items_weight_list_by_pos[shop_pos].append("{%d, %d, %d}"%(item_id, count, weight))
    gain_list.append("gain_list(%d, %d, %d) -> [{add_items, [{%d, %d}]}];"%(shop_id, pos, item_id, item_id, count))
    return []
get_data()

gain_list.append("gain_list(_, _, _) -> [].")
max_buy_times_list.append("get_max_times(_, _, _) -> 0.")
max_acc_buy_times_list.append("get_max_acc_times(_, _, _) -> 0.")
code_type_code_list.append("cost_type_code(_, _, _) -> 0.")
code_type_list.append("cost_type(_, _, _) -> null.")
cost_value_list.append("cost_value(_, _, _) -> 0.")
one_buy_num_list.append("one_buy_num(_, _, _) -> 0.")
condition_list.append("condition(_, _, _) -> [].")

data_rand_shop.append("""
%% @doc 获取所有的商店列表
%% @spec get_all_shop() -> [int()] """)
data_rand_shop.append("get_all_shop() -> [%s]."%(",".join(unique_list(all_shop_list))))
data_rand_shop.extend(gain_list)
data_rand_shop.extend(max_buy_times_list)
data_rand_shop.extend(max_acc_buy_times_list)
data_rand_shop.extend(code_type_code_list)
data_rand_shop.extend(code_type_list)
data_rand_shop.extend(cost_value_list)
data_rand_shop.extend(one_buy_num_list)
data_rand_shop.extend(condition_list)

data_rand_shop.append("""
%% @doc 随机物品
%% @spec rand_item(ShopID, Pos) -> list() """)
for (k, v) in all_items_weight_list_by_pos.items():
    data_rand_shop.append("rand_item(ShopID, Pos) when %s -> util:list_rands_by_rate([%s], 1);"%(k, ",".join(v)))
data_rand_shop.append("rand_item(_, _) -> [].")

data_rand_shop.append("""
%% @doc 所有位置
%% @spec get_all_pos(ShopID) -> list() """)
for (k, v) in all_pos_list.items():
    data_rand_shop.append("get_all_pos(ShopID) when ShopID =:= %s -> [%s];"%(k, ",".join(unique_list(v))))
data_rand_shop.append("get_all_pos(_) -> [].")


refresh_cost_list = []
refresh_cost_list.append("""
%% @doc 刷新消耗
%% @spec refresh_cost(Nth::int()) -> list() """)

max_refresh_nth = 0

@load_sheel(work_book, ur"随机商店-手动刷新消耗")
def get_refresh(content):
    nth = int(content[CostField.nth])
    gold = int(content[CostField.cost])
    global max_refresh_nth
    if max_refresh_nth < nth:
        max_refresh_nth = nth
    refresh_cost_list.append("refresh_cost(Nth) when Nth =:= %d -> [{del_gold, %d}];"%(nth, gold))
    
    return []

get_refresh()
refresh_cost_list.append("refresh_cost(_) -> refresh_cost(%d)."%(max_refresh_nth))

data_rand_shop.extend(refresh_cost_list)

auto_refresh_time_list = []
auto_refresh_time_list.append("""
%% @doc 自动刷新时间
%% @spec auto_refresh_time_list(ShopID) -> list() """)

@load_sheel(work_book, ur"随机商店-刷新时间")
def get_auto_refresh(content):
    shop_id = int(content[RefreshField.shopID])
    time_str = get_str(content[RefreshField.autoRefreshTime], '')
    time_str = time_str.replace(",", "},{")
    time_str = time_str.replace(":", ",")
    auto_refresh_time_list.append("""
auto_refresh_time_list(ShopID) when ShopID =:= %d -> 
    F = fun(Time, List) ->
                case Time of
                    {_, _} -> List ++ [Time];
                    {H, M, _S} -> List ++ [{H, M}];
                    _ -> List
                end
        end,
    lists:foldl(F, [], [{%s}]);"""%(shop_id, time_str))
    return []

get_auto_refresh()

auto_refresh_time_list.append("auto_refresh_time_list(_) -> [].")
data_rand_shop.extend(auto_refresh_time_list)

gen_erl(rand_shop_erl, data_rand_shop)
