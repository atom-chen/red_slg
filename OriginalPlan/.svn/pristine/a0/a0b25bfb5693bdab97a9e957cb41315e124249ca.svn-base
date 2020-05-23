#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
战队技能配置
@author: csh
@deprecated: 2015-01-24
'''
import os
# import random
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value, get_str

import time

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"role_skill")

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
    id
    ,name
    ,min_lev
    ,lvUpdDesc
    ,skillLvUpDesc
    ,skillLvUpNumber
    ,order
"""

## 战队技能等级升级
BaseColumn2 = """
    skill_id
    ,lev
    ,skill_point_amount
"""

class FieldClassBase1:
    def __init__(self):
        enum(FieldClassBase1, BaseColumn1)

## 战队技能等级升级
class FieldClassBase2:
    def __init__(self):
        enum(FieldClassBase2, BaseColumn2)


# 生成域枚举           
BaseField1 = FieldClassBase1()

BaseField2 = FieldClassBase2()


# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

role_skill_erl = "data_role_skill"
data_role_skill = module_header(ur"战队技能配置", role_skill_erl, "csh", "role_skill.xlsx", "data_role_skill.py")
data_role_skill.append("""
-export([
        get_min_lev/1
        ,get_skill_point_amount/2
        ,get_role_skill_list/0
        ,reset_cd_cost_gold/1
        ,up_skill_cd/0
        ,max_cd_time/0
        ]).
""")

# 获取战队技能最小等级
role_skill_min_lev = []
role_skill_min_lev.append("\n\n%% 获取战队技能最小等级")
role_skill_min_lev.append("%%@spec get_min_lev(id :: int()) -> min_lev :: int() | false")
@load_sheel(work_book, ur"战队技能基础配置")
def get_min_lev(content) :
    id = int(get_value(content[BaseField1.id], 0))
    min_lev = int(get_value(content[BaseField1.min_lev], 0))
    role_skill_min_lev.append("""get_min_lev({0}) -> {1};""".format(id, min_lev))
    return []
get_min_lev()
role_skill_min_lev.append("get_min_lev(_) -> false.")
data_role_skill.extend(role_skill_min_lev)

role_skill_id_list = []
@load_sheel(work_book, ur"战队技能基础配置")
def load_excel_to_list(content):
    id = int(get_value(content[BaseField1.id], 0))
    if (id not in role_skill_id_list) :
        role_skill_id_list.append(id)
    return []
load_excel_to_list()


# 获取战队技能ID列表
role_skill_list = []
role_skill_list.append("\n\n%% 获取战队技能ID列表")
role_skill_list.append("%%@spec get_role_skill_list() -> role_skill_list :: list()")
def get_role_skill_list():
    role_skill_list.append("""get_role_skill_list() -> {0}.""".format(role_skill_id_list))
    return []
get_role_skill_list()
data_role_skill.extend(role_skill_list)
    

# 根据技能ID和等级获取锁需技能点数
skill_point_amount_list = []
skill_point_amount_list.append("\n\n%% 根据技能ID和等级获取锁需技能点数")
skill_point_amount_list.append("%%@spec get_skill_point_amount(skill_id :: int(), lev :: int()) -> skill_point_amount :: int()")
@load_sheel(work_book, ur"战队技能等级升级")
def get_skill_point_amount(content) :
    skill_id = int(get_value(content[BaseField2.skill_id], 0))
    lev = int(get_value(content[BaseField2.lev], 0))
    skill_point_amount = int(get_value(content[BaseField2.skill_point_amount], 0))
    skill_point_amount_list.append("""get_skill_point_amount({0}, {1}) -> {2};""".format(skill_id, lev, skill_point_amount))
    return []
get_skill_point_amount()
skill_point_amount_list.append("get_skill_point_amount(_, _) -> false.")
data_role_skill.extend(skill_point_amount_list)


cd = []
cd.append("%% 重置CD时间元宝消耗")
@load_sheel(work_book, ur"cd清零消耗")
def get_cd(content):
    id       = int(content[0])
    cd_begin = int(content[1])
    cd_end   = int(content[2])
    gold     = int(content[3])
    cd.append("reset_cd_cost_gold(Time) when Time >= %d andalso Time =< %d -> %d;"%(cd_begin, cd_end, gold))
    return []
get_cd()
cd.append("reset_cd_cost_gold(_) -> 99999999.")

data_role_skill.extend(cd)

arg_list = []
@load_sheel(work_book, ur"参数配置")
def get_arg(content):
    arg = str(content[0])
    v = get_str(content[1], "H")
    note = str(get_value(content[2], ""))
    arg_list.append("%s() -> %s. %%%% %s"%(arg, v, note))
    return []
get_arg()

data_role_skill.extend(arg_list)


gen_erl(role_skill_erl, data_role_skill)

