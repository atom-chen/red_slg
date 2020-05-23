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
work_book = load_excel(ur"hero_inst")

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

HeroGetIndex = """
    id, heroLev, name, preCondition, itemList, tips, coin, getExp, autoObtianHeroList, heroBuildCondition, attr
"""

SubItemIndex = """
    heroID, name, icon, 
    sub_1_name, sub_2_name, sub_3_name, sub_4_name,
    factor_1, factor_2, factor_3, factor_4
"""

LevAttrIndex = """
    lev, attr_1, attr_2, attr_3, attr_4 
"""

ViewIndex = """
    id, card, open, class, position, direction, ForceFactor
"""

HeroGetField    = Field('HeroGetField'    , HeroGetIndex)
SubItemField    = Field('SubItemField'    , SubItemIndex)
LevAttrField    = Field('LevAttrField'    , LevAttrIndex)
ViewField       = Field('ViewField'       , ViewIndex)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

hero_inst_erl = "data_hero_inst"
data_hero_inst = module_header(ur"研究院配置", hero_inst_erl, "zm", "hero_inst.xlsx", "data_hero_inst.py")

data_hero_inst.append("""
-include("hero_attr.hrl").

-export([
         max_lev/1,
         hero_get_condition/2,
         hero_up_lev_cost/2,
         get_factor/2,
         get_attr_value/2,
         get_attr_type/2,
         is_valid_subitem/2,
         all_hero_list/0,
         all_sub_id_list/1,
         buy_gain_loss_list/1,
         up_add_exp/2,
         auto_obtain_hero_list/2,
         add_hero_num_cost/2,
         add_hero_max_num_cost/2,
         max_max_num/1,
         add_hero_max_num_need_hero_lev/2,
         power_percent/1,
         hero_build_condition/2,
         get_hero_attr_list/2
        ]).
""")

max_lev_dict = {}

hero_get_condition_list = []
hero_get_condition_list.append("""
%% @doc 英雄获得前置条件
%% @spec hero_get_condition(HeroID::int(), HeroLev::int()) -> list() """)

hero_up_lev_cost_list = []
hero_up_lev_cost_list.append("""
%% @doc 英雄升级消耗
%% hero_up_lev_cost(HeroID::int(), HeroLev::int()) -> list() """) 

all_hero_list = []

up_add_exp_list = []
up_add_exp_list.append("""
%% @doc 升级研究院加经验
%% @spec up_add_exp(HeroID::int(), HeroLev::int()) -> list() """)

auto_obtain_hero_list = []
auto_obtain_hero_list.append("""
%% @doc 自动获得英雄列表
%% @spec auto_obtain_hero_list(HeroID::int(), HeroLev::int()) -> HeroIDList::list() """)


hero_build_condition_list = []
hero_build_condition_list.append("""
%% @doc 前置建筑等级
%% @spec hero_build_condition(HeroID::int(), HeroLev::int()) -> list() """)

hero_attr_list = []
hero_attr_list.append("""
%% @doc 英雄每级属性
%% @spec get_hero_attr_list(HeroID::int(), HeroLev::int()) -> list()""")

@load_sheel(work_book, ur"英雄获得配置")
def get_hero_get(content):
    hero_id = int(content[HeroGetField.id])
    hero_lev = int(content[HeroGetField.heroLev])
    condition = get_str(content[HeroGetField.preCondition], '')
    item_list = get_str(content[HeroGetField.itemList], '')
    coin = int(get_value(content[HeroGetField.coin], 0))
    add_exp = int(get_value(content[HeroGetField.getExp], 0))
    obtain_hero_list = get_str(content[HeroGetField.autoObtianHeroList], '')
    hero_build_condition = get_str(content[HeroGetField.heroBuildCondition], '')
    attr_list = get_str(content[HeroGetField.attr], '')

    hero_attr_list.append("get_hero_attr_list(%d, %d) -> [%s];"%(hero_id, hero_lev, attr_list))
    max_lev_dict.setdefault(hero_id, 0)
    if max_lev_dict[hero_id] < hero_lev :
        max_lev_dict[hero_id] = hero_lev

    if condition != '': 
        hero_get_condition_list.append("hero_get_condition(%d, %d) -> [%s];"%(hero_id, hero_lev, condition))
    hero_up_lev_cost_list.append("hero_up_lev_cost(%d, %d) -> [{del_items, [%s]}, {del_coin, %d}, {loss_inst_point, 0}];"%(hero_id, hero_lev, item_list, coin))
    up_add_exp_list.append("up_add_exp(%d, %d) -> [{add_exp, %d}];"%(hero_id, hero_lev, add_exp))
    all_hero_list.append("%d"%(hero_id))

    if hero_build_condition != '':
        hero_build_condition_list.append("hero_build_condition(%d, %d) -> [%s];"%(hero_id, hero_lev, hero_build_condition))

    if obtain_hero_list != '': 
        auto_obtain_hero_list.append("auto_obtain_hero_list(HeroID, HeroLev) when HeroID =:= %d, HeroLev =:= %d -> [%s];"%(hero_id, hero_lev, obtain_hero_list))
    return []

