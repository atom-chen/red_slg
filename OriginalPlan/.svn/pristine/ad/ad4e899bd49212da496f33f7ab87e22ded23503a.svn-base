#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
竞技场配置表
@author: ZhaoMing
@deprecated: 2013-11-20
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"arena")

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

arena_erl = "data_arena"
data_arena = module_header(ur"竞技场配置", arena_erl, "zm", "arena.xlsx", "data_arena.py")
data_arena.append(""" 
-export([
         cost/1
         ,rank_reward/1
         ,node_reward/1
         ,all_nodes/0
         ,atk_reward/1
         ,all_new_rank/0
         ,max_rank_reward_obtain_gold/1
        ]).
""")

cost_gold = []
cost_gold.append("%% @spec cost(Nth :: int()) -> CostGold :: int()")
cost_gold.append("%% @doc 重置挑战元宝花费")
maxNth = 0
@load_sheel(work_book, ur"重置挑战次数元宝花费")
def get_cost(content):
    global maxNth
    nth = int(content[0])
    gold = int(content[1])
    if nth > maxNth :
        maxNth = nth
    cost_gold.append("cost({0}) -> [{{del_gold, {1}}}];".format(nth, gold))
    return []

get_cost()
cost_gold.append("cost(_) -> cost(%d)."%(maxNth))
data_arena.extend(cost_gold)

rank_reward = []
rank_reward.append("%% @spec rank_reward(Rank :: int()) -> list()")
rank_reward.append("%% @doc 排名奖励")

@load_sheel(work_book, ur"排名奖励")
def get_rank_reward(content):
    index     = int(content[0])
    sID       = int(content[1])
    eID       = int(content[2])
    gold      = int(content[3])
    coin      = int(content[4])
    arenaCoin = int(content[5])
    item      = "[%s]"%(get_str(content[6], ''))
    shengwang  = int(content[7]) ## 声望
    rank_reward.append("""rank_reward(Rank) when Rank >= {0} andalso Rank =< {1} ->
    [{{add_gold, {2}}}, {{add_coin, {3}}}, {{add_arena_coin, {4}}}, {{add_items, {5}}}, {{add_shengwang, {6}}}];""".format(sID, eID, gold, coin, arenaCoin, item, shengwang))

    return []

get_rank_reward()
rank_reward.append("rank_reward(_) -> [].")
data_arena.extend(rank_reward)

node_reward = []
all_nodes = []
node_reward.append("%% @spec node_reward(Rank :: int()) -> list()")
node_reward.append("%% @doc 节点奖励")
@load_sheel(work_book, ur"节点奖励")
def get_node_reward(content):
    id   = int(content[0])
    rank = int(content[1])
    gold = int(content[2])
    all_nodes.append("{%d, %d}"%(id, rank))
    node_reward.append("node_reward({0}) -> [{{add_gold, {1}}}];".format(id, gold))
    return []

get_node_reward()
node_reward.append("node_reward(_) -> [].")
data_arena.extend(node_reward)
data_arena.append("%% @spec all_nodes() -> list()")
data_arena.append("%% @doc 所有的节点信息")
data_arena.append("all_nodes() -> [%s]."%(",".join(all_nodes)))

atk_reward_list = []
atk_reward_list.append("""
%% @doc 竞技场挑战奖励
%% @spec atk_reward(IsWin::boolean()) -> list() """)

@load_sheel(work_book, ur"竞技场挑战奖励")
def get_atk_reward(content):
    code = int(content[0])
    coin = int(content[1])
    if code == 1:
        atk_reward_list.append("atk_reward(IsWin) when IsWin =:= true -> [{add_arena_coin, %d}];"%(coin))
    if code == 2:
        atk_reward_list.append("atk_reward(IsWin) when IsWin =:= false -> [{add_arena_coin, %d}];"%(coin))
    return []

get_atk_reward()
atk_reward_list.append("atk_reward(_) -> [].")
data_arena.extend(atk_reward_list)

max_rank_reward_list = []
max_rank_reward_list.append("""
%% @doc 最大排名奖励
%% @spec max_rank_reward(Rank::int()) -> list() """)

new_reward = []
@load_sheel(work_book, ur"历史最高排名奖励")
def get_max_rank_reward(content):
    sID       = int(content[1])
    eID       = int(content[2])
    gold      = int(content[3])
    new_reward.append("{%d, %d}"%(sID, eID))
    max_rank_reward_list.append("max_rank_reward_obtain_gold(Rank) when Rank >= %d, Rank =< %d -> %d;"%(sID, eID, gold))

    return []

get_max_rank_reward()

max_rank_reward_list.append("max_rank_reward_obtain_gold(_) -> 0.")
data_arena.extend(max_rank_reward_list)
data_arena.append("%% @spec all_new_rank() -> list()")
data_arena.append("%% @doc 所有的新排名信息")
data_arena.append("all_new_rank() -> [%s]."%(",".join(new_reward)))


gen_erl(arena_erl, data_arena)
