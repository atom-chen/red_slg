#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
飞艇配置表
@author: ZhaoMing
@deprecated: 2015年01月21日
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"airship")

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

ArgsIndex = """
    k,v,note
    """
DailogIndex   = """
    dailID
    ,dail_1
    ,dail_2
    ,dail_3
    ,dail_4
    ,coin
    ,gold
    ,items
    """
UnionShipUpIndex   = """
    index
    ,name
    ,cost_union_point
    ,cost_union_items
    ,shipAttr
    ,baseAssets
    """
AtkIndex  = """
    atkRate
    ,disLev
    """

RobotIndex = """
    roleLev
    ,ShipType
    ,weight
    ,uid
    ,name
    ,heroLev
    ,heroStar
    ,heroQuality
    ,minAssets
    ,maxAssets
"""

ArgsField        = Field('ArgsField'        , ArgsIndex)
DailogField      = Field('DailogField'      , DailogIndex)
UnionShipUpField = Field('UnionShipUpField' , UnionShipUpIndex)
AtkField         = Field('AtkField'         , AtkIndex)
RobotField       = Field('RobotField'       , RobotIndex)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

ship_erl = "data_ship"
data_airship = module_header(ur"飞艇配置", ship_erl, "zm", "airship.xlsx", "data_airship.py")

export = []
export.append("""
-export([
         dail_reward/1
         ,all_dail/0
         ,max_ship_lev/2
         ,ship_up_cost/3
         ,ship_attr/3
         ,ship_drop_id/2
         ,atk_rate/0
         ,all_ship_key/0
         ,base_assets/2
         ,ship_type_assets_rate/1
         ,group_assets_rate/1
         ,buy_bomb_cost/1
         ,robot_all_role_lev/0
         ,robot_ship_type/1
         ,robot_ship_hero/1
         ,robot_ship_assets/1
         ,robot_name/1
         ,robot_weight_list/1
         ,min_role_lev/1
        ]).
""")

arg_list = []

@load_sheel(work_book, ur"参数配置")
def get_args(content):
    k = str(content[ArgsField.k])
    v = int(content[ArgsField.v])
    note = str(content[ArgsField.note])
    arg_list.append("%s() -> %d. %%%% %s"%(k, v, note))
    export.append("-export([%s/0])."%(k))
    return []
get_args()
data_airship.extend(export)
data_airship.extend(arg_list)

min_role_lev = []
@load_sheel(work_book, ur"飞艇护送角色等级")
def get_min_role_lev(content):
    ship_type = int(content[0])
    min_lev = int(content[1])
    min_role_lev.append("min_role_lev(%d) -> %d;"%(ship_type, min_lev))
    return []

get_min_role_lev()
min_role_lev.append("min_role_lev(_) -> 1000.")

data_airship.extend(min_role_lev)

all_dail_list = []
dail_reward = []
@load_sheel(work_book, ur"随机对话奖励")
def get_rand_dialog(content):
    id = int(content[DailogField.dailID])
    coin = int(get_value(content[DailogField.coin], 0))
    gold = int(get_value(content[DailogField.gold], 0))
    items = str(get_value(content[DailogField.items], ''))
    all_dail_list.append("%d"%(id))
    dail_reward.append("dail_reward(%d) -> [{add_coin, %d}, {add_gold, %d}, {add_items, [%s]}];"%(id, coin, gold, items))
    return []
get_rand_dialog()
dail_reward.append("dail_reward(_) -> [].")
data_airship.extend(dail_reward)
data_airship.append("all_dail() -> [%s]."%(",".join(all_dail_list)))

max_ship_lev = {}
ship_up_cost = []
ship_attr = []
ship_attr.append("%% @spec ship_attr(ShipType::int(), ShipPos::int(), ShipLev::int()) -> list()")
all_ship_key = []
base_assets_list = []
base_assets_list.append("%% @spec base_assets(ShipType::int(), ShipLev::int()) -> float()")

@load_sheel(work_book, ur"公会飞艇升级配置")
def get_union_ship(content):
    index = int(content[UnionShipUpField.index])
    shipType = index / 10000
    shipPos = (index % 10000) / 100
    shipLev = index % 100
    cost_union_point = int(content[UnionShipUpField.cost_union_point])
    cost_union_items = str(get_value(content[UnionShipUpField.cost_union_items], ''))
    shipAttr = str(get_value(content[UnionShipUpField.shipAttr], ''))
    old_lev = max_ship_lev.get("%d, %d"%(shipType, shipPos), 0)
    if shipPos == 0:
        baseAssets = int(content[UnionShipUpField.baseAssets])
        base_assets_list.append("base_assets(%d, %d) -> %f;"%(shipType, shipLev, baseAssets / 1000000.0))
    if shipLev >= old_lev:
        max_ship_lev["%d, %d"%(shipType, shipPos)] = shipLev
    ship_up_cost.append("ship_up_cost(%d, %d, %d) -> {%d, [%s]};"%(shipType, shipPos, shipLev, cost_union_point, cost_union_items))
    ship_attr.append("ship_attr(%d, %d, %d) -> [%s];"%(shipType, shipPos, shipLev, shipAttr))
    all_ship_key.append("{%d, %d}"%(shipType, shipPos))
    return []
get_union_ship()

