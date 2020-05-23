#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
精彩活动配置表
@author: ZhaoMing
@deprecated: 2015年01月21日
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"newBattlefront")

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

CityIndex = """
    cityID, name, type, realm, nearCity, rate, isCreateMine, isNPCMoveTo, holdCityItem
    """
RankIndex = """
    index, minRank, maxRank, gold, coin, prestige, item
    """

CityField  = Field('CityField'  , CityIndex)
RankField  = Field('RankField'  , RankIndex)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

battlefront_erl = "data_battlefront"
data_battlefront = module_header(ur"精彩活动配置", battlefront_erl, "zm", "fun_activity.xlsx", "data_battlefront.py")

data_battlefront.append("""

-include("battlefront.hrl").

-export([
        get_all/0
        ,get_all_realm/0
        ,get_near_city_id_list/1
        ,get_main_city_id/1
        ,get_all_not_main_realm/0
        ,get_realm/1
        ,is_main_realm/1
        ,get_all_by_realm/1
        ,is_open_time/1
        ,detect_cost/1
        ,last_atk_reward/1
        ,realm_change_reward/1
        ,get_rank_reward_list/1
        ,get_add_gold/1
        ,begin_time/0
        ,end_time/0
        ,action_revive_time/0
        ,die_revive_time/0
        ,double_cost/1
        ,max_double_count/0
        ,is_create_mine/1
        ,npc_move_to/0
        ,npc_power_list/0
        ,get_hold_reward_city_id_list/0
        ,get_hold_reward/1
        ,get_npc_name/1
        ]).
""")

all_city_id_list = []
all_city_id_not_main_realm_list = []
all_by_realm_list = {}

main_city_id_list = []
main_city_id_list.append("""
%% @doc 根据阵营获得大本营的城市ID
%% @spec main_city_id(Realm::int()) -> CityID::int() """)

near_city_id_list = []
near_city_id_list.append("""
%% @doc 附近城市列表
%% @spec get_near_city_id_list(CityID::int()) -> [CityID::int()] """)

is_main_realm_list = []
is_main_realm_list.append("""
%% @doc 是否是主阵营
%% @spec is_main_realm(CityID::int()) -> false|true """)

realm_list = []
realm_list.append("""
%% @doc 根据城市ID获得所在阵营
%% @spec get_realm(CityID::int()) -> Realm::int() """)

add_gold_list = []
add_gold_list.append("""
%% @doc 每分钟加元宝数目
%% @spec get_add_gold(CityID::int()) -> Gold::float() """)

is_create_mine_list = []
is_create_mine_list.append("""
%% @doc 是否可以产出矿车
%% @spec is_create_mine(CityID::int()) -> true | false """)

npc_move_to_list = []
npc_move_to_list.append("""
%% @doc NPC移动目的地
%% @spec npc_move_to() -> CityID::int() """)

get_hold_reward_city_id_list = []

get_hold_reward_list = []
get_hold_reward_list.append("""
%% @doc 活动结束 占领城市获得的奖励
%% @spec get_hold_reward(CityID::int()) -> list() """)

all_realm_list = []

@load_sheel(work_book, ur"城市配置")
def get_city(content):
    city_id = int(content[CityField.cityID])
    city_type = int(content[CityField.type])
    realm = int(content[CityField.realm])
    near_city_id = get_str(content[CityField.nearCity], '')
    gold = int(get_value(content[CityField.rate], 0))
    is_create_mine = int(get_value(content[CityField.isCreateMine], 0))
    is_npc_move_to = int(get_value(content[CityField.isNPCMoveTo], 0))
    item = get_str(content[CityField.holdCityItem], '')

    if city_type != 1:
        all_city_id_not_main_realm_list.append("%d"%(city_id))
        add_gold_list.append("get_add_gold(CityID) when CityID =:= %d -> %f;"%(city_id, gold / 1000.0))

    if city_type == 1:
        main_city_id_list.append("get_main_city_id(%d) -> %d;"%(realm, city_id))

    if realm == -1:
        main_city_id_list.append("get_main_city_id(%d) -> %d;"%(realm, city_id))

    if is_create_mine == 1:
        is_create_mine_list.append("is_create_mine(CityID) when CityID =:= %d -> true;"%(city_id))

    if is_npc_move_to == 1:
        npc_move_to_list.append("npc_move_to() -> %d."%(city_id))

    if item != '':
        get_hold_reward_city_id_list.append("%d"%(city_id))
        get_hold_reward_list.append("get_hold_reward(CityID) when CityID =:= %d -> [%s];"%(city_id, item))

    all_realm_list.append("%d"%(realm))

    all_city_id_list.append("%d"%(city_id))
    all_by_realm_list.setdefault(realm, [])
    all_by_realm_list[realm].append("%d"%(city_id))
    near_city_id_list.append("get_near_city_id_list(%d) -> [%s];"%(city_id, near_city_id))
    realm_list.append("get_realm(%d) -> %d;"%(city_id, realm))
    if city_type == 1:
        is_main_realm_list.append("is_main_realm(%d) -> true;"%(city_id))
    return []
