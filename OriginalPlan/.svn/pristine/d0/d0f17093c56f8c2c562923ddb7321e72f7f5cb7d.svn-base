#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
符石配置表
@author: ZhaoMing
@deprecated: 2013-11-20
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"stone")

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

stone_erl = "data_stone"
data_stone = module_header(ur"符石配置", stone_erl, "zm", "stone.xlsx", "data_stone.py")
data_stone.append(""" 
-include("hero_attr.hrl").
-export([
         max_exp/1
         ,max_lev/0
         ,init_item/1
         ,open_lev/1
         ,stone_list/1
         ,stone_color/1
         ,stone_type/1
         ,quality_id/1
         ,quality_color/1
         ,quality_stone_list/0
         ,get_compensate/1
         ,suit/3
         ,cost_coin/1
         ,get_attr/3
         ,get_attr_type/1
         ,buy_stone_energy_cost_gold/1
        ]).

init_item(Type) ->
    lists:nth(1, stone_list(Type)).
""")

open_lev = []
open_lev.append("%% @spec open_lev(Pos :: int()) -> HeroLev :: int()")
open_lev.append("%% @doc 符石开放等级")
@load_sheel(work_book, ur"开启等级")
def get_open_lev(content):
    pos = int(content[0])
    lev = int(content[1])
    open_lev.append("open_lev({0}) -> {1};".format(pos, lev))
    return []

get_open_lev()
open_lev.append("open_lev(_) -> 999.")
data_stone.extend(open_lev)

max_exp = []
max_exp.append("%% @spec max_exp(StoneLev :: int()) -> Exp :: int()")
max_exp.append("%% @doc 升级需要经验")
max_lev = 0
@load_sheel(work_book, ur"经验升级")
def get_max_exp(content):
    lev = int(content[0])
    exp = int(content[1])
    global max_lev
    if lev > max_lev:
        max_lev = lev
    max_exp.append("max_exp({0}) -> {1};".format(lev, exp))
    return []

get_max_exp()
max_exp.append("max_exp(_) -> false.")
data_stone.extend(max_exp)

data_stone.append("max_lev() -> %d."%(max_lev))

stone_attr = []
stone_attr.append("%% @spec get_attr(StoneType :: int(), Color::int(), StoneLev::int()) -> lists()")
stone_attr.append("%% @doc 符石加属性")
@load_sheel(work_book, ur"属性配置")
def get_stone_attr(content):
    s_type = int(content[0])
    color = int(content[1])
    lev = int(content[2])
    value = int(content[3])
    stone_attr.append("get_attr({2}, {0}, {1}) -> [{{get_attr_type({2}), {3}}}];".format(color, lev, s_type, value))
    return []
get_stone_attr()
stone_attr.append("get_attr(_, _, _) -> [].")
data_stone.extend(stone_attr)

type2attr = []
type2attr.append("%% @spec get_attr_type(StoneType::int()) -> AttrType ::int()")
@load_sheel(work_book, ur"符石类型与属性定义")
def get_attr_type(content):
    s_type = int(content[0])
    a_type = str(content[2])
    type2attr.append("get_attr_type({0}) -> {1};".format(s_type, a_type))
    return []

get_attr_type()
type2attr.append("get_attr_type(_) -> 0.")
data_stone.extend(type2attr)

stone_list = []
stone_color = []
stone_type = []
@load_sheel(work_book, ur"激活")
def get_quality_list(content):
    s_type    = int(content[0])
    item_id_1 = int(content[1])
    item_id_2 = int(content[2])
    item_id_3 = int(content[3])
    item_id_4 = int(content[4])
    stone_list.append("stone_list(%d) -> [%d, %d, %d, %d];"%(s_type, item_id_1, item_id_2, item_id_3, item_id_4))
    stone_color.append("stone_color(%d) -> %d;"%(item_id_1, 2))
    stone_color.append("stone_color(%d) -> %d;"%(item_id_2, 3))
    stone_color.append("stone_color(%d) -> %d;"%(item_id_3, 4))
    stone_color.append("stone_color(%d) -> %d;"%(item_id_4, 5))

    stone_type.append("stone_type(%d) -> %d;"%(item_id_1, s_type))
    stone_type.append("stone_type(%d) -> %d;"%(item_id_2, s_type))
    stone_type.append("stone_type(%d) -> %d;"%(item_id_3, s_type))
    stone_type.append("stone_type(%d) -> %d;"%(item_id_4, s_type))
    return []
get_quality_list()
stone_list.append("stone_list(_) -> [0, 0, 0, 0].")
stone_color.append("stone_color(_) -> 0.")
stone_type.append("stone_type(_) -> 0.")
data_stone.extend(stone_list)
data_stone.extend(stone_color)
data_stone.extend(stone_type)

quality_id = []
quality_color = []
quality_stone_list = []
@load_sheel(work_book, ur"品质转换")
def get_quality_id(content):
    color = int(content[0])
    item_id = int(content[1])
    quality_id.append("quality_id(%d) -> %d;"%(color, item_id))
    quality_color.append("quality_color(%d) -> %d;"%(item_id, color)),
    quality_stone_list.append("%d"%(item_id))
    return []
get_quality_id()
quality_id.append("quality_id(_) -> 0.")
quality_color.append("quality_color(_) -> 0.")
data_stone.extend(quality_id)
data_stone.extend(quality_color)
data_stone.append("quality_stone_list() -> [%s]."%(",".join(quality_stone_list)))

compensate = []
@load_sheel(work_book, ur"补偿")
def get_compensate(content):
    item_id = int(content[0])
    energy = int(content[1])
    coin = int(content[2])
    compensate.append("get_compensate(%d) -> [{add_stone_energy, %d}, {add_coin, %d}];"%(item_id, energy, coin))
    return []
get_compensate()
compensate.append("get_compensate(_) -> [].")
data_stone.extend(compensate)

suit = []
suit_list = []
@load_sheel(work_book, ur"套装属性")
def get_suit(content):
    item_type = int(content[0])
    color = int(content[1])
    attrlist_1 = str(content[2])
    attrlist_2 = str(content[3])
    attrlist_3 = str(content[4])
    suit.append("suit(%d, %d, %d) -> [%s];"%(item_type, color, 2, attrlist_1))
    suit.append("suit(%d, %d, %d) -> [%s];"%(item_type, color, 4, attrlist_2))
    suit.append("suit(%d, %d, %d) -> [%s];"%(item_type, color, 6, attrlist_3))
    return []
get_suit()
suit.append("suit(_, _, _) -> [].")
data_stone.extend(suit)

cost_coin = []
@load_sheel(work_book, ur"经验石品质石金币消耗")
def get_cost_coin(content):
    item_id = int(content[0])
    coin = int(content[1])
    cost_coin.append("cost_coin(%d) -> %d;"%(item_id, coin))
    return []
get_cost_coin()
cost_coin.append("cost_coin(_) -> 999999999999.")
data_stone.extend(cost_coin)

buy_energy =[]
@load_sheel(work_book, ur"购买能量")
def get_buy_energy(content):
    nth = int(content[0])
    gold = int(content[1])
    buy_energy.append("buy_stone_energy_cost_gold(%d) -> %d;"%(nth, gold))
    return []
get_buy_energy()
buy_energy.append("buy_stone_energy_cost_gold(_) -> 99999999.")
data_stone.extend(buy_energy)

gen_erl(stone_erl, data_stone)