max_ship_lev_list = []
for key in max_ship_lev.keys():
    max_ship_lev_list.append("max_ship_lev(%s) -> %d;"%(key, max_ship_lev[key]))
max_ship_lev_list.append("max_ship_lev(_, _) -> 1.")
ship_up_cost.append("ship_up_cost(_, _, _) -> {100000, []}.")
ship_attr.append("ship_attr(_, _, _) -> [].")
base_assets_list.append("base_assets(_, _) -> 0.")

data_airship.extend(max_ship_lev_list)
data_airship.extend(ship_up_cost)
data_airship.extend(ship_attr)
data_airship.extend(base_assets_list)
data_airship.append("all_ship_key() -> [%s]."%(",".join(unique_list(all_ship_key))))


ship_drop_id = []
@load_sheel(work_book, ur"飞艇掉落包配置")
def get_drop_id(content):
    shipType = int(content[0])
    shipLev = int(content[1])
    dropID = get_str(content[2], '')
    ship_drop_id.append("ship_drop_id(%d, %d) -> [%s];"%(shipType, shipLev, dropID))
    return []
get_drop_id()
ship_drop_id.append("ship_drop_id(_, _) -> [].")



data_airship.extend(ship_drop_id)

atk_rate_list = []
@load_sheel(work_book, ur"掠夺概率配置")
def get_atk_rate(content):
    atkRate = int(content[AtkField.atkRate])
    disLev = int(content[AtkField.disLev])
    atk_rate_list.append("{%d, 1, %d}"%(disLev, atkRate))
    return []
get_atk_rate()
data_airship.append("atk_rate() -> [%s]."%(",".join(atk_rate_list)))

ship_type_assets_rate_list = []
@load_sheel(work_book, ur"飞艇类型收益系数")
def get_ship_type_assets_rate(content):
    shipType = int(content[0])
    rate = int(content[1])
    ship_type_assets_rate_list.append("ship_type_assets_rate(%d) -> %f;"%(shipType, rate/1000000.0))
    return []
get_ship_type_assets_rate()
ship_type_assets_rate_list.append("ship_type_assets_rate(_) -> 0.")
data_airship.extend(ship_type_assets_rate_list)

group_assets_rate_list = []
@load_sheel(work_book, ur"队友人数收益系数")
def get_group_assets_rate(content):
    groupMemberNum = int(content[0])
    rate = int(content[1])
    group_assets_rate_list.append("group_assets_rate({0}) -> {1};".format(groupMemberNum, rate/100))
    return []

get_group_assets_rate()
group_assets_rate_list.append("group_assets_rate(_) -> 0.")
data_airship.extend(group_assets_rate_list)

buy_bomb = []
@load_sheel(work_book, ur"炮弹购买")
def get_buy_bomb(content):
    nth = int(content[0])
    gold = int(content[1])
    buy_bomb.append("buy_bomb_cost(%d) -> [{del_gold, %d}];"%(nth, gold))
    return []
get_buy_bomb()
buy_bomb.append("buy_bomb_cost(_) -> [{del_gold, 10000}].")

data_airship.extend(buy_bomb)


robot_weight = {}
robot_ship_type = []
robot_ship_hero = []
robot_ship_assets = []
robot_name = []
@load_sheel(work_book, ur"机器人配置")
def get_robot(content, all_content, row):
    roleLev = int(prev(all_content, row, RobotField.roleLev))
    shipType = int(content[RobotField.ShipType])
    weight = int(content[RobotField.weight])
    uid = int(content[RobotField.uid])
    heroLev = int(content[RobotField.heroLev])
    heroStar = int(content[RobotField.heroStar])
    heroQuality = int(content[RobotField.heroQuality])
    minAssets = int(content[RobotField.minAssets])
    maxAssets = int(content[RobotField.maxAssets])
    name = str(content[RobotField.name])
    robot_weight.setdefault(roleLev, [])
    robot_weight[roleLev].append("{%d, %d, %d}"%(uid, shipType, weight))
    robot_ship_type.append("robot_ship_type(%d) -> %d;"%(uid, shipType))
    robot_ship_hero.append("robot_ship_hero(%d) -> {%d, %d, %d};"%(uid, heroLev, heroStar, heroQuality))
    robot_ship_assets.append("robot_ship_assets(%d) -> {%d, %d};"%(uid, minAssets, maxAssets))
    robot_name.append("robot_name(%d) -> <<\"%s\">>;"%(uid, name))
    return []

get_robot()
robot_ship_type.append("robot_ship_type(_) -> 1.")
robot_ship_hero.append("robot_ship_hero(_) -> {1, 1, 1}.")
robot_ship_assets.append("robot_ship_assets(_) -> {0, 1}.")
robot_name.append("robot_name(_) -> <<>>.")

robot_role_lev = []
for i in robot_weight:
    data_airship.append("robot_weight_list(%d) -> [%s];"%(i, ",".join(robot_weight[i])))
    robot_role_lev.append("%d"%(i))
data_airship.append("robot_weight_list(_) -> [].")

data_airship.append("robot_all_role_lev() -> [%s]."%(",".join(robot_role_lev)))

data_airship.extend(robot_ship_type)
data_airship.extend(robot_ship_hero)
data_airship.extend(robot_ship_assets)
data_airship.extend(robot_name)

gen_erl(ship_erl, data_airship)