get_city()

near_city_id_list.append("get_near_city_id_list(_) -> [].")
is_main_realm_list.append("is_main_realm(_) -> false.")
realm_list.append("get_realm(_) -> 0.")
main_city_id_list.append("get_main_city_id(_) -> 0.")
add_gold_list.append("get_add_gold(_) -> 0.")
is_create_mine_list.append("is_create_mine(_) -> false.")
get_hold_reward_list.append("get_hold_reward(_) -> [].")
data_battlefront.extend(near_city_id_list)
data_battlefront.extend(is_main_realm_list)
data_battlefront.extend(realm_list)
data_battlefront.extend(main_city_id_list)
data_battlefront.extend(add_gold_list)
data_battlefront.extend(is_create_mine_list)
data_battlefront.extend(npc_move_to_list)
data_battlefront.extend(get_hold_reward_list)


data_battlefront.append("""
%% @doc 所有阵营
%% @spec get_all_realm() -> list()
get_all_realm() -> [%s]. """%(",".join(unique_list(all_realm_list))))

data_battlefront.append("""
%% @doc 活动结束 占领城市 可以获得奖励
%% @spec get_hold_reward_city_id_list() -> list() 
get_hold_reward_city_id_list() -> [%s]. """%(",".join(get_hold_reward_city_id_list)))


data_battlefront.append("""
%% @doc 所有城市列表
%% @spec get_all() -> [CityID::int()] """)
data_battlefront.append("get_all() -> [%s]."%(",".join(all_city_id_list)))

data_battlefront.append("""
%% @doc 所有的非大本营的城市列表
%% @spec get_all_not_main_realm() -> [CityID::int()] """)
data_battlefront.append("get_all_not_main_realm() -> [%s]."%(",".join(all_city_id_not_main_realm_list)))

data_battlefront.append("""
%% @doc 获取某个阵营的所有城市列表
%% @spec get_all_by_realm(Realm::int()) -> [CityID::int()] """)
for k in all_by_realm_list:
    data_battlefront.append("get_all_by_realm(%d) -> [%s];"%(k, ",".join(all_by_realm_list[k])))
data_battlefront.append("get_all_by_realm(_) -> [].")

rank_reward_list = []
rank_reward_list.append("""
%% @doc 排名奖励
%% @spec get_rank_reward_list(Rank::int()) -> list() """)
@load_sheel(work_book, ur"排行榜奖励")
def get_rank(content):
    min_rank = int(content[RankField.minRank])
    max_rank = int(content[RankField.maxRank])
    gold = int(get_value(content[RankField.gold], 0))
    coin = int(get_value(content[RankField.coin], 0))
    prestige = int(get_value(content[RankField.prestige], 0))
    item = get_str(content[RankField.item], '')
    rank_reward_list.append("get_rank_reward_list(Rank) when Rank >= %d, Rank =< %d -> [{gold, %d}, {coin, %d}, {prestige, %d}] ++ [%s];"%(min_rank, max_rank, gold, coin, prestige, item))
    return []
get_rank()
rank_reward_list.append("get_rank_reward_list(_) -> [].")

data_battlefront.extend(rank_reward_list)

open_time_list = []
open_time_list.append("""
%% @doc 
%% 是否是开放时间
%% Time是相对今天0点的时间差 
%% @end
%% @spec is_open_time(Time) -> false | true """)



@load_sheel(work_book, ur"活动开启时间")
def get_open_time(content):
    b_str = str(content[1])
    b_array = b_str.split(",")
    begin_time = int(b_array[0]) * 3600 + int(b_array[1]) * 60
    e_str = str(content[2])
    e_array = e_str.split(",")
    end_time = int(e_array[0]) * 3600 + int(e_array[1]) * 60
    open_time_list.append("is_open_time(Time) when Time >= %d, Time < %d -> true;"%(begin_time, end_time))
    open_time_list.append("is_open_time(_) -> false.")
    open_time_list.append("begin_time() -> %d."%(begin_time))
    open_time_list.append("end_time() -> %d."%(end_time))


    return []
get_open_time()

