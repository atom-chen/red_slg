#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
掉落配置
@author: ZhaoMing
@deprecated: 2013-11-20
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"drop")

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
    drop_id
    ,drop_conf
    ,act_item
"""

SpecialColumn = """
    drop_id
    ,item_id
    ,period
"""

HeroColumn = """
    drop_id
    ,max_drop
    ,drop_conf
"""
 
class FieldClassBase:
    def __init__(self):
        enum(FieldClassBase, BaseColumn)


class FieldClassSpecial:
    def __init__(self):
        enum(FieldClassSpecial, SpecialColumn)

class FieldClassHero:
    def __init__(self):
        enum(FieldClassHero, HeroColumn)

# 生成域枚举           
BaseField = FieldClassBase()
SpecialField = FieldClassSpecial()
HeroField = FieldClassHero()

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

drop_erl = "data_drop"
data_drop = module_header(ur"掉落配置", drop_erl, "zm", "drop.xlsx", "data_drop.py")
data_drop.append("""
-include("drop.hrl").

-export([base_drop/1, special_drop/1, hero_drop/1]).

""")

drop_base = []
drop_base.append("%% @spec base_drop(DropID::int()) -> #drop_base{} | false.")
@load_sheel(work_book, ur"普通掉落")
def get_base_drop(content):
    drop_id = int(content[BaseField.drop_id])
    max_drop = 0
    drop_conf = str(get_value(content[BaseField.drop_conf], ''))
    act_item = str(get_value(content[BaseField.act_item], ''))
    drop_base.append("""base_drop({0}) ->
    #drop_base{{
        id = {0}
        ,max_drop = {1}
        ,weight_conf = [{2}]
        ,act_item = [{3}]
    }}; """.format(drop_id, max_drop, drop_conf, act_item))
    return []

get_base_drop()
drop_base.append("base_drop(_) -> false.")
data_drop.extend(drop_base)

drop_special = []
drop_special.append("%% @spec special_drop(DropID::int()) -> #drop_special{} | false.")
@load_sheel(work_book, ur"特殊掉落")
def get_special_drop(content):
    drop_id = int(content[SpecialField.drop_id])
    item_id = int(content[SpecialField.item_id])
    period = int(content[SpecialField.period])
    drop_special.append("""special_drop({0}) ->
    #drop_special{{
        id = {0}
        ,item_id = {1}
        ,period = {2}
    }}; """.format(drop_id, item_id, period))
    return []

get_special_drop()
drop_special.append("special_drop(_) -> false.")
data_drop.extend(drop_special)


drop_hero = []
drop_hero.append("%% @spec hero_drop(DropID::int()) -> #drop_hero{} | false.")
@load_sheel(work_book, ur"英雄掉落")
def get_hero_drop(content):
    drop_id = int(content[HeroField.drop_id])
    max_drop = int(content[HeroField.max_drop])
    drop_conf = str(get_value(content[HeroField.drop_conf], ''))
    drop_hero.append("""hero_drop({0}) ->
    #drop_hero{{
        id = {0}
        ,max_drop = {1}
        ,weight_conf = [{2}]
    }}; """.format(drop_id, max_drop, drop_conf))
    return []

get_hero_drop()
drop_hero.append("hero_drop(_) -> false.")
data_drop.extend(drop_hero)

gen_erl(drop_erl, data_drop)