get_hero_get()
hero_get_condition_list.append("hero_get_condition(_, _) -> [].")
hero_up_lev_cost_list.append("hero_up_lev_cost(_, _) -> [].")
up_add_exp_list.append("up_add_exp(_, _) -> [].")
auto_obtain_hero_list.append("auto_obtain_hero_list(_, _) -> [].")
hero_build_condition_list.append("hero_build_condition(_, _) -> [].")
hero_attr_list.append("get_hero_attr_list(_, _) -> [].")

data_hero_inst.append("""
%% @doc 所有可研究的英雄
%% @spec all_hero_list/0
all_hero_list() -> [%s].  """%(",".join(unique_list(all_hero_list))))

data_hero_inst.append("""
%% @doc 最大等级
%% @spec max_lev(heroID::int()) -> Lev::int() """)
for i in max_lev_dict:
    data_hero_inst.append("max_lev(%d) -> %d;"%(i, max_lev_dict[i]))
data_hero_inst.append("max_lev(_) -> 0.")

data_hero_inst.extend(hero_get_condition_list)
data_hero_inst.extend(hero_up_lev_cost_list)
data_hero_inst.extend(up_add_exp_list)
data_hero_inst.extend(auto_obtain_hero_list)
data_hero_inst.extend(hero_build_condition_list)
data_hero_inst.extend(hero_attr_list)


get_factor_list = []
get_factor_list.append("""
%% @doc 子项目系数
%% @spec get_factor(HeroID::int(), SubID::int()) -> float() """)

is_valid_subitem_list = []
is_valid_subitem_list.append("""
%% @doc 是否是有效的子项目
%% @spec is_valid_subitem(HeroID::int(), SubID::int()) -> false|true """)

all_subitem_list = []
all_subitem_list.append("""
%% @doc 所有的子项目列表
%% @spec all_sub_id_list(HeroID::int()) -> [SubID::int()]
all_sub_id_list(_HeroID) -> [1, 2, 3, 4].  """)

data_hero_inst.extend(all_subitem_list)

@load_sheel(work_book, ur"子项目&属性系数")
def get_attr_factor(content):
    hero_id = int(content[SubItemField.heroID])
    factor_1 = int(get_value(content[SubItemField.factor_1], 0))
    factor_2 = int(get_value(content[SubItemField.factor_2], 0))
    factor_3 = int(get_value(content[SubItemField.factor_3], 0))
    factor_4 = int(get_value(content[SubItemField.factor_4], 0))
    get_factor_list.append("get_factor(%d, 1) -> %d/10000;"%(hero_id, factor_1))
    get_factor_list.append("get_factor(%d, 2) -> %d/10000;"%(hero_id, factor_2))
    get_factor_list.append("get_factor(%d, 3) -> %d/10000;"%(hero_id, factor_3))
    get_factor_list.append("get_factor(%d, 4) -> %d/10000;"%(hero_id, factor_4))
    if factor_1 != 0:
        is_valid_subitem_list.append("is_valid_subitem(%d, 1) -> true;"%(hero_id))
    if factor_2 != 0:
        is_valid_subitem_list.append("is_valid_subitem(%d, 2) -> true;"%(hero_id))
    if factor_3 != 0:
        is_valid_subitem_list.append("is_valid_subitem(%d, 3) -> true;"%(hero_id))
    if factor_4 != 0:
        is_valid_subitem_list.append("is_valid_subitem(%d, 4) -> true;"%(hero_id))
    return []

get_attr_factor()

get_factor_list.append("get_factor(_, _) -> 0.")
is_valid_subitem_list.append("is_valid_subitem(_, _) -> false.")

data_hero_inst.extend(get_factor_list)
data_hero_inst.extend(is_valid_subitem_list)



get_attr_value_list = []
get_attr_value_list.append("""
%% @doc 属性值
%% @spec get_attr_value(HeroLev::int()) -> AttrValue::int() """)

@load_sheel(work_book, ur"等级属性")
def get_lev_attr(content):
    global max_lev
    lev = int(content[LevAttrField.lev])
    attr_1 = int(get_value(content[LevAttrField.attr_1], 0))
    attr_2 = int(get_value(content[LevAttrField.attr_2], 0))
    attr_3 = int(get_value(content[LevAttrField.attr_3], 0))
    attr_4 = int(get_value(content[LevAttrField.attr_4], 0))
    get_attr_value_list.append("get_attr_value(%d, 1) -> %d;"%(lev, attr_1))
    get_attr_value_list.append("get_attr_value(%d, 2) -> %d;"%(lev, attr_2))
    get_attr_value_list.append("get_attr_value(%d, 3) -> %d;"%(lev, attr_3))
    get_attr_value_list.append("get_attr_value(%d, 4) -> %d;"%(lev, attr_4))
    return []

