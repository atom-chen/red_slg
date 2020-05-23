#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
战队经验配置
@author: ZhaoMing
@deprecated: 2013-11-20
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"role_lev")

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
    lev
    ,exp
    ,maxEnergy
    ,hero_lev
    ,addEnergy
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

role_lev_erl = "data_role_lev"
data_role_lev = module_header(ur"战队经验配置", role_lev_erl, "zm", "role_lev.xlsx", "data_role_lev.py")
data_role_lev.append("""
-export([
         get/1
         ,max_prestige_exp/1
         ,max_prestige_lev/0
         ,max_energy/1
         ,max_hero_lev/1
         ,add_energy/1
        ]).
""")

lev_base = []
lev_base.append("%% @spec get(Level::int()) -> Exp :: integer() | false.")

max_energy_list = []
max_energy_list.append("""
%% @doc 最大体力
%% @spec max_energy(RoleLev::int()) -> MaxEnergy::int() """)

max_hero_lev_list = []
max_hero_lev_list.append("""
%% @doc 英雄最大等级
%% @spec max_hero_lev(RoleLev::int()) -> MaxHeroLev::int() """)

add_energy_list = []
add_energy_list.append("""
%% @doc 升级加体力
%% @spec add_energy(RoleLev::int()) -> list() """)

@load_sheel(work_book, ur"战队经验配置表")
def get_role_lev(content):
    lev = int(content[BaseField.lev])
    exp = int(get_value(content[BaseField.exp], 0))
    max_energy = int(get_value(content[BaseField.maxEnergy], 0))
    max_hero_lev = int(get_value(content[BaseField.hero_lev], 0))
    add_energy = int(get_value(content[BaseField.addEnergy], 0))
    max_energy_list.append("max_energy(%d) -> %d;"%(lev, max_energy))
    max_hero_lev_list.append("max_hero_lev(%d) -> %d;"%(lev, max_hero_lev))
    add_energy_list.append("add_energy(%d) -> [{add_energy, %d}];"%(lev, add_energy))
    lev_base.append("""get({0}) -> {1};""".format(lev, exp))
    return []

get_role_lev()
lev_base.append("get(_) -> false.")
max_energy_list.append("max_energy(_) -> 0.")
max_hero_lev_list.append("max_hero_lev(_) -> 0.")
add_energy_list.append("add_energy(_) -> [].")
data_role_lev.extend(lev_base)
data_role_lev.extend(max_energy_list)
data_role_lev.extend(max_hero_lev_list)
data_role_lev.extend(add_energy_list)

max_prestige_lev = 0
prestige_exp_list = []
@load_sheel(work_book, ur"声望经验配置表")
def get_prestige_lev(content):
    global max_prestige_lev
    lev = int(content[0])
    exp = int(content[1])
    if lev > max_prestige_lev:
        max_prestige_lev = lev
    prestige_exp_list.append("max_prestige_exp(%d) -> %d;"%(lev, exp))
    return []

get_prestige_lev()
prestige_exp_list.append("max_prestige_exp(_) -> 0.")
data_role_lev.extend(prestige_exp_list)
data_role_lev.append("max_prestige_lev() -> %d."%(max_prestige_lev))



gen_erl(role_lev_erl, data_role_lev)