data_battlefront.extend(open_time_list)

detect_cost_list = []
detect_cost_list.append("""
%% 刺探消耗
%% detect_cost(Nth::int()) -> list() """)

max_buy_count = 0
@load_sheel(work_book, ur"刺探钻石花费")
def get_detect_cost(content):
    global max_buy_count
    nth = int(content[0])
    gold = int(content[1])
    if nth > max_buy_count:
        max_buy_count = nth
    detect_cost_list.append("detect_cost(%d) -> [{del_gold, %d}];"%(nth, gold))
    return []
get_detect_cost()
detect_cost_list.append("detect_cost(_) -> detect_cost(%d)."%(max_buy_count))
data_battlefront.extend(detect_cost_list)

last_atk_reward_list = []
last_atk_reward_list.append("""
%% @doc 最后一击奖励
%% @spec last_atk_reward(Lev::int()) -> list()""")

realm_change_reward_list = []
realm_change_reward_list.append("""
%% @doc 占领城市奖励
%% @spec realm_change_reward(Lev::int()) -> int() """)

@load_sheel(work_book, ur"战斗奖励")
def get_fight_reward(content):
    begin_lev = int(content[0])
    end_lev = int(content[1])
    last_atk_reward = get_str(content[2], '')
    realm_change_reward = get_str(content[3], '')
    prestige = int(content[4])
    last_atk_reward_list.append("last_atk_reward(Lev) when Lev >= %d, Lev =< %d -> [{add_items, [%s]}, {add_prestige, %d}];"%(begin_lev, end_lev, last_atk_reward, prestige))
    realm_change_reward_list.append("realm_change_reward(Lev) when Lev >= %d, Lev =< %d -> [{add_items, [%s]}, {add_prestige, %d}];"%(begin_lev, end_lev, realm_change_reward, prestige))
    return []

get_fight_reward()
last_atk_reward_list.append("last_atk_reward(_) -> [].")
realm_change_reward_list.append("realm_change_reward(_) -> [].")
data_battlefront.extend(last_atk_reward_list)
data_battlefront.extend(realm_change_reward_list)

@load_sheel(work_book, ur"CD配置")
def get_cd_conf(content):
    type = int(content[0])
    value = int(content[1])
    if type == 1:
        data_battlefront.append("""
%% @doc 行动值恢复时间
%% @spec action_revive_time() -> int()
action_revive_time() -> %d."""%(value))
    if type == 2:
        data_battlefront.append("""
%% @doc 死亡复活时间
%% @spec die_revive_time() -> int()
die_revive_time() -> %d."""%(value))
    return []

get_cd_conf()

double_cost_list = []
double_cost_list.append("""
%% @doc 翻倍消耗钻石
%% @spec double_cost(Nth::int()) -> list() """)

max_double_count = 0

@load_sheel(work_book, ur"功勋翻倍消耗钻石")
def get_double(content):
    global max_double_count
    nth = int(content[0])
    gold = int(content[1])
    if nth > max_double_count:
        max_double_count = nth
    double_cost_list.append("double_cost(%d) -> [{del_gold, %d}];"%(nth, gold))
    return []

get_double()
double_cost_list.append("double_cost(_) -> [].")

data_battlefront.extend(double_cost_list)

data_battlefront.append("""
%% @doc 翻倍最大购买次数
%% @spec max_double_count() -> int() 
max_double_count() -> %d. """%(max_double_count))

npc_power_list = []

npc_name_list = []
npc_name_list.append("""
%% @doc 获取npc名字
%% @spec get_npc_name(#bf_role_power{}) -> binary() """)

@load_sheel(work_book, ur"NPC配置")
def get_npc_power(content):
    name = str(content[1])
    hero_power = int(content[3])
    leader_lev = int(content[4])
    prestige = int(content[5])
    npc_power_list.append("#bf_role_power{hero_power = %d, acc_leader_lev = %d, prestige_calc = %d}"%(hero_power, leader_lev, prestige))

    npc_name_list.append("get_npc_name(#bf_role_power{hero_power = HeroPower, acc_leader_lev = LeaderLev, prestige_calc = Prestige}) when HeroPower =:= %d, LeaderLev =:= %d, Prestige =:= %d -> <<\"%s\">>;"%(hero_power, leader_lev, prestige, name))
    return []

get_npc_power()

npc_name_list.append("get_npc_name(_) -> <<\"NPC\">>.")

data_battlefront.append("npc_power_list() -> [%s]."%(",".join(npc_power_list)))
data_battlefront.extend(npc_name_list)

gen_erl(battlefront_erl, data_battlefront)
