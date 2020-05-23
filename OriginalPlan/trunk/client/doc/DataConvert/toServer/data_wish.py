#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
许愿配置
@author: ZhaoMing
@deprecated: 2015年01月21日
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"wish")

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
    lev, coin, iron, crystal, uranium, vigour
"""

CostIndex = """
    nth, gold
"""

MulIndex = """
    mul, weight
"""

BaseField    = Field('BaseField'    , BaseIndex)
CostField    = Field('CostField'    , CostIndex)
MulField     = Field('MulField'     , MulIndex)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

wish_erl = "data_wish"
data_wish = module_header(ur"配件配置", wish_erl, "zm", "adjunct.xlsx", "data_wish.py")

data_wish.append("""
-export([
         gain_list/2,
         loss_list/1,
         mul/0
        ]).
"""
)

gain_list = []
gain_list.append("""
%% @doc 获得配置
%% @spec gain_list(Code, RoleLev) -> list() """)

@load_sheel(work_book, ur"基础配置")
def get_base(content):
    lev = int(content[BaseField.lev])
    coin = int(content[BaseField.coin])
    iron = int(content[BaseField.iron])
    crystal = int(content[BaseField.crystal])
    uranium = int(content[BaseField.uranium])
    vigour = int(content[BaseField.vigour])

    gain_list.append("gain_list(Code, RoleLev) when Code =:= 1, RoleLev =:= %d -> [{add_coin, %d}];"%(lev, coin))
    gain_list.append("gain_list(Code, RoleLev) when Code =:= 2, RoleLev =:= %d -> [{add_iron, %d}];"%(lev, iron))
    gain_list.append("gain_list(Code, RoleLev) when Code =:= 3, RoleLev =:= %d -> [{add_crystal, %d}];"%(lev, crystal))
    gain_list.append("gain_list(Code, RoleLev) when Code =:= 4, RoleLev =:= %d -> [{add_uranium, %d}];"%(lev, uranium))
    gain_list.append("gain_list(Code, RoleLev) when Code =:= 5, RoleLev =:= %d -> [{add_vigour, %d}];"%(lev, vigour))

    return []

get_base()

gain_list.append("gain_list(_, _) -> [].")

data_wish.extend(gain_list)

loss_list = []
loss_list.append("""
%% @doc 消耗
%% @spec loss_list(Nth::int()) -> list() """)

max_nth = 0

@load_sheel(work_book, ur"次数与价格")
def get_cost(content):
    nth = int(content[CostField.nth])
    gold = int(content[CostField.gold])

    global max_nth
    if max_nth < nth:
        max_nth = nth

    loss_list.append("loss_list(Nth) when Nth =:= %d -> [{del_gold, %d}];"%(nth, gold))
    return []

get_cost()

loss_list.append("loss_list(_) -> loss_list(%d)."%(max_nth))

data_wish.extend(loss_list)


mul_list = []
@load_sheel(work_book, ur"倍率")
def get_mul(content):
    mul = int(content[MulField.mul])
    weight = int(content[MulField.weight])
    mul_list.append("{%d, 1, %d}"%(mul, weight))
    return []

get_mul()

data_wish.append("""
%% @doc 倍率
%% @spec mul() -> int()
mul() ->
    [{Mul, _, _}] = util:list_rands_by_rate([%s], 1),
    Mul. """%(",".join(mul_list)))

gen_erl(wish_erl, data_wish)
