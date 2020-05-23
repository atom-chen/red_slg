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
work_book = load_excel(ur"battlefront")

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
    cityID, name, type, realm, nearCity, drop
    """
MinorIndex = """
    nth, gold
    """
TaskIndex = """
    taskID, taskType, winItemList, failItemList
    """
RankIndex = """
    index, minRank, maxRank, gold, coin, prestige, item
    """

CityField  = Field('CityField'  , CityIndex)
MinorField = Field('MinorField' , MinorIndex)
TaskField  = Field('TaskField'  , TaskIndex)
RankField  = Field('RankField'  , RankIndex)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

city_erl = "data_city"
data_city = module_header(ur"精彩活动配置", city_erl, "zm", "fun_activity.xlsx", "data_city.py")

data_city.append("""
-export([
        get_near_city_id_list/1
        ,get_all/0
        ,get_all_realm/0
        ,get_all_not_main_realm/0
        ,get_realm/1
        ,is_main_realm/1
        ,get_all_by_realm/1
        ,get_dispatch_cost/1
        ,get_task_reward_list/2
        ,get_task_type/1
        ,get_rank_reward_list/1
        ,all_time_list/0
        ,is_in_task/1
        ,get_task_id/1
        ,get_time_range/1
        ,get_time_status/2
        ,buy_morale_cost/1
        ,detect_cost/1
        ,last_atk_reward/1
        ,realm_change_reward/1
        ,atk_reward/1
        ,buy_action_cost/1
        ]).
