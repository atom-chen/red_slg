#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
宝物配置
@author: csh
@deprecated: 2015-03-18
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

import time

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"precious")

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
# 宝物基础信息
BaseColumn1 = """
    id
    ,name
    ,hero_id
    ,hero_quality
    ,is_open
    ,main_property
    ,secondary_property_list
    ,star_2
    ,star_3
    ,star_4
    ,star_5
    ,main_value_1
    ,main_value_2
    ,main_value_3
    ,main_value_4
    ,main_value_5
"""

## 宝物升级
BaseColumn2 = """
    lev
    ,exp
"""

## 洗练经验及消耗
BaseColumn3 = """
    star_lev
    ,min_add_exp
    ,max_add_exp
    ,item_list
    ,coin
    ,lock_cost_gold
"""
# 洗练属性
BaseColumn4 = """
    secondary_property_id
    ,lev
    ,white_area
    ,green_area
    ,blue_area
    ,purple_area
    ,orange_area
"""

# 属性定义
# BaseColumn5 = """
    # id
    # ,type
    # ,name
# """


## 宝物基础信息
class FieldClassBase1:
    def __init__(self):
        enum(FieldClassBase1, BaseColumn1)

## 宝物升级
class FieldClassBase2:
    def __init__(self):
        enum(FieldClassBase2, BaseColumn2)

## 洗练经验及消耗
class FieldClassBase3:
    def __init__(self):
        enum(FieldClassBase3, BaseColumn3)

# 洗练属性
class FieldClassBase4:
    def __init__(self):
        enum(FieldClassBase4, BaseColumn4)
        
# 属性定义
# class FieldClassBase5:
    # def __init__(self):
        # enum(FieldClassBase5, BaseColumn5)

    
# 生成域枚举           
BaseField1 = FieldClassBase1()

BaseField2 = FieldClassBase2()

BaseField3 = FieldClassBase3()

BaseField4 = FieldClassBase4()

# BaseField5 = FieldClassBase5()


# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

precious_erl = "data_precious"
data_precious = module_header(ur"宝物配置", precious_erl, "csh", "precious.xlsx", "data_precious.py")
data_precious.append("""
-export([
        get_precious_id/1
        ,get_hero_quality_open/2
        ,get_main_property_id/1
        % ,get_secondary_property_id/2
        ,get_nth_secondary_property/2
        ,get_secondary_property_list/1
        ,get_main_property_value/2
        ,get_cost_items_for_up_star/2
        ,get_max_lev/0
        ,get_upgrade_exp/1
        ,get_min_add_exp/1
        ,get_max_add_exp/1
        ,get_wash_item_cost/1
        ,get_wash_coin_cost/1
        ,get_locked_cost/1
        ,get_wash_data/2
        ]).
""")


# 根据英雄ID获取宝物ID
hero_precious_id_list = []
hero_precious_id_list.append("\n\n%% 根据英雄ID获取宝物ID")
hero_precious_id_list.append("%% @spec get_precious_id(hero_id :: int() -> precious_id :: int() | false)")
@load_sheel(work_book, ur"宝物基础信息")
def get_precious_id(content):
    precious_id = int(get_value(content[BaseField1.id], 0))
    hero_id = int(get_value(content[BaseField1.hero_id], 0))
    hero_precious_id_list.append("""get_precious_id({0}) -> {1};""".format(hero_id, precious_id))
    return []
get_precious_id()
hero_precious_id_list.append("get_precious_id(_) -> false.")
data_precious.extend(hero_precious_id_list)

# 根据宝物ID获取品阶要求与是否开放
precious_hero_quality_open = []
precious_hero_quality_open.append("\n\n%% 根据宝物ID获取品阶要求与是否开放")
precious_hero_quality_open.append("%% get_hero_quality_open(precious_id :: int()) -> {hero_quality :: int(), is_open :: int()}")
@load_sheel(work_book, ur"宝物基础信息")
def get_hero_quality_open(content):
    precious_id = int(get_value(content[BaseField1.id], 0))
    hero_id = int(get_value(content[BaseField1.hero_id], 0))
    hero_quality = int(get_value(content[BaseField1.hero_quality], 0))
    is_open = int(get_value(content[BaseField1.is_open], 0))
    precious_hero_quality_open.append("""get_hero_quality_open({0}, {1}) -> {{{2}, {3}}};""".format(precious_id, hero_id, hero_quality, is_open))
    return []
