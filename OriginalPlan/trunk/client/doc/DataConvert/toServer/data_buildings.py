#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
建筑升级配置
@author: ZhaoMing
@deprecated: 2015-10-10
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"buildings")

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

## 必须和excel里面的列保持一致的顺序
BuildIndex = """
    id,name,lev,buildLev,coin,item,costTime,leadership,endurance,GoldTime,CoinRate,
    crystal,iron,uranium,wildReward,wildMaxReward,army,carry,protectedresourse,systemId,
    wallrepairrate,wallhp
"""
# 生成域枚举           
BuildField        = Field('BuildField', BuildIndex)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

build_erl = "data_build"
data_build = module_header(ur"装备配置", build_erl, "zm", "buildings.xlsx", "data_buildings.py")
data_build.append("""
-export([
         get_all/0,
         get_cd_time/2,
         up_cost/2,
         max_lev/1,
         need_role_lev/2,
         pre_build_list/2,
         get_leadership/2,
         get_endurance/2,
         one_gold_cost_time/2,
         cost_coin_rate/2,
         wilderness_reward_one_hour/2,
         wilderness_reward_max_acc/2,
         get_army/2,
         get_carry/2,
         get_protected_res_list/2,
         auto_build_cost/1,
         get_base_repair_rate/2,
         get_base_blood/2
        ]).
""")

all_id_list = []

cd_time_list = []
cd_time_list.append("""
%% @doc 升级cd消耗
%% @spec get_cd_time(BuildID::int(), Lev::int()) -> CDTime::int() """)

up_cost_list = []
up_cost_list.append("""
%% @doc 升级消耗
%% @spce up_cost(BuildID::int(), Lev::int()) -> list() """)

max_lev_dict = {}

need_role_lev_list = []
need_role_lev_list.append("""
%% @doc 需要角色等级
%% @spec need_role_lev(BuildID::int(), Lev::int()) -> RoleLev::int() """)

pre_build_list = []
pre_build_list.append("""
%% @doc 前置建筑等级
%% @spec pre_build_list(BuildID::int(), Lev::int()) -> list() """)

get_leadership_list = []
get_leadership_list.append("""
%% @doc 获取统帅力
%% @spec get_leadership(Lev::int()) -> int() """)

get_endurance_list = []
get_endurance_list.append("""
%% @doc 获取耐久度
%% @spec get_endurance(Lev::int()) -> int() """)

clean_cd_time_list = []
clean_cd_time_list.append("""
%% @doc 加速升级时每钻石可以抵消的时间
%% @spec one_gold_cost_time(BuildID::int(), buildLev::int()) -> int() """) 

cost_coin_rate_list = []
cost_coin_rate_list.append("""
%% @doc 建筑等级 对兵种的金币百分比
%% @spec cost_coin_rate(BuildID::int(), BuildLev::int()) -> float() """)

wilderness_reward_one_hour_list = []
wilderness_reward_one_hour_list.append("""
%% @doc 冶炼厂 每小时奖励
%% @spec wilderness_reward_one_hour(BuildID::int(), BuildLev::int()) -> int() """)

wilderness_reward_max_acc_list = []
wilderness_reward_max_acc_list.append("""
%% @doc 冶炼厂 每小时奖励
%% @spec wilderness_reward_max_acc(BuildID::int(), BuildLev::int()) -> int() """)


get_army_list = []
get_army_list.append("""
%% @doc 可出征部队数
%% @spec get_army(BuildID::int(), BuildLev::int()) -> Army::int() """)

get_carry_list = []
get_carry_list.append("""
%% @doc 每统率负重
%% @spec get_carry(BuildID::int(), BuildLev::int()) -> Carry::int() """)

get_protected_res_list = []
get_protected_res_list.append("""
%% @doc 保护资源列表
%% @spec get_protected_res_list(BuildID::int(), BuildLev::int()) -> ProtectedResList :: list() """)

