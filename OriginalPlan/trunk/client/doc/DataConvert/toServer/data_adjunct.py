#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
配件配置
@author: ZhaoMing
@deprecated: 2015年01月21日
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"adjunct")

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
    adjunctID, pos, quality, name, hero_id, attr, add_list, next_id, up_item, up_coin
"""

PercentIndex = """
    add_id, name, add_percent
"""

BaseField    = Field('BaseField'    , BaseIndex)
PercentField = Field('PercentField' , PercentIndex)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

new_adjunct_erl = "data_adjunct"
data_adjunct = module_header(ur"配件配置", new_adjunct_erl, "zm", "adjunct.xlsx", "data_adjunct.py")

data_adjunct.append("""
-export([
         full_add_list/2
         ,is_max_adjunct_id/2
         ,is_adjunct_fit_hero/2
         ,get_pos/2
         ,get_next_adjunct_id/2
         ,get_pre_adjunct_id/2
         ,up_cost/2
         ,get_base_attr/2
         ,get_percent_attr/1
         ,need_hero_quality/2
        ]).
"""
)

full_add_list = []
full_add_list.append("""
%% @doc 所有的镶嵌列表
%% @spec full_add_list(HeroID::int(), AdjunctID::int()) -> [AddID::int()] """)

is_adjunct_fit_hero_list = []
is_adjunct_fit_hero_list.append("""
%% @doc 配件是否符合英雄
%% @spec is_adjunct_fit_hero(AdjunctID::int(), HeroID::int()) -> true | false """)

get_pos_list = []
get_pos_list.append("""
%% @doc 获取配件的位置
%% @spec get_pos(HeroID::int(), AdjunctID::int()) -> Pos::int() """)

get_next_adjunct_id_list = []
get_next_adjunct_id_list.append("""
%% @doc 下一个配件ID
%% @spec get_next_adjunct_id(HeroID::int(), AdjunctID::int()) -> AdjunctID::int() """)

get_pre_adjunct_id_list = []
get_pre_adjunct_id_list.append("""
%% @doc 前一个配件ID
%% @spec get_pre_adjunct_id(HeroID::int(), AdjunctID::int()) -> AdjunctID::int() """)

up_cost_list = []
up_cost_list.append("""
%% @doc 进阶消耗
%% @spec up_cost(HeroID::int(), AdjunctID::int()) -> list() """)

is_max_adjunct_id_list = []
is_max_adjunct_id_list.append("""
%% @doc 是否是最大品质配件
%% @spec is_max_adjunct_id(HeroID::int(), AdjunctID::int()) -> true | false """)

get_base_attr_list = []
get_base_attr_list.append("""
%% @doc 配件基础属性
%% @spec get_base_attr(HeroID::int(), AdjunctID::int()) -> list() """)

need_hero_quality_list = []
need_hero_quality_list.append("""
%% @doc 穿戴/升级需要军衔 
%% @spec need_hero_quality(HeroID::int(), AdjunctID::int()) -> HeroQuality::int() """)

@load_sheel(work_book, ur"配件ID和属性")
def get_base(content):
    adjunct_id = int(content[BaseField.adjunctID])
    pos = int(content[BaseField.pos])
    quality = int(get_value(content[BaseField.quality], 0))
    hero_id = int(content[BaseField.hero_id])
    attr_list = get_str(content[BaseField.attr], '')
    add_list = get_str(content[BaseField.add_list], '')
    next_id = int(get_value(content[BaseField.next_id], 0))
    item = get_str(content[BaseField.up_item], '')
    coin = int(get_value(content[BaseField.up_coin], 0))

    full_add_list.append("full_add_list(HeroID, AdjunctID) when HeroID =:= %d, AdjunctID =:= %d -> [%s];"%(hero_id, adjunct_id, add_list))

    is_adjunct_fit_hero_list.append("is_adjunct_fit_hero(AdjunctID, HeroID) when AdjunctID =:= %d, HeroID =:= %d -> true;"%(adjunct_id, hero_id))

    get_pos_list.append("get_pos(HeroID, AdjunctID) when HeroID =:= %d, AdjunctID =:= %d -> %d;"%(hero_id, adjunct_id, pos))

    get_next_adjunct_id_list.append("get_next_adjunct_id(HeroID, AdjunctID) when HeroID =:= %d, AdjunctID =:= %d -> %d;"%(hero_id, adjunct_id, next_id))

    if next_id != 0:
        get_pre_adjunct_id_list.append("get_pre_adjunct_id(HeroID, AdjunctID) when HeroID =:= %d, AdjunctID =:= %d -> %d;"%(hero_id, next_id, adjunct_id))

    up_cost_list.append("up_cost(HeroID, AdjunctID) when HeroID =:= %d, AdjunctID =:= %d -> [{del_items, [%s]}, {del_coin, %d}];"%(hero_id, adjunct_id, item, coin))

    if next_id == 0:
        is_max_adjunct_id_list.append("is_max_adjunct_id(HeroID, AdjunctID) when HeroID =:= %d, AdjunctID =:= %d -> true;"%(hero_id, adjunct_id))

    get_base_attr_list.append("get_base_attr(HeroID, AdjunctID) when HeroID =:= %d, AdjunctID =:= %d -> [%s];"%(hero_id, adjunct_id, attr_list))

    need_hero_quality_list.append("need_hero_quality(HeroID, AdjunctID) when HeroID =:= %d, AdjunctID =:= %d -> %d;"%(hero_id, adjunct_id, quality))

    return []

get_base()

full_add_list.append("full_add_list(_, _) -> [].")
is_adjunct_fit_hero_list.append("is_adjunct_fit_hero(_, _) -> false.")
get_pos_list.append("get_pos(_, _) -> 0.")
up_cost_list.append("up_cost(_, _) -> [].")
is_max_adjunct_id_list.append("is_max_adjunct_id(_, _) -> false.")
get_next_adjunct_id_list.append("get_next_adjunct_id(_, _) -> 0.")
get_pre_adjunct_id_list.append("get_pre_adjunct_id(_, _) -> 0.")
get_base_attr_list.append("get_base_attr(_, _) -> [].")
need_hero_quality_list.append("need_hero_quality(_, _) -> 0.")

data_adjunct.extend(full_add_list)
data_adjunct.extend(is_adjunct_fit_hero_list)
data_adjunct.extend(get_pos_list)
data_adjunct.extend(up_cost_list)
data_adjunct.extend(is_max_adjunct_id_list)
data_adjunct.extend(get_next_adjunct_id_list)
data_adjunct.extend(get_pre_adjunct_id_list)
data_adjunct.extend(get_base_attr_list)
data_adjunct.extend(need_hero_quality_list)

get_percent_attr_list = []
get_percent_attr_list.append("""
%% @doc 镶嵌加成百分比
%% @spec get_percent_attr(AddID::int()) -> float() """)

@load_sheel(work_book, ur"增强物品")
def get_add_percent(content):
    add_id = int(content[PercentField.add_id])
    percent = int(content[PercentField.add_percent])

    get_percent_attr_list.append("get_percent_attr(AddID) when AddID =:= %d -> %f;"%(add_id, percent/100.0))

    return []

get_add_percent()

get_percent_attr_list.append("get_percent_attr(_) -> 0.")

data_adjunct.extend(get_percent_attr_list)

gen_erl(new_adjunct_erl, data_adjunct)