get_hero_quality_open()
precious_hero_quality_open.append("get_hero_quality_open(_, _) -> {999, 0}.")
data_precious.extend(precious_hero_quality_open)

# 根据宝物ID获取第几个副属性
nth_secondary_property_list = []
nth_secondary_property_list.append("\n\n%% 根据宝物ID获取第几个副属性")
nth_secondary_property_list.append("%% spec get_nth_secondary_property(precious_id :: int(), nth :: int()) -> secondary_property_id :: int()")
def get_nth_secondary_property():
    erl_str = """
    case data_precious:get_secondary_property_list(PreciousID) of
        List when is_list(List) -> 
            SeqList = lists:seq(1, length(List)),
            IndexIDList = lists:zip(SeqList, List),
            case Nth > length(IndexIDList) of
                true -> 0;
                false -> 
                    {_Index, ID} = lists:nth(Nth, IndexIDList),
                    ID
            end;
        _-> 0
    end"""
    nth_secondary_property_list.append("""get_nth_secondary_property(PreciousID, Nth) -> {0}.""".format(erl_str))
    return []
get_nth_secondary_property()
data_precious.extend(nth_secondary_property_list)


# 根据宝物ID获取宝物主属性
main_property_id_list = []
main_property_id_list.append("\n\n%% 根据宝物ID获取宝物主属性")
main_property_id_list.append("%% @spec get_main_property_id(precious_id :: int()) -> main_property :: int()")
# new_open_secondary_property = []
# new_open_secondary_property.append("\n\n%% 根据宝物ID和魂级获取新开启的副属性ID")
# new_open_secondary_property.append("%% @spec get_secondary_property_id(precious_id :: int(), star :: int()) -> secondary_property_id :: int()")
secondary_property_data_list = []
secondary_property_data_list.append("\n\n%% 根据宝物ID获取该宝物所有的副属性列表")
secondary_property_data_list.append("%% @spec get_secondary_property_list(precious_id :: int()) -> secondary_property_list :: int()")
@load_sheel(work_book, ur"宝物基础信息")
def get_main_property_id(content):
    precious_id = int(get_value(content[BaseField1.id], 0))
    main_property = int(get_value(content[BaseField1.main_property], 0))
    secondary_property_list = str(get_value(content[BaseField1.secondary_property_list], ''))
    main_property_id_list.append("""get_main_property_id({0}) -> {1};""".format(precious_id, main_property))
    # new_open_secondary_property.append("""get_secondary_property_id({0}, X) -> lists:nth(X, [{1}]);""".format(precious_id, secondary_property_list))
    secondary_property_data_list.append("""get_secondary_property_list({0}) -> [{1}];""".format(precious_id, secondary_property_list))
    return []
get_main_property_id()
main_property_id_list.append("get_main_property_id(_) -> false.")
# new_open_secondary_property.append("get_secondary_property_id(_, _) -> false.")
secondary_property_data_list.append("get_secondary_property_list(_) -> false.")
data_precious.extend(main_property_id_list)
# data_precious.extend(new_open_secondary_property)
data_precious.extend(secondary_property_data_list)