get_base_repair_rate_list = []
get_base_repair_rate_list.append("""
%% @doc 城防恢复值
%% @spec get_base_repair_rate(BuildID::int(), BuildLev::int()) -> BaseRepairRate :: int() """)

get_base_blood_list = []
get_base_blood_list.append("""
%% @doc 城防血量值
%% @spec get_base_blood(BuildID::int(), BuildLev::int()) -> BaseBlood :: int() """)


@load_sheel(work_book, ur"建筑升级配置")
def get_build(content):
    id = int(content[BuildField.id])
    lev = int(content[BuildField.lev])
    ## role_lev = int(get_value(content[BuildField.roleLev], 0))
    pre_build = get_str(content[BuildField.buildLev], '')
    coin = int(get_value(content[BuildField.coin], 0))
    item = get_str(content[BuildField.item], '')
    cd_time = int(get_value(content[BuildField.costTime], 0))
    leadership = int(get_value(content[BuildField.leadership], 0))
    endurance = int(get_value(content[BuildField.endurance], 0))
    one_gold_cost_time = int(get_value(content[BuildField.GoldTime], 0))
    cost_rate = int(get_value(content[BuildField.CoinRate], 0))
    crystal = int(get_value(content[BuildField.crystal], 0))
    iron = int(get_value(content[BuildField.iron], 0))
    uranium = int(get_value(content[BuildField.uranium], 0))
    wild_reward = int(get_value(content[BuildField.wildReward], 0))
    wild_max_reward = int(get_value(content[BuildField.wildMaxReward], 0))
    army = int(get_value(content[BuildField.army], 0))
    carry = int(get_value(content[BuildField.carry], 0))
    protected_res = get_str(content[BuildField.protectedresourse], '')
    base_repair_rate = int(get_value(content[BuildField.wallrepairrate], 0))
    base_blood = int(get_value(content[BuildField.wallhp], 0))


    if army != 0:
        get_army_list.append("get_army(BuildID, BuildLev) when BuildID =:= %d, BuildLev =:= %d -> %d;"%(id, lev, army))

    if carry != 0:
        get_carry_list.append("get_carry(BuildID, BuildLev) when BuildID =:= %d, BuildLev =:= %d -> %d;"%(id, lev, carry))

    if base_repair_rate != 0:
        get_base_repair_rate_list.append("get_base_repair_rate(BuildID, BuildLev) when BuildID =:= %d, BuildLev =:= %d -> %d;"%(id, lev, base_repair_rate))

    if base_blood != 0:
        get_base_blood_list.append("get_base_blood(BuildID, BuildLev) when BuildID =:= %d, BuildLev =:= %d -> %d;"%(id, lev, base_blood))

    if protected_res != "":
        get_protected_res_list.append("get_protected_res_list(BuildID, BuildLev) when BuildID =:= %d, BuildLev =:= %d -> [%s];"%(id, lev, protected_res))

    all_id_list.append("%d"%(id))
    cd_time_list.append("get_cd_time(BuildID, Lev) when BuildID =:= %d, Lev =:= %d -> %d;"%(id, lev, cd_time))
    up_cost_list.append("up_cost(BuildID, Lev) when BuildID =:= %d, Lev =:= %d -> [{del_coin, %d}, {del_items, [%s]}, {del_crystal, %d}, {del_iron, %d}, {del_uranium, %d}];"%(id, lev, coin, item, crystal, iron, uranium))

    get_leadership_list.append("get_leadership(BuildID, Lev) when BuildID =:= %d, Lev =:= %d -> %d;"%(id, lev, leadership))
    get_endurance_list.append("get_endurance(BuildID, Lev) when BuildID =:= %d, Lev =:= %d ->  %d;"%(id, lev, endurance))

    max_lev_dict.setdefault(id, 0)
    if max_lev_dict[id] < lev :
        max_lev_dict[id] = lev

    need_role_lev_list.append("need_role_lev(BuildID, Lev) when BuildID =:= %d, Lev =:= %d -> %d;"%(id, lev, 0))

    pre_build_list.append("pre_build_list(BuildID, Lev) when BuildID =:= %d, Lev =:= %d -> [%s];"%(id, lev, pre_build))
    clean_cd_time_list.append("one_gold_cost_time(BuildID, Lev) when BuildID =:= %d, Lev =:= %d -> max(1, %d);"%(id, lev, one_gold_cost_time))

    if cost_rate != 0:
        cost_coin_rate_list.append("cost_coin_rate(BuildID, Lev) when BuildID =:= %d, Lev =:= %d -> max(0, %f);"%(id, lev, 1 - cost_rate/10000.0))

    if (wild_reward != 0 or wild_max_reward != 0): 
        wilderness_reward_one_hour_list.append("wilderness_reward_one_hour(BuildID, Lev) when BuildID =:= %d, Lev =:= %d -> %d;"%(id, lev, wild_reward))
        wilderness_reward_max_acc_list.append("wilderness_reward_max_acc(BuildID, Lev) when BuildID =:= %d, Lev =:= %d -> %d;"%(id, lev, wild_max_reward))
    return []

