#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
好友邀请配置
@author: csh
@deprecated: 2015-03-13
'''
import os
# import random
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

import time

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"friend_invite")

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
# 邀请数量奖励
BaseColumn1 = """
    id
    ,count
    ,reward
"""

# 邀请等级奖励
BaseColumn2 = """
    id
    ,count
    ,level
    ,reward
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

friend_invite_erl = "data_friend_invite"
data_friend_invite = module_header(ur"好友邀请配置", friend_invite_erl, "csh", "friend_invite.xlsx", "data_friend_invite.py")
data_friend_invite.append("""
-export([
        get_invite_count_reward/1
        ,get_invite_count/1
        ,get_id_count_list/0
        ,get_next_count_task_id/1
        ,get_count_first_task_id/0
        ,get_invite_count_lev_reward/1
        ,get_invite_count_lev/1
        ,get_id_count_lev_list/0
        ,get_next_lev_count_task_id/1
        ,get_lev_cont_first_task_id/0
        ]).
""")

# 根据邀请任务ID获取邀请数和奖励
invite_reward_list = []
invite_reward_list.append("\n\n%% 根据邀请任务ID获取奖励")
invite_reward_list.append("%%@spec get_invite_count_reward(id :: int()) ->  reward :: int()")
# 通过邀请ID获取要求的邀请人数
invite_count_list = []
invite_count_list.append("\n\n%% 通过邀请ID获取要求的邀请人数")
invite_count_list.append("%%@spec get_invite_count(id :: int() ->  count :: int())")
@load_sheel(work_book, ur"邀请数量奖励")
def get_invite_count_reward(content):
    id = int(get_value(content[BaseField1.id], 0))
    count = int(get_value(content[BaseField1.count], 0))
    reward = int(get_value(content[BaseField1.reward], 0))
    invite_reward_list.append("""get_invite_count_reward({0}) -> {1};""".format(id, reward))
    invite_count_list.append("""get_invite_count({0}) -> {1};""".format(id, count))
    return []
get_invite_count_reward()
invite_reward_list.append("get_invite_count_reward(_) -> false.")
invite_count_list.append("get_invite_count(_) -> false.")
data_friend_invite.extend(invite_reward_list)
data_friend_invite.extend(invite_count_list)


# 获取邀请数量任务ID和数量列表
invite_ID_count_list = []
invite_ID_count_list.append("\n\n%% 获取邀请数量任务ID和数量列表")
invite_ID_count_list.append("%% @spec get_id_count_list() -> [{id :: int(), count :: int()}]")
id_count_list = []
@load_sheel(work_book, ur"邀请数量奖励")
def get_id_count_list(content):
    id = int(get_value(content[BaseField1.id], 0))
    count = int(get_value(content[BaseField1.count], 0))
    id_count_list.append("""{{{0}, {1}}}""".format(id, count))
    return []
get_id_count_list()
invite_ID_count_list.append("""get_id_count_list() -> {0}.""".format('[' + ', '.join(id_count_list) + ']'))
data_friend_invite.extend(invite_ID_count_list)

# 将 邀请数量奖励 任务ID 写入 list 
count_task_id_list = []
@load_sheel(work_book, ur"邀请数量奖励")
def load_to_count_list(content):
    temp_list = []
    task_id = int(get_value(content[BaseField1.id], 0))
    temp_list.append(task_id)
    count_task_id_list.append(temp_list)
    return []
load_to_count_list()

# 根据上一个ID获取下一个ID(邀请数量任务)
next_count_task_id = []
next_count_task_id.append("\n\n%% 根据上一个ID获取下一个ID(邀请数量任务)")
next_count_task_id.append("%% @spec get_next_count_task_id(task_id ::int()) -> next_task_id :: int()")
def get_next_count_task_id():
    row = 0
    while row < len(count_task_id_list) :
        if (row + 1) == len(count_task_id_list) :
            next_count_task_id.append("""get_next_count_task_id({0}) -> {1};""".format(count_task_id_list[row][0], count_task_id_list[row][0]))
        else :
            next_count_task_id.append("""get_next_count_task_id({0}) -> {1};""".format(count_task_id_list[row][0], count_task_id_list[row + 1][0]))
        row = row + 1
    return []
get_next_count_task_id()
next_count_task_id.append("get_next_count_task_id(_) -> false.")
data_friend_invite.extend(next_count_task_id)

# 获取第一个任务ID(邀请数量任务)
first_count_task_id_list = []
first_count_task_id_list.append("\n\n%% 获取第一个任务ID(邀请数量任务)")
first_count_task_id_list.append("%% @spec get_count_first_task_id() -> task_id :: int()")
def get_count_first_task_id():
    if len(count_task_id_list) > 0 :
        first_count_task_id_list.append("""get_count_first_task_id() -> {0}.""".format(count_task_id_list[0][0]))
    return []
get_count_first_task_id()
data_friend_invite.extend(first_count_task_id_list)


# 根据邀请任务ID获取奖励
invite_count_lev_reward_list = []
invite_count_lev_reward_list.append("\n\n%% 根据邀请任务ID获取奖励")
invite_count_lev_reward_list.append("%% @spec get_invite_count_lev_reward(id :: int()) -> reward :: int()")
# 根据任务ID获取邀请数和等级
invite_count_lev_list = []
invite_count_lev_list.append("\n\n%% 根据任务ID获取邀请数和等级")
invite_count_lev_list.append("%% @spec get_invite_count_lev(id :: int()) -> {count :: int(), lev :: int()}")
@load_sheel(work_book, ur"邀请等级奖励")
def get_invite_count_lev_reward(content):
    id = int(get_value(content[BaseField2.id], 0))
    count = int(get_value(content[BaseField2.count], 0))
    level = int(get_value(content[BaseField2.level], 0))
    reward = int(get_value(content[BaseField2.reward], 0))
    # invite_count_lev_reward_list.append("""get_invite_count_lev_reward({0}) -> {{{1}, {2}, {3}}};""".format(id, count, level, reward))
    invite_count_lev_reward_list.append("""get_invite_count_lev_reward({0}) -> {1};""".format(id, reward))
    invite_count_lev_list.append("""get_invite_count_lev({0}) -> {{{1}, {2}}};""".format(id, count, level))
    return []
get_invite_count_lev_reward()
invite_count_lev_reward_list.append("get_invite_count_lev_reward(_) -> false.")
invite_count_lev_list.append("get_invite_count_lev(_) -> false.")
data_friend_invite.extend(invite_count_lev_reward_list)
data_friend_invite.extend(invite_count_lev_list)

# 获取邀请数量等级任务ID列表
invite_ID_count_lev_list = []
invite_ID_count_lev_list.append("\n\n%% 获取邀请数量等级任务ID列表")
invite_ID_count_lev_list.append("%% @spec get_id_count_lev_list() -> [{id :: int(), count :: int(), lev :: int()}]")
id_count_lev_list = []
@load_sheel(work_book, ur"邀请等级奖励")
def get_id_count_lev_list(content):
    id = int(get_value(content[BaseField2.id], 0))
    count = int(get_value(content[BaseField2.count], 0))
    level = int(get_value(content[BaseField2.level], 0))
    id_count_lev_list.append("""{{{0}, {1}, {2}}}""".format(id, count, level))
    return []
get_id_count_lev_list()
invite_ID_count_lev_list.append("""get_id_count_lev_list() -> {0}.""".format('[' + ', '.join(id_count_lev_list) + ']'))
data_friend_invite.extend(invite_ID_count_lev_list)

# 将 邀请数量奖励 任务ID 写入 list 
lev_count_task_id_list = []
@load_sheel(work_book, ur"邀请等级奖励")
def load_to_lev_count_list(content):
    temp_list = []
    task_id = int(get_value(content[BaseField2.id], 0))
    temp_list.append(task_id)
    lev_count_task_id_list.append(temp_list)
    return []
load_to_lev_count_list()

# 根据上一个ID获取下一个ID(邀请等级数量任务)
next_lev_count_task_id = []
next_lev_count_task_id.append("\n\n%% 根据上一个ID获取下一个ID(邀请数量任务)")
next_lev_count_task_id.append("%% @spec get_next_lev_count_task_id(task_id ::int()) -> next_task_id :: int()")
def get_next_lev_count_task_id():
    row = 0
    while row < len(lev_count_task_id_list) :
        if (row + 1) == len(lev_count_task_id_list) :
            next_lev_count_task_id.append("""get_next_lev_count_task_id({0}) -> {1};""".format(lev_count_task_id_list[row][0], lev_count_task_id_list[row][0]))
        else :
            next_lev_count_task_id.append("""get_next_lev_count_task_id({0}) -> {1};""".format(lev_count_task_id_list[row][0], lev_count_task_id_list[row + 1][0]))
        row = row + 1
    return []
get_next_lev_count_task_id()
next_lev_count_task_id.append("get_next_lev_count_task_id(_) -> false.")
data_friend_invite.extend(next_lev_count_task_id)

 # 获取第一个任务ID(邀请等级数量任务)
first_lev_count_task_id_list = []
first_lev_count_task_id_list.append("\n\n%% 获取第一个任务ID(邀请等级数量任务)")
first_lev_count_task_id_list.append("%% @spec get_lev_cont_first_task_id() -> task_id :: int)()")
def get_lev_cont_first_task_id():
    if len(lev_count_task_id_list) > 0 :
        first_lev_count_task_id_list.append("""get_lev_cont_first_task_id() -> {0}.""".format(lev_count_task_id_list[0][0]))
    return []
get_lev_cont_first_task_id()
data_friend_invite.extend(first_lev_count_task_id_list)



gen_erl(friend_invite_erl, data_friend_invite)