# 用宝物ID和魂级获取主属性值
main_property_value_list = []
main_property_value_list.append("\n\n%% 用宝物ID和魂级获取主属性值")
main_property_value_list.append("%% @spec get_main_property_value(precious_id :: int(), star :: int()) -> property_value :: int() |false")
# 用宝物ID和魂级获取升级所需材料
up_star_cost_items_list = []
up_star_cost_items_list.append("\n\n%% 用宝物ID和魂级获取升级所需材料")
up_star_cost_items_list.append("%% @spec get_cost_items_for_up_star(precious_id :: int(), star :: int()) -> item_list :: lists | false")
@load_sheel(work_book, ur"宝物基础信息")
def get_main_property_value(content):
    precious_id = int(get_value(content[BaseField1.id], 0))
    main_value_1 = int(get_value(content[BaseField1.main_value_1], 0))
    main_value_2 = int(get_value(content[BaseField1.main_value_2], 0))
    main_value_3 = int(get_value(content[BaseField1.main_value_3], 0))
    main_value_4 = int(get_value(content[BaseField1.main_value_4], 0))
    main_value_5 = int(get_value(content[BaseField1.main_value_5], 0))
    star_2 = str(get_value(content[BaseField1.star_2], ''))
    star_3 = str(get_value(content[BaseField1.star_3], ''))
    star_4 = str(get_value(content[BaseField1.star_4], ''))
    star_5 = str(get_value(content[BaseField1.star_5], ''))
    if main_value_1 != 0 :
        main_property_value_list.append("""get_main_property_value({0}, 1) -> {1};""".format(precious_id, main_value_1))
    if main_value_2 != 0 :
        main_property_value_list.append("""get_main_property_value({0}, 2) -> {1};""".format(precious_id, main_value_2))
    if main_value_3 != 0 :
        main_property_value_list.append("""get_main_property_value({0}, 3) -> {1};""".format(precious_id, main_value_3))
    if main_value_4 != 0 :
        main_property_value_list.append("""get_main_property_value({0}, 4) -> {1};""".format(precious_id, main_value_4))
    if main_value_5 != 0 :
        main_property_value_list.append("""get_main_property_value({0}, 5) -> {1};""".format(precious_id, main_value_5))
    if star_2 != '' :
        up_star_cost_items_list.append("""get_cost_items_for_up_star({0}, 2) -> [{1}];""".format(precious_id, star_2))    
    if star_3 != '' :
        up_star_cost_items_list.append("""get_cost_items_for_up_star({0}, 3) -> [{1}];""".format(precious_id, star_3))
    if star_4 != '' :
        up_star_cost_items_list.append("""get_cost_items_for_up_star({0}, 4) -> [{1}];""".format(precious_id, star_4))
    if star_5 != '' :
        up_star_cost_items_list.append("""get_cost_items_for_up_star({0}, 5) -> [{1}];""".format(precious_id, star_5))
    return []
get_main_property_value()
main_property_value_list.append("get_main_property_value(_, _) -> false.")
up_star_cost_items_list.append("get_cost_items_for_up_star(_, _) -> [].")
data_precious.extend(main_property_value_list)
data_precious.extend(up_star_cost_items_list)
       
# 将宝物升级表导入list
precious_upgrade_data_list = []
lev_data_list = []
@load_sheel(work_book, ur"宝物升级")
def load_upgrade_to_list(content):
    temp = []
    lev = int(get_value(content[BaseField2.lev], 0))
    exp = int(get_value(content[BaseField2.exp], 0))
    temp.append(lev)
    temp.append(exp)
    precious_upgrade_data_list.append(temp)
    lev_data_list.append(lev)
    return []
load_upgrade_to_list()

# 获取最大等级
max_lev_list = []
max_lev_list.append("\n\n%% 获取最大等级")
max_lev_list.append("%% @spec get_max_lev() -> max_lev :: int()")
def get_max_lev():
    max_lev_list.append("""get_max_lev() -> {0}.""".format(max(lev_data_list)))
    return []
get_max_lev()
data_precious.extend(max_lev_list)

# 获取升级所需经验值
upgrade_exp_list = []
upgrade_exp_list.append("\n\n%% 获取升级所需经验值")
upgrade_exp_list.append("%% @spec get_upgrade_exp(lev :: int()) -> exp :: int()")
def get_upgrade_exp():
    row = 0
    while row < len(precious_upgrade_data_list):
        if row == 0 :
            upgrade_exp_list.append("""get_upgrade_exp({0}) -> {1};""".format(precious_upgrade_data_list[row][0], 0))
        else :
            upgrade_exp_list.append("""get_upgrade_exp({0}) -> {1};""".
                        format(precious_upgrade_data_list[row][0], precious_upgrade_data_list[row - 1][1]))
        row = row + 1
    return []
get_upgrade_exp()
upgrade_exp_list.append("get_upgrade_exp(_) -> false.")
data_precious.extend(upgrade_exp_list)
      
# 组装字符串
def pack_item_list(items_list, coin):
    result = ''
    if items_list.strip() != '' :
        result = result + '{del_items, [' + items_list + ']}'
    if coin != 0 :
        if len(result) > 0 :
            result = result + ', '
        result = result + '{del_coin, ' + str(coin) + '}'
    return result
      