get_build()

cd_time_list.append("get_cd_time(_, _) -> 0.")
up_cost_list.append("up_cost(_, _) -> [].")
need_role_lev_list.append("need_role_lev(_, _) -> 0.")
pre_build_list.append("pre_build_list(_, _) -> [].")
get_leadership_list.append("get_leadership(_, _) -> 0.")
get_endurance_list.append("get_endurance(_, _) -> 0.")
clean_cd_time_list.append("one_gold_cost_time(_, _) -> 0.")
cost_coin_rate_list.append("cost_coin_rate(_, _) -> 1.")
wilderness_reward_one_hour_list.append("wilderness_reward_one_hour(_, _) -> 0.")
wilderness_reward_max_acc_list.append("wilderness_reward_max_acc(_, _) -> 0.")
get_army_list.append("get_army(_, _) -> 0.")
get_carry_list.append("get_carry(_, _) -> 0.")
get_base_repair_rate_list.append("get_base_repair_rate(_, _) -> 0.")
get_base_blood_list.append("get_base_blood(_, _) -> 0.")
get_protected_res_list.append("get_protected_res_list(_, _) -> [].")

data_build.append("""
%% @doc 所有建筑
%% @spec get_all() -> list() """)
data_build.append("get_all() -> [%s]."%(",".join(unique_list(all_id_list))))

data_build.extend(cd_time_list)
data_build.extend(up_cost_list)
data_build.extend(need_role_lev_list)
data_build.extend(pre_build_list)
data_build.extend(get_leadership_list)
data_build.extend(get_endurance_list)
data_build.extend(clean_cd_time_list)
data_build.extend(cost_coin_rate_list)
data_build.extend(wilderness_reward_one_hour_list)
data_build.extend(wilderness_reward_max_acc_list)
data_build.extend(get_army_list)
data_build.extend(get_carry_list)
data_build.extend(get_base_repair_rate_list)
data_build.extend(get_protected_res_list)
data_build.extend(get_base_blood_list)

data_build.append("""
%% @doc 最大等级
%% @spec max_lev(BuildID::int()) -> MaxLev::int() """)
for i in max_lev_dict:
    data_build.append("max_lev(%d) -> %d;"%(i, max_lev_dict[i]))
data_build.append("max_lev(_) -> 0.")

auto_build_cost_list = []

@load_sheel(work_book, ur"委托时间购买花费")
def get_auto_time(content):
    timeleft = content[0]
    gold = content[1]
    auto_build_cost_list.append("auto_build_cost(LeftTime) when LeftTime >= %d -> [{del_gold, %d}];"%( (timeleft + 1) * 60, gold))
    return []

get_auto_time()

auto_build_cost_list.append("""
%% @doc 委托时间购买花费
%% @spec auto_build_cost(LeftTime::int()) -> list() """)
auto_build_cost_list.reverse()

auto_build_cost_list.append("auto_build_cost(_) -> [].")

data_build.extend(auto_build_cost_list)

gen_erl(build_erl, data_build)
