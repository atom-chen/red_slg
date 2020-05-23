#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
好友配置
@author: csh
@deprecated: 2015-01-20
'''
import os
# import random
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

import time

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"friend")

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
# 好友基础配置表
BaseColumn1 = """
    min_lev
    ,max_amount
    ,give_times
    ,receive_max_times
    ,power_point_amount
    ,count_liveness_long
    ,min_role_lev
"""

# 接受祝福获得体力配置
BaseColumn2 = """
    index
    ,min_liveness
    ,max_liveness
    ,get_energy_amount
"""

 
class FieldClassBase1:
    def __init__(self):
        enum(FieldClassBase1, BaseColumn1)
        
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

friend_erl = "data_friend"
data_friend = module_header(ur"好友配置", friend_erl, "csh", "friend.xlsx", "data_friend.py")
data_friend.append("""
-export([
        get_min_lev/0,
        get_max_amount/0,
        get_give_times/0,
        get_receive_max_times/0,
        get_power_point_amount/0,
        get_count_liveness_long/0,
        get_min_role_lev/0,
        get_energy_amount_by_liveness/1
        ]).
""")

# 获取最小等级
friend_min_lev = []
friend_min_lev.append("\n\n%% 获取最小等级")
friend_min_lev.append("%%@spec get_min_lev() -> min_lev :: int()")
@load_sheel(work_book, ur"好友基础配置表")
def get_min_lev(content):
    min_lev = int(get_value(content[BaseField1.min_lev], 0))
    friend_min_lev.append("""get_min_lev() -> {0}.""".format(min_lev))
    return []
get_min_lev()
data_friend.extend(friend_min_lev)


# 获取好友数量上限
friend_max_amount = []
friend_max_amount.append("\n\n%% 获取好友数量上限")
friend_max_amount.append("%%@spec get_max_amount() -> max_amount :; int()")
@load_sheel(work_book, ur"好友基础配置表")
def get_max_amount(content):
    max_amount = int(get_value(content[BaseField1.max_amount], 0))
    friend_max_amount.append("""get_max_amount() -> {0}.""".format(max_amount))
    return []
get_max_amount()
data_friend.extend(friend_max_amount)


# 获取一天内向同一个玩家赠送体力次数
friend_give_times = []
friend_give_times.append("\n\n%% 获取一天内向同一个玩家赠送体力次数")
friend_give_times.append("%%@spec get_give_times() -> times :: int()")
@load_sheel(work_book, ur"好友基础配置表")
def get_give_times(content):
    give_times = int(get_value(content[BaseField1.give_times], 0))
    friend_give_times.append("""get_give_times() -> {0}.""".format(give_times))
    return []
get_give_times()
data_friend.extend(friend_give_times)


# 获取玩家每天最多接受体力次数
friend_receive_max_times = []
friend_receive_max_times.append("\n\n%% 获取玩家每天最多接受体力次数")
friend_receive_max_times.append("%%@spec get_receive_max_times() -> times :: int()")
@load_sheel(work_book, ur"好友基础配置表")
def get_receive_max_times(content):
    receive_max_times = int(get_value(content[BaseField1.receive_max_times], 0))
    friend_receive_max_times.append("""get_receive_max_times() -> {0}.""".format(receive_max_times))
    return []
get_receive_max_times()
data_friend.extend(friend_receive_max_times)


# 获取赠送一次体力对应体力点数
friend_power_point_amount = []
friend_power_point_amount.append("\n\n%% 获取赠送一次体力对应体力点数")
friend_power_point_amount.append("%%@spec get_power_point_amount() -> power_point_amount :: int()")
@load_sheel(work_book, ur"好友基础配置表")
def get_power_point_amount(content):
    power_point_amount = int(get_value(content[BaseField1.power_point_amount], 0))
    friend_power_point_amount.append("""get_power_point_amount() -> {0}.""".format(power_point_amount))
    return []
get_power_point_amount()
data_friend.extend(friend_power_point_amount)


# 获取活跃度统计时长范围
friend_count_liveness_long = []
friend_count_liveness_long.append("\n\n%% 获取活跃度统计时长范围")
friend_count_liveness_long.append("%%@spec get_count_liveness_long() -> count_liveness_long :: int()")
@load_sheel(work_book, ur"好友基础配置表")
def get_count_liveness_long(content):
    count_liveness_long = int(get_value(content[BaseField1.count_liveness_long], 0))
    friend_count_liveness_long.append("""get_count_liveness_long() -> {0}.""".format(count_liveness_long))
    return []
get_count_liveness_long()
data_friend.extend(friend_count_liveness_long)


# 获取活跃度统计时长范围
min_role_lev = []
min_role_lev.append("\n\n%% 获取申请好友要求最低等级")
min_role_lev.append("%%@spec get_min_role_lev() -> Lev :: int()")
@load_sheel(work_book, ur"好友基础配置表")
def get_min_role_lev(content):
    lev = int(get_value(content[BaseField1.min_role_lev], 0))
    min_role_lev.append("""get_min_role_lev() -> {0}.""".format(lev))
    return []
get_min_role_lev()
data_friend.extend(min_role_lev)


# 根据三日活跃度获取获得体力值
get_energy_amount_list = []
get_energy_amount_list.append("\n\n%% 根据三日活跃度获取获得体力值")
get_energy_amount_list.append("%%@spec get_energy_amount_by_liveness(liveness :: int()) -> energy_amount :: int()")
@load_sheel(work_book, ur"接受祝福获得体力配置")
def get_energy_amount_by_liveness(content):
    min_liveness = int(get_value(content[BaseField2.min_liveness], 0))
    max_liveness = int(get_value(content[BaseField2.max_liveness], 0))
    get_energy_amount = int(get_value(content[BaseField2.get_energy_amount], 0))
    get_energy_amount_list.append("""get_energy_amount_by_liveness(Liveness) when Liveness >= {0} andalso Liveness =< {1} -> {2};"""
                                            .format(min_liveness, max_liveness, get_energy_amount))
    return []
get_energy_amount_by_liveness()
get_energy_amount_list.append("get_energy_amount_by_liveness(_) -> 0.")
data_friend.extend(get_energy_amount_list)




gen_erl(friend_erl, data_friend)