""")

all_city_id_list = []
all_city_id_not_main_realm_list = []
all_by_realm_list = {}

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

all_realm_list = []

@load_sheel(work_book, ur"城市配置")
def get_city(content):
    city_id = int(content[CityField.cityID])
    city_type = int(content[CityField.type])
    realm = int(content[CityField.realm])
    near_city_id = get_str(content[CityField.nearCity], '')
    drop = get_str(content[CityField.drop], '')

    if city_type != 1:
        all_city_id_not_main_realm_list.append("%d"%(city_id))

    all_city_id_list.append("%d"%(city_id))
    all_by_realm_list.setdefault(realm, [])
    all_by_realm_list[realm].append("%d"%(city_id))
    near_city_id_list.append("get_near_city_id_list(%d) -> [%s];"%(city_id, near_city_id))
    realm_list.append("get_realm(%d) -> %d;"%(city_id, realm))
    all_realm_list.append("%d"%(realm))
    if city_type == 1:
        is_main_realm_list.append("is_main_realm(%d) -> true;"%(city_id))
    return []
get_city()

near_city_id_list.append("get_near_city_id_list(_) -> [].")
is_main_realm_list.append("is_main_realm(_) -> false.")

realm_list.append("get_realm(_) -> 0.")
data_city.extend(near_city_id_list)
data_city.extend(is_main_realm_list)
data_city.extend(realm_list)

data_city.append("""
%% @doc 所有阵营
%% @spec get_all_realm() -> list()
get_all_realm() -> [%s]. """%(",".join(unique_list(all_realm_list))))

data_city.append("""
%% @doc 所有城市列表
%% @spec get_all() -> [CityID::int()] """)
data_city.append("get_all() -> [%s]."%(",".join(all_city_id_list)))

data_city.append("""
%% @doc 所有的非大本营的城市列表
%% @spec get_all_not_main_realm() -> [CityID::int()] """)
data_city.append("get_all_not_main_realm() -> [%s]."%(",".join(all_city_id_not_main_realm_list)))

data_city.append("""
%% @doc 获取某个阵营的所有城市列表
%% @spec get_all_by_realm(Realm::int()) -> [CityID::int()] """)
for k in all_by_realm_list:
    data_city.append("get_all_by_realm(%d) -> [%s];"%(k, ",".join(all_by_realm_list[k])))
data_city.append("get_all_by_realm(_) -> [].")

dispatch_cost_list = []
dispatch_cost_list.append("""
%% @doc 派遣幻影消耗
%% @spec get_dispatch_cost(Nth::int()) -> list() """)
@load_sheel(work_book, ur"派遣幻影")
def get_dispatch(content):
    nth = int(content[MinorField.nth])
    gold = int(content[MinorField.gold])
    dispatch_cost_list.append("get_dispatch_cost(%d) -> [{del_gold, %d}];"%(nth, gold))
    return []

get_dispatch()
dispatch_cost_list.append("get_dispatch_cost(_) -> [].")
data_city.extend(dispatch_cost_list)

task_reward_list = []
task_reward_list.append("""
%% @doc 任务奖励
%% @spec get_task_reward_list(TaskID::int(), IsWin::0(fail)|1(win)) -> list() """)
task_type_list = []
task_type_list.append("""
%% @doc 根据任务ID获得任务类型
%% @spec get_task_type(TaskID::int()) -> TaskType::int() """)

@load_sheel(work_book, ur"阵营任务类型")
def get_task(content):
    task_id = int(content[TaskField.taskID])
    task_type = int(content[TaskField.taskType])
    win_item_list = get_str(content[TaskField.winItemList], '')
    fail_item_list = get_str(content[TaskField.failItemList], '')
    task_reward_list.append("get_task_reward_list(TaskID, IsWin) when TaskID =:= %d andalso IsWin =:= 1 -> [{add_items, [%s]}];"%(task_id, win_item_list))
    task_reward_list.append("get_task_reward_list(TaskID, IsWin) when TaskID =:= %d andalso IsWin =:= 0 -> [{add_items, [%s]}];"%(task_id, fail_item_list))
    task_type_list.append("get_task_type(%d) -> %d;"%(task_id, task_type))
    return []
get_task()
task_reward_list.append("get_task_reward_list(_, _) -> [].")
task_type_list.append("get_task_type(_) -> 0.")

data_city.extend(task_reward_list)
data_city.extend(task_type_list)

rank_reward_list = []
rank_reward_list.append("""
%% @doc 排名奖励
%% @spec get_rank_reward_list(Rank::int()) -> list() """)
@load_sheel(work_book, ur"排行榜奖励")
def get_rank(content):
    min_rank = int(content[RankField.minRank])
    max_rank = int(content[RankField.maxRank])
    gold = int(content[RankField.gold])
    coin = int(content[RankField.coin])
    prestige = int(content[RankField.prestige])
    item = get_str(content[RankField.item], '')
    rank_reward_list.append("get_rank_reward_list(Rank) when Rank >= %d, Rank =< %d -> [{add_gold, %d}, {add_coin, %d}, {add_prestige, %d}, {add_items, [%s]}];"%(min_rank, max_rank, gold, coin, prestige, item))
    return []
get_rank()
rank_reward_list.append("get_rank_reward_list(_) -> [].")

data_city.extend(rank_reward_list)

task_time_list = []
task_time_list.append("""
%% @doc 检测当前时间是否有任务
%% @spec is_in_task(Time :: int()) -> false | true """)
task_id_list = []
task_id_list.append("""
%% @doc 根据时间随机获得一个任务
%% @spec get_task_id(Time :: int()) -> TaskID :: int() | 0 """)

time_range_list = []
time_range_list.append("""
%% @doc 获取时间范围
%% @spec get_time_range(Time::int()) -> {BeginTime::int(), EndTime::int()} | false""")

time_status_list = []
time_status_list.append("""
%% @doc 获取时间状态
%% @spec get_time_status(Hour::int(), Minute::int()) -> begin_time | end_time | false """)
all_time_list = []
@load_sheel(work_book, ur"阵营任务时间配置")
def get_task_time(content):
    b_str = str(content[0])
    b_array = b_str.split(":")
    begin_time = int(b_array[0]) * 3600 + int(b_array[1]) * 60
    e_str = str(content[1])
    e_array = e_str.split(":")
    end_time = int(e_array[0]) * 3600 + int(e_array[1]) * 60
    task_id = get_str(content[2], '')
    task_time_list.append("is_in_task(Time) when Time >= %d andalso Time =< %d -> true;"%(begin_time, end_time))
    task_id_list.append("get_task_id(Time) when Time >= %d andalso Time =< %d -> util:rand_list([%s]);"%(begin_time, end_time, task_id))
    all_time_list.append("{%d, %d}"%(begin_time, end_time))
    time_range_list.append("get_time_range(Time) when Time >= %d, Time < %d -> {%d, %d};"%(begin_time, end_time, begin_time, end_time))
    time_status_list.append("get_time_status(%d, %d) -> begin_time;"%(int(b_array[0]), int(b_array[1])))
    time_status_list.append("get_time_status(%d, %d) -> end_time;"%(int(e_array[0]), int(e_array[1])))
    return []
get_task_time()

task_time_list.append("is_in_task(_) -> false.")
task_id_list.append("get_task_id(_) -> 0.")
time_range_list.append("get_time_range(_) -> {0, 0}.")
time_status_list.append("get_time_status(_, _) -> false.")

buy_morale_cost_list = []
buy_morale_cost_list.append("""
%% 复活消耗
%% buy_morale_cost(BuyNth) -> list() """)

max_buy_count = 0
@load_sheel(work_book, ur"复活购买价格")
def get_buy_morale(content):
    global max_buy_count
    buy_time = int(content[0])
    gold = int(content[1])
    if max_buy_count < buy_time:
        max_buy_count = buy_time
    buy_morale_cost_list.append("buy_morale_cost(%d) -> [{del_gold, %d}];"%(buy_time, gold))
    return []
get_buy_morale()

buy_morale_cost_list.append("buy_morale_cost(_) -> buy_morale_cost(%d)."%(max_buy_count))
data_city.extend(buy_morale_cost_list)

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
data_city.extend(detect_cost_list)

action_cost_list = []
action_cost_list.append("""
%% 行动力购买
%% buy_action_cost(Nth::int()) -> list() """)

max_buy_count = 0
@load_sheel(work_book, ur"行动力购买")
def get_buy_action_cost(content):
    global max_buy_count
    nth = int(content[0])
    gold = int(content[1])
    if nth > max_buy_count:
        max_buy_count = nth
    action_cost_list.append("buy_action_cost(%d) -> [{del_gold, %d}];"%(nth, gold))
    return []
get_buy_action_cost()
action_cost_list.append("buy_action_cost(_) -> buy_action_cost(%d)."%(max_buy_count))
data_city.extend(action_cost_list)

last_atk_reward_list = []
last_atk_reward_list.append("""
%% @doc 最后一击奖励
%% @spec last_atk_reward(Lev::int()) -> list()""")

atk_reward_list = []
atk_reward_list.append("""
%% @doc 战斗获得
%% @spec atk_reward(Lev::int()) -> list() """)

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
    last_atk_reward_list.append("last_atk_reward(Lev) when Lev >= %d, Lev =< %d -> [{add_items, [%s]}];"%(begin_lev, end_lev, last_atk_reward))
    realm_change_reward_list.append("realm_change_reward(Lev) when Lev >= %d, Lev =< %d -> [{add_items, [%s]}];"%(begin_lev, end_lev, realm_change_reward))
    atk_reward_list.append("atk_reward(Lev) when Lev >= %d, Lev =< %d -> [{add_prestige, %d}];"%(begin_lev, end_lev, prestige) )
    return []

get_fight_reward()
last_atk_reward_list.append("last_atk_reward(_) -> [].")
realm_change_reward_list.append("realm_change_reward(_) -> [].")
atk_reward_list.append("atk_reward(_) -> [].")
data_city.extend(last_atk_reward_list)
data_city.extend(realm_change_reward_list)
data_city.extend(atk_reward_list)

data_city.append("""
%% @doc 所有的时间
%% @spec all_time_list() -> [{BeginTime::int(), EndTime::int()}] """)
data_city.append("all_time_list() -> [%s]."%(",".join(all_time_list)))
data_city.extend(task_time_list)
data_city.extend(task_id_list)
data_city.extend(time_range_list)
data_city.extend(time_status_list)

gen_erl(city_erl, data_city)
