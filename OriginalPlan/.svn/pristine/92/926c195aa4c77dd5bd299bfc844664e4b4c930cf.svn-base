#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
世界BOSS配置
@author: csh
@deprecated: 2014-11-20
'''
import os
# import random
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

import time

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"world_boss")

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
# 世界BOSS基础配置表
BaseColumn1 = """
    id
    ,start_time
    ,end_time
    ,max_rank
    ,fight_total_time
    ,baseCoin
    ,first_rate
    ,rate
    ,delete_hp_amount
"""

## boss生成配置表
BaseColumn2 = """
    week_day
    ,boss_id
"""

## 个人排行榜奖励配置
BaseColumn3 = """
    rank
    ,coin_amount
    ,gold_amount
    ,item_list
"""

## 公会奖励配置
BaseColumn4 = """
    evaluate_id
    ,evaluate
    ,min_hurt_amount
    ,max_hurt_amount
    ,coin_amount
    ,gold_amount
    ,item_list
"""

## 极限伤害
BaseColumn5 = """
    role_lv
    ,max_damage
"""

## 购买次数钻石
BaseColumn6 = """
    nth
    ,gold
"""

BaseColumn7 = """
    boss_lev, max_hp
"""

BaseColumn8 = """
    evaluate_top,
    evaluate_low,
    coin_amount,
    gold_amount,
    item_list
"""
 
class FieldClassBase1:
    def __init__(self):
        enum(FieldClassBase1, BaseColumn1)

## boss生成配置表
class FieldClassBase2:
    def __init__(self):
        enum(FieldClassBase2, BaseColumn2)

## 个人排行榜奖励配置
class FieldClassBase3:
    def __init__(self):
        enum(FieldClassBase3, BaseColumn3)
        
## 公会奖励配置
class FieldClassBase4:
    def __init__(self):
        enum(FieldClassBase4, BaseColumn4)

## 公会奖励配置
class FieldClassBase5:
    def __init__(self):
        enum(FieldClassBase5, BaseColumn5)
        
## 购买次数钻石
class FieldClassBase6:
    def __init__(self):
        enum(FieldClassBase6, BaseColumn6)

## boss血量配置
class FieldClassBase7:
    def __init__(self):
        enum(FieldClassBase7, BaseColumn7)

## 世界BOSS公会奖励
class FieldClassBase8:
    def __init__(self):
        enum(FieldClassBase8, BaseColumn8)

        
# 生成域枚举           
BaseField1 = FieldClassBase1()

BaseField2 = FieldClassBase2()

BaseField3 = FieldClassBase3()

BaseField4 = FieldClassBase4()

BaseField5 = FieldClassBase5()

BaseField6 = FieldClassBase6()

BaseField7 = FieldClassBase7()

BaseField8 = FieldClassBase8()

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

boss_erl = "data_boss"
data_boss = module_header(ur"世界BOSS配置", boss_erl, "csh", "world_boss.xlsx", "data_world_boss.py")
data_boss.append("""
-export([
        get_open_time/0,
        get_max_times/0,
        get_boss_id/1,
        get_rank_reward/1,
        get_union_reward_by_hurt/1,
        get_union_rank_reward_by_hurt/1,
        get_evaluate_by_hurt/1,
        get_max_damage/1,
        get_cost_gold_by_times/1,
        get_base_coin/0,
        get_hurt_first_rate/0,
        get_hurt_rate/0,
        get_view_max_rank/0,
        next_boss_lev/1,
        get_buy_max_times/0,
        max_hp/1
        ]).
""")

# 时间格式 12：00 转换成 0：00 到 12：00 的秒数
def time_to_seconds(str_time) :
    list_time = []
    list_time = str_time.split(':')
    return int(list_time[0]) * 3600 + int(list_time[1]) * 60

@load_sheel(work_book, ur"世界boss基础配置表")
def get_base_boss_conf(content):
    start_time = str(get_value(content[BaseField1.start_time], ''))
    end_time = str(get_value(content[BaseField1.end_time], ''))
    rate = str(get_value(content[BaseField1.rate], '0'))
    max_rank = int(content[BaseField1.max_rank])
    base_coin = int(content[BaseField1.baseCoin])
    first_rate = str(get_value(content[BaseField1.first_rate], '0'))

    data_boss.append("""
%% 获取世界BOSS开放时间
%% @spec get_open_time() -> {start_time :: int(), end_time :: int()} | false """)
    data_boss.append("get_open_time() -> {{{0}, {1}}}." .format(time_to_seconds(start_time), time_to_seconds(end_time)))

    data_boss.append("""
%% 获取每人每天最多挑战次数
%% @spec get_max_times() -> times :: int() | false """)
    data_boss.append("get_max_times() -> 5.")

    data_boss.append("""
%% @doc 排名最大范围
%% @spec get_view_max_rank() -> float() """)
    data_boss.append("get_view_max_rank() -> %d."%(max_rank))

    data_boss.append("""
%% @doc 获得基础金币
%% @spec get_base_coin() -> int() 
get_base_coin() -> %d. """%(base_coin))

    data_boss.append("""
%% @doc 第一次打的伤害转换金币系数
%% @spec get_hurt_first_rate() -> float()
get_hurt_first_rate() -> %s.  """%(first_rate))

    data_boss.append("""
%% @doc 打的伤害转换金币系数
%% @spec get_hurt_rate() -> float()
get_hurt_rate() -> %s.  """%(rate))
    return []
get_base_boss_conf()


# 根据星期几获取BOSSID
week_day_boss_id = []
week_day_boss_id.append("\n\n%% 根据星期几获取BOSSID")
week_day_boss_id.append("%% @spec get_boss_id(week_day :: int()) -> boss_id :: int()")
@load_sheel(work_book, ur"boss生成配置表")
def get_boss_id(content):
    week_day = int(get_value(content[BaseField2.week_day], 0))
    boss_id = int(get_value(content[BaseField2.boss_id], 0))
    week_day_boss_id.append("""get_boss_id({0}) -> {1};""".format(week_day, boss_id))
    return []
get_boss_id()
week_day_boss_id.append("get_boss_id(_) -> false.")
data_boss.extend(week_day_boss_id)


# 处理字符串，将金币钻石和物品合并为一列，并去除为 0 的
def get_list(coin_amount, gold_amount, item_list):
    result = ''
    if not coin_amount == 0:
        if not result.strip() == '':
            result = result + ','
        result = '{coin, ' + str(coin_amount) + '}'
    if not gold_amount == 0:
        if not result.strip() == '':
            result = result + ','
        result = result + '{gold, ' + str(gold_amount) + '}'
    if not item_list.strip() == '':
        if not result.strip() == '':
            result = result + ','
        result = result + item_list
    return result


# 处理排行榜奖励整张表
world_boss_rank_reward = []
world_boss_rank_reward.append("""
%% @doc 根据排名获得奖励
%% @spec get_rank_reward(Rank::int()) -> list().
""")
@load_sheel(work_book, ur"个人排行榜奖励配置")
def rank_reward_list(content):
    rank = int(get_value(content[BaseField3.rank], 0))
    coin_amount = int(get_value(content[BaseField3.coin_amount], 0))
    gold_amount = int(get_value(content[BaseField3.gold_amount], 0))
    item_list = str(get_value(content[BaseField3.item_list], ''))
    world_boss_rank_reward.append("get_rank_reward(%d) -> [{coin, %d}, {gold, %d}] ++ [%s];"%(rank, coin_amount, gold_amount, item_list))
    return []
rank_reward_list()
world_boss_rank_reward.append("get_rank_reward(_) -> [].")
data_boss.extend(world_boss_rank_reward)

# 根据伤害量获取评价ID
union_reward_by_hurt = []
union_reward_by_hurt.append("\n\n%% 根据伤害量获取奖励")
union_reward_by_hurt.append("%% @spec get_union_reward_by_hurt(hurt_amount :: int()) -> list()")

evaluate_by_hurt = []
evaluate_by_hurt.append("\n\n%% 根据伤害量获取评价")
evaluate_by_hurt.append("%% get_evaluate_by_hurt({0}) -> evaluate :: str().")

@load_sheel(work_book, ur"公会奖励配置")
def get_union_reward_by_hurt_amount(content):
    min_hurt_amount = int(get_value(content[BaseField4.min_hurt_amount], 0))
    max_hurt_amount = int(get_value(content[BaseField4.max_hurt_amount], 0))
    coin_amount = int(get_value(content[BaseField4.coin_amount], 0))
    gold_amount = int(get_value(content[BaseField4.gold_amount], 0))
    item_list = str(get_value(content[BaseField4.item_list], ''))
    evaluate = str(get_value(content[BaseField4.evaluate], ''))
    union_reward_by_hurt.append("get_union_reward_by_hurt(HurtAmount) when HurtAmount >= {0} andalso HurtAmount =< {1} -> [{{coin, {2}}}, {{gold, {3}}}] ++ [{4}]; ".format(min_hurt_amount, max_hurt_amount, coin_amount, gold_amount, item_list))

    evaluate_by_hurt.append("get_evaluate_by_hurt(HurtAmount) when HurtAmount >= {0} andalso HurtAmount =< {1} -> <<\"{2}\">>;".format(min_hurt_amount, max_hurt_amount, evaluate))
    return []
get_union_reward_by_hurt_amount()
union_reward_by_hurt.append("get_union_reward_by_hurt(_) -> [].")
evaluate_by_hurt.append("get_evaluate_by_hurt(_) -> <<\"\">>.")
data_boss.extend(union_reward_by_hurt)
data_boss.extend(evaluate_by_hurt)


world_boss_union_rank = []
world_boss_union_rank.append("\n\n%% 根据军团排名获得奖励")
world_boss_union_rank.append("%% get_union_rank_reward_by_hurt(Rank::Num()) -> [].")

@load_sheel(work_book, ur"军团排名奖励")
def get_union_reward_by_rank(content):
    max_rank = int(get_value(content[BaseField8.evaluate_top], 0))
    min_rank = int(get_value(content[BaseField8.evaluate_low], 0))
    coin = int(get_value(content[BaseField8.coin_amount], 0))
    gold = int(get_value(content[BaseField8.gold_amount], 0))
    item_list = str(get_value(content[BaseField8.item_list], ''))

    world_boss_union_rank.append("get_union_rank_reward_by_hurt(Rank) when Rank >= %d andalso Rank =< %d -> [{coin, %d}, {gold, %d}] ++ [%s];"%(max_rank, min_rank, coin, gold, item_list))
    return []
get_union_reward_by_rank()
world_boss_union_rank.append("get_union_rank_reward_by_hurt(_) -> [].")
data_boss.extend(world_boss_union_rank)


# 根据战队等级获取最大伤害
max_damage_list = []
max_damage_list.append("\n\n%% 根据战队等级获取最大伤害")
max_damage_list.append("%% @spec get_max_damage(role_lvlev :: int()) -> max_damage :: int()")
@load_sheel(work_book, ur"极限伤害")
def get_max_damage(content):
    role_lv = int(get_value(content[BaseField5.role_lv], 0))
    max_damage = int(get_value(content[BaseField5.max_damage], 0))
    max_damage_list.append("""get_max_damage({0}) -> {1};""".format(role_lv, max_damage))
    return []
get_max_damage()
max_damage_list.append("get_max_damage(_)->false.")
data_boss.extend(max_damage_list)


# 根据购买次数获取相应的钻石花费
buy_times_cost_gold_list = []
buy_times_cost_gold_list.append("\n\n%% 根据购买次数获取相应的钻石花费")
buy_times_cost_gold_list.append("%% get_cost_gold_by_times(nth :: int()) -> cost_gold :: int()")
max_times = 0
@load_sheel(work_book, ur"购买次数钻石")
def get_cost_gold_by_times(content):
    nth = int(get_value(content[BaseField6.nth], 0))
    cost_gold = int(get_value(content[BaseField6.gold], 0))
    global max_times
    max_times = nth
    buy_times_cost_gold_list.append("""get_cost_gold_by_times({0}) -> {1};""".format(nth, cost_gold))
    return []
get_cost_gold_by_times()
buy_times_cost_gold_list.append("get_cost_gold_by_times(_) -> 0.")
data_boss.extend(buy_times_cost_gold_list)
max_times_list = []
max_times_list.append("\n\n%% 根据购买次数获取相应的钻石花费")
max_times_list.append("get_buy_max_times() -> %d."%(max_times))
data_boss.extend(max_times_list)


max_boss_lev = 0

max_hp_list = []
max_hp_list.append("""
%% @doc 最大血量
%% @spec max_hp(BossLev::int()) -> MaxHp::int() """)

@load_sheel(work_book, ur"boss配置")
def get_boss_hp(content):
    boss_lev = int(content[BaseField7.boss_lev])
    max_hp = int(content[BaseField7.max_hp])
    global max_boss_lev
    if max_boss_lev < boss_lev:
        max_boss_lev = boss_lev
    max_hp_list.append("max_hp(BossLev) when BossLev =:= %d -> %d;"%(boss_lev, max_hp))
    return []

get_boss_hp()
max_hp_list.append("max_hp(_) -> 10000000000.")

data_boss.extend(max_hp_list)

data_boss.append("""
%% @doc 下一个boss等级
%% @spec next_boss_lev(OldBossLev::int()) -> NewBossLev::int()
next_boss_lev(OldBossLev) -> min(OldBossLev + 1, %d). """%(max_boss_lev))

gen_erl(boss_erl, data_boss)
