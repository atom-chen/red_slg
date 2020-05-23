#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
副本配置
@author: benqi
@deprecated: 2015-10-12
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"defender")

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

# 必须和excel里面的列保持一致的顺序
BaseColumn = """
    wave
    ,exp_amount
    ,value
    ,item
    ,item_rate
    ,coin
"""

class FieldClassBase:
    def __init__(self):
        enum(FieldClassBase, BaseColumn)

#生成域枚举           
BaseField = FieldClassBase()

data_defender_erl = "data_defender"
data_defender = module_header(ur"抵抗侵略配置", data_defender_erl, "benqi", "defender.xlsx", "data_defender.py")
data_defender.append("""
-export([
    get_cd/0,
    get_defender_list/0,
    get_rank_reward/1,
    get_cd_cost/1,
    get_wave_base/1,
    get_max_wave/0]).

-include("aggress.hrl").
    """)

defender_cd_time = []
defender_cd_time.append("%% @spec get_cd() -> int()")
@load_sheel(work_book, ur"抵抗侵略基础配置表")
def defender_base(content):
    cd_time = int(content[1])
    defender_cd_time.append("get_cd() -> %d."%(cd_time))
    return []

defender_base()
data_defender.extend(defender_cd_time)

defender_id_list = []
data_defender.append("%% @spec get(ID :: int()) -> [DungeonID :: int()]")
@load_sheel(work_book, ur"任务主题配置表")
def defender_task(content):
    dungeon_id = int(content[0])
    defender_id_list.append("%d"%(dungeon_id))
    return []

defender_task()
data_defender.append("get_defender_list() -> [%s]."%(",".join(defender_id_list)))

rank_reward = []
rank_reward.append("%@spec get_rank_reward(Rank :: int()) -> [{ItemID :: int(), ItemNum :: int()}]%")
max_rank = 1
@load_sheel(work_book, ur"排行榜奖励配置")
def do_rank_reward(content):
    rank = int(content[1])
    global max_rank 
    item_list = get_str(content[2], '')
    if item_list <> '':
        rank_reward.append("get_rank_reward(Rank) when Rank =< %d -> [%s];"%(rank, item_list))
        max_rank = rank
    return []

do_rank_reward()
rank_reward.append("get_rank_reward(_) -> get_rank_reward(%d)."%(max_rank))
data_defender.extend(rank_reward)

cd_cost = []
max_cost = 0
cd_cost.append("%%@spec get_cd_cost(Times :: int()) -> [{del_gold, Gold::int()}]")
@load_sheel(work_book, ur"清楚冷却CD消耗")
def do_cd_cost(content):
    times = int(content[0])
    gold = int(content[1])
    cd_cost.append("get_cd_cost(%d) -> [{del_gold, %d}];"%(times, gold))
    
    global max_cost
    max_cost = gold
    return []

do_cd_cost()
cd_cost.append("get_cd_cost(_) -> [{del_gold, %d}]."%(max_cost))
data_defender.extend(cd_cost)

wave_base = []
max_wave = 0
wave_base.append("%%@spec get_wave_base(Times::int()) -> #wave_base{}")
@load_sheel(work_book, ur"波次奖励配置")
def do_wave_base(content):
    wave_id = int(content[BaseField.wave])
    exp = int(get_value(content[BaseField.exp_amount], 0))
    score = int(get_value(content[BaseField.value], 0))
    item_list = get_str(content[BaseField.item], '')
    item_rate = get_str(content[BaseField.item_rate], '')
    coin = int(get_value(content[BaseField.coin], 0))
    wave_base.append("""get_wave_base(%d)->
    #wave_base{
            id = %d,
            score_factor = %d,
            exp = %d,
            coin = %d,
            item_id_list = [%s],
            item_rate = [%s]
            };"""%(wave_id, wave_id, score, exp, coin, item_list, item_rate))
    global max_wave
    max_wave = wave_id
    return []

do_wave_base()
wave_base.append("get_wave_base(_) -> false.")
data_defender.append("%%@spec get_max_wave() -> Num :: int()")
data_defender.append("get_max_wave() -> %d."%(max_wave))
data_defender.extend(wave_base)


gen_erl(data_defender_erl, data_defender)