get_lev_attr()

get_attr_value_list.append("get_attr_value(_, _) -> 0.")
data_hero_inst.extend(get_attr_value_list)

buy_gain_loss_list = []
buy_gain_loss_list.append("""
%% 购买研究院点数获得消耗
%% buy_gain_loss_list(Nth::int()) -> list() """)
@load_sheel(work_book, ur"点数购买")
def get_buy_cost(content):
    nth = int(content[0])
    gold = int(content[1])
    point = int(get_value(content[2], 10))
    buy_gain_loss_list.append("buy_gain_loss_list(%d) -> [{del_gold, %d}, {add_inst_point, %d}];"%(nth, gold, point))
    return []
get_buy_cost()
buy_gain_loss_list.append("buy_gain_loss_list(_) -> [].")
data_hero_inst.extend(buy_gain_loss_list)

data_hero_inst.append("""
%% @doc 根据子项目获得属性类型
%% @spec get_attr_type(HeroID::int(), SubID::int()) -> AttrType::int()
get_attr_type(_HeroID, 1) -> ?MAIN_ATK;
get_attr_type(_HeroID, 2) -> ?MINOR_ATK;
get_attr_type(_HeroID, 3) -> ?HP;
get_attr_type(_HeroID, 4) -> ?DEFENCE;
get_attr_type(_, _) -> 0.
""")

add_hero_num_cost_list = []
add_hero_num_cost_list.append("""
%% @doc 英雄生产消耗
%% @spec add_hero_num_cost(HeroID::int(), Nth::int()) -> list() """)

@load_sheel(work_book, ur"英雄生产")
def get_add_hero_num(content):
    hero_id = int(content[0])
    nth_num = int(content[2])
    items = get_str(content[3], '')
    add_hero_num_cost_list.append("add_hero_num_cost(HeroID, NthNum) when HeroID =:= %d, NthNum =:= %d -> [{del_items, [%s]}];"%(hero_id, nth_num, items))
    return []

get_add_hero_num()
add_hero_num_cost_list.append("add_hero_num_cost(_, _) -> [].")
data_hero_inst.extend(add_hero_num_cost_list)


max_max_num = {}

add_hero_max_num_cost_list = []
add_hero_max_num_cost_list.append("""
%% @doc 编制扩充消耗
%% @spec add_hero_max_num_cost(HeroID::int(), MaxNum::int()) -> list() """)

add_hero_max_num_need_role_lev_list = []
add_hero_max_num_need_role_lev_list.append("""
%% @doc 编制扩充需要英雄等级
%% @spec add_hero_max_num_need_hero_lev(HeroID::int(), MaxNum::int()) -> HeroLev::int() """)

@load_sheel(work_book, ur"英雄编制扩充")
def get_add_hero_max_num(content):
    hero_id = int(content[0])
    max_num = int(content[2])
    items = get_str(content[3], '')
    hero_lev = int(get_value(content[4], 0))

    max_max_num.setdefault(hero_id, 0)

    if max_max_num[hero_id] < max_num:
        max_max_num[hero_id] = max_num

    add_hero_max_num_cost_list.append("add_hero_max_num_cost(HeroID, MaxNum) when HeroID =:= %d, MaxNum =:= %d -> [{del_items, [%s]}];"%(hero_id, max_num, items))

    add_hero_max_num_need_role_lev_list.append("add_hero_max_num_need_hero_lev(HeroID, MaxNum) when HeroID =:= %d, MaxNum =:= %d -> %d;"%(hero_id, max_num, hero_lev))
    return []

get_add_hero_max_num()

add_hero_max_num_cost_list.append("add_hero_max_num_cost(_, _) -> [].")
add_hero_max_num_need_role_lev_list.append("add_hero_max_num_need_hero_lev(_, _) -> 0.")

data_hero_inst.extend(add_hero_max_num_cost_list)
data_hero_inst.extend(add_hero_max_num_need_role_lev_list)

data_hero_inst.append("""
%% @doc 最大编制扩充
%% @spec max_max_num(heroID::int()) -> int() """)
for i in max_max_num:
    data_hero_inst.append("max_max_num(%d) -> %d;"%(i, max_max_num[i]))
data_hero_inst.append("max_max_num(_) -> 0.")

power_percent_list = []
power_percent_list.append("""
%% @doc 战力系数
%% @spec power_percent(HeroID :: int()) -> number() """)
@load_sheel(work_book, ur"英雄界面")
def get_view(content):
    hero_id = int(content[ViewField.id])
    power_percent = int(content[ViewField.ForceFactor])
    power_percent_list.append("power_percent(HeroID) when HeroID =:= %d -> %f;"%(hero_id, power_percent / 100.0))
    return []

get_view()

power_percent_list.append("power_percent(_) -> 1.")

data_hero_inst.extend(power_percent_list)

gen_erl(hero_inst_erl, data_hero_inst)