# 获取副属性洗练宝物增加的最小经验
wash_min_add_exp_list = []
wash_min_add_exp_list.append("\n\n%% 获取副属性洗练宝物增加的最小经验")
wash_min_add_exp_list.append("%% @spec get_min_add_exp(star_lev :: int()) -> min_add_exp :: int()")
# 获取副属性洗练宝物增加的最大经验
wash_max_add_exp_list = []
wash_max_add_exp_list.append("\n\n%% 获取副属性洗练宝物增加的最大经验")
wash_max_add_exp_list.append("%% @spec get_max_add_exp(star_lev :: int()) -> max_add_exp :: int()")
# 获取洗练的物品消耗
wash_cost_item_list = []
wash_cost_item_list.append("\n\n%% 获取洗练的物品消耗")
wash_cost_item_list.append("%% @spec get_wash_item_cost(star_lev :: int()) -> list :: lists()")
# 获取洗练的物品消耗
wash_cost_coin_list = []
wash_cost_coin_list.append("\n\n%% 获取洗练的金币消耗")
wash_cost_coin_list.append("%% @spec get_wash_coin_cost(star_lev :: int()) -> coin_amount :: lists()")
# 获取已加锁的属性洗练时扣除的钻石
wash_locked_cost_list = []
wash_locked_cost_list.append("\n\n%% 获取已加锁的属性洗练时扣除的钻石")
wash_locked_cost_list.append("%% @spec get_locked_cost(star_lev :: int()) -> cost_gold :: int()")
@load_sheel(work_book,ur"洗练经验及消耗")
def get_data(content):
    star_lev = int(get_value(content[BaseField3.star_lev], 0))
    min_add_exp = int(get_value(content[BaseField3.min_add_exp], 0))
    max_add_exp = int(get_value(content[BaseField3.max_add_exp], 0))
    item_list = str(get_value(content[BaseField3.item_list], 0))
    coin = int(get_value(content[BaseField3.coin], 0))
    lock_cost_gold = int(get_value(content[BaseField3.lock_cost_gold], 0))
    wash_min_add_exp_list.append("""get_min_add_exp({0}) -> {1};""".format(star_lev, min_add_exp))
    wash_max_add_exp_list.append("""get_max_add_exp({0}) -> {1};""".format(star_lev, max_add_exp))
    wash_cost_item_list.append("""get_wash_item_cost({0}) -> [{1}];""".format(star_lev, item_list))
    wash_cost_coin_list.append("""get_wash_coin_cost({0}) -> {1};""".format(star_lev, coin))
    wash_locked_cost_list.append("""get_locked_cost({0}) -> {1};""".format(star_lev, lock_cost_gold))
    return []
get_data()
wash_min_add_exp_list.append("get_min_add_exp(_) -> 0.")
wash_max_add_exp_list.append("get_max_add_exp(_) -> 0.")
wash_cost_item_list.append("get_wash_item_cost(_) -> false.")
wash_cost_coin_list.append("get_wash_coin_cost(_) -> false.")
wash_locked_cost_list.append("get_locked_cost(_) -> 0.")
data_precious.extend(wash_min_add_exp_list)
data_precious.extend(wash_max_add_exp_list)
data_precious.extend(wash_cost_item_list)
data_precious.extend(wash_cost_coin_list)
data_precious.extend(wash_locked_cost_list)
       
# 根据副属性ID和宝物等级获取洗练数据
property_wash_data_list = []
property_wash_data_list.append("\n\n%% 根据副属性ID和宝物等级获取洗练数据")
property_wash_data_list.append("%% @spec get_wash_data(property_id :: int(), lev :: int()) -> data :: lists")
@load_sheel(work_book, ur"洗练属性")
def get_wash_data(content):
    temp_list = []
    secondary_property_id = int(get_value(content[BaseField4.secondary_property_id], 0))
    lev = int(get_value(content[BaseField4.lev], 0))
    white_area = str(get_value(content[BaseField4.white_area], ''))
    green_area = str(get_value(content[BaseField4.green_area], ''))
    blue_area = str(get_value(content[BaseField4.blue_area], ''))
    purple_area = str(get_value(content[BaseField4.purple_area], ''))
    orange_area = str(get_value(content[BaseField4.orange_area], ''))
    temp_list.append("""{0}, {1}, {2}, {3}, {4}""".format(white_area, green_area, blue_area, purple_area, orange_area))
    property_wash_data_list.append("""get_wash_data({0}, {1}) -> {2};""".format(secondary_property_id, lev, '[' + ', '.join(temp_list) + ']'))
    return []
get_wash_data()
property_wash_data_list.append("get_wash_data(_, _) -> [].")
data_precious.extend(property_wash_data_list)



gen_erl(precious_erl, data_precious)
