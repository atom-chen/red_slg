#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
宝箱配置
@author: csh
@deprecated: 2014-07-21
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

import time

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"chest")

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
## 图纸装备宝箱抽取内容
BaseColumn = """
    award_id
    ,extract_type
    ,item_id
    ,min_count
    ,max_count
    ,award_type
    ,rate
    ,min_times
"""

## 抽取类型奖励类型次数
BaseColumn1 = """
    extract_type
    ,award_type
    ,min_count
    ,max_count
"""

#  针对第一次抽宝箱做特殊处理，固定产出
BaseColumn3 = """
    extract_type
    ,item_hero_id
    ,count
    ,times
"""

# 钻石消耗
BaseColumn4 = """
    extract_type
    ,extract_type_1
    ,gold_cost
"""

class FieldClassBase:
    def __init__(self):
        enum(FieldClassBase, BaseColumn)

## 抽取类型奖励类型次数
class FieldClassBase1:
    def __init__(self):
        enum(FieldClassBase1, BaseColumn1)

## 针对第一次抽宝箱做特殊处理，固定产出
class FieldClassBase3:
    def __init__(self):
        enum(FieldClassBase3, BaseColumn3)

# 钻石消耗
class FieldClassBase4:
    def __init__(self):
        enum(FieldClassBase4, BaseColumn4)
        
# 生成域枚举           
BaseField = FieldClassBase()

BaseField1 = FieldClassBase1()

BaseField3 = FieldClassBase3()

BaseField4 = FieldClassBase4()

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

chest_erl = "data_chest"
data_chest = module_header(ur"宝箱配置", chest_erl, "csh", "chest.xlsx", "data_chest.py")
data_chest.append("""
-export([get_award_id_list/2
        ,get_items/1
        ,get_min_times/2
        ,get_max_times/2
        ,get_award_type_list/1
        ,get_item_hero_list_by_first/2
        ,get_times/1
        ,get_gold_cost/2
        ]).
""")


# 获取奖励ID和保底次数list
# get_award_id_list
# 获取全部的抽取类型和奖励类型
extract_type_list = []
award_type_list = []
@load_sheel(work_book, ur"图纸装备宝箱抽取内容")
def get_extract_type_list(content):
    extract_type = int(get_value(content[BaseField.extract_type], 0))
    award_type = int(get_value(content[BaseField.award_type], 0))
    if (extract_type not in extract_type_list) :
        extract_type_list.append(extract_type)
    if (award_type not in award_type_list) :
        award_type_list.append(award_type)
    return []
get_extract_type_list()

sheet1_data = []
temp_chest_base = []
chest_award_id_base = []
chest_award_id_base.append("\n\n%% 根据抽取类型和奖励类型获取奖励ID和保底次数列表")
chest_award_id_base.append("%%@spec get_award_id_list(extract_type :: int(), award_type :: int()) -> [{award_id :: int(), min_times :: int()}] | []")
@load_sheel(work_book, ur"图纸装备宝箱抽取内容")
# 将 sheet1 的数据导入 list
def load_excel_to_list(content):
    temp1 = []
    award_id = int(get_value(content[BaseField.award_id], 0))
    extract_type = int(get_value(content[BaseField.extract_type], 0))
    award_type = int(get_value(content[BaseField.award_type], 0))
    min_times = int(get_value(content[BaseField.min_times], 0))
    temp1.append(award_id)
    temp1.append(extract_type)
    temp1.append(award_type)
    temp1.append(min_times)
    sheet1_data.append(temp1)
    return []
load_excel_to_list()
def get_award_id_list(extract_type1, award_type1):
    row = 0
    while row < len(sheet1_data) :
        if (sheet1_data[row][1] == extract_type1) and (sheet1_data[row][2] == award_type1) :
            temp_chest_base.append("""{{{0}, {1}}}""".format(sheet1_data[row][0], sheet1_data[row][3]))
        row = row + 1
    return []
# 循环执行上面的 get_award_id_list
def do_get_award_id_list():
    for temp_extract in extract_type_list:
        for temp_award in award_type_list :
            get_award_id_list(temp_extract, temp_award)
            if len(temp_chest_base) > 0 :
                chest_award_id_base.append("""get_award_id_list({0}, {1}) -> {2};""".format(temp_extract, temp_award, '[' + ', '.join(temp_chest_base) + ']')) 
                del temp_chest_base[:]
    return []

do_get_award_id_list()            
chest_award_id_base.append("get_award_id_list(_, _) -> [].")
data_chest.extend(chest_award_id_base)


# 获取物品ID，物品最小数量，最大数量，权重
# get_items
chest_items_baes = []
chest_items_baes.append("\n\n%% 根据奖励ID获取物品ID、物品最小数量，最大数量、权重")
chest_items_baes.append("%%@spec get_items(award_id :: int()) -> {item_id :: int(), min_count :: int(), max_count :: int(), rate::int()} | false")
@load_sheel(work_book, ur"图纸装备宝箱抽取内容")
def get_items(content):
    award_id = int(get_value(content[BaseField.award_id], 0))
    item_id = int(get_value(content[BaseField.item_id], 0))
    min_count = int(get_value(content[BaseField.min_count], 0))
    max_count = int(get_value(content[BaseField.max_count], 0))
    rate = int(get_value(content[BaseField.rate] ,0))
    chest_items_baes.append("""get_items({0}) -> {{{1}, {2}, {3}, {4}}};""".format(award_id, item_id, min_count, max_count, rate))
    return []

get_items()
chest_items_baes.append("get_items(_) -> false.")
data_chest.extend(chest_items_baes)


# 获取最小次数
# get_min_times
chest_base = []
chest_base.append("\n\n%% 根据抽取类型ID和奖励类型ID获取最大出现次数")
chest_base.append("%% @spec get_min_times(extract_type :: int(), award_type :: int()) -> min_count :: int() | false")
@load_sheel(work_book, ur"图纸装备宝箱抽取类型")
def get_min_times(content):
    extract_type = int(get_value(content[BaseField1.extract_type], 0))
    award_type = int(get_value(content[BaseField1.award_type], 0))
    min_count = int(get_value(content[BaseField1.min_count], 0))
    # max_count = int(get_value(content[BaseField1.max_count], 0))
    if (extract_type != 0) and (award_type != 0) :
        chest_base.append("""get_min_times({0}, {1}) -> {2}; """.format(extract_type, award_type, min_count))
    return []

get_min_times()
chest_base.append("get_min_times(_, _) -> false.")
data_chest.extend(chest_base)


# 获取最大次数
# get_max_times
chest_base = []
chest_base.append("\n\n%% 根据抽取类型ID和奖励类型ID获取最大出现次数")
chest_base.append("%% @spec get_max_times(extract_type :: int(), award_type :: int()) -> max_count :: int() | false")
@load_sheel(work_book, ur"图纸装备宝箱抽取类型")
def get_max_times(content):
    extract_type = int(get_value(content[BaseField1.extract_type], 0))
    award_type = int(get_value(content[BaseField1.award_type], 0))
    # min_count = int(get_value(content[BaseField1.min_count], 0))
    max_count = int(get_value(content[BaseField1.max_count], 0))
    if (extract_type != 0) and (award_type != 0) :
        chest_base.append("""get_max_times({0}, {1}) -> {2}; """.format(extract_type, award_type, max_count))
    return []

get_max_times()
chest_base.append("get_max_times(_, _) -> false.")
data_chest.extend(chest_base)


# 获取奖励类型list
# get_award_type_list
temp = -1
temp_base = []
chest_award_type_base = []
chest_award_type_base.append("\n\n%% 根据抽取类型获取奖励类型ID的List")
chest_award_type_base.append("%% @spec get_award_type_list(extract_type :: int()) -> [award_type :: int()] | false")
@load_sheel(work_book, ur"图纸装备宝箱抽取类型")
def get_award_type_list(content):
    global temp
    extract_type = int(get_value(content[BaseField1.extract_type], 0))
    award_type = int(get_value(content[BaseField1.award_type], 0))
    if (temp == -1) :
        temp = extract_type
    if (temp != extract_type) :
        chest_award_type_base.append("""get_award_type_list({0}) -> {1};""".format(temp, temp_base))
        del temp_base[:]
        temp_base.append(award_type)
    else :
        temp_base.append(award_type)
    temp = extract_type
    return []

get_award_type_list()
chest_award_type_base.append("""get_award_type_list({0}) -> {1};""".format(temp,temp_base))
chest_award_type_base.append("get_award_type_list(_) -> false.")
data_chest.extend(chest_award_type_base)


# 将表格转换成list
spec_list = []
extract_type_list1 = []
times_list = []
@load_sheel(work_book, ur"前几次的特殊处理")
def load_spec_excel_to_list(content) :
    temp = []
    extract_type = int(get_value(content[BaseField3.extract_type], 0))
    item_hero_id = int(get_value(content[BaseField3.item_hero_id], 0))
    count = int(get_value(content[BaseField3.count], 0))
    times = int(get_value(content[BaseField3.times], 0))
    temp.append(extract_type)
    temp.append(item_hero_id)
    temp.append(count)
    temp.append(times)
    spec_list.append(temp)
    if (extract_type not in extract_type_list1) :
        extract_type_list1.append(extract_type)
    if (times not in times_list) :
        times_list.append(times)
    return []
load_spec_excel_to_list()
def get_items_hero(extract_type1, times1):
    row = 0
    result = ''
    while row < len(spec_list) :
        if (spec_list[row][0] == extract_type1) and (spec_list[row][3] == times1) :
            str_items_hero_id = str(spec_list[row][1]).strip()
            str_count = str(spec_list[row][2]).strip()
            if (not str_items_hero_id == '') and (not str_count == ''):
                result = result + '{' + str_items_hero_id + ',' + str_count + '}'+ ','
        row = row + 1
    if (len(result) > 0):
        result = result[0: len(result) - 1]
    return result

# 根据抽取类型获取特殊处理的次数
spec_time = []
spec_time.append("\n\n%% 根据抽取类型获取特殊处理的次数")
spec_time.append("%% @spec get_times(extract_type :: int()) -> time_list :: list | false")
# 针对第一次产出的英雄或物品做特殊处理
chest_item_hero_by_first = []
temp_base1 = []
chest_item_hero_by_first.append("\n\n%% 针对第一次产出的英雄或物品做特殊处理")
chest_item_hero_by_first.append("%% @spec get_item_hero_list_by_first(extract_type :: int(), times :: int()) -> [{item_hero_id :: int(), count :: int()}] | false")
def get_item_hero_list_by_first():
    for temp_extract in extract_type_list1:
        str_times = ''
        for temp_times in times_list:
            temp_result = get_items_hero(temp_extract, temp_times)
            if (len(temp_result) > 0):
                chest_item_hero_by_first.append("""get_item_hero_list_by_first({0}, {1}) -> {2};"""
                            .format(temp_extract, temp_times, '[' +  get_items_hero(temp_extract, temp_times) + ']'))
                str_times = str_times + str(temp_times).strip() + ','
        if (len(str_times) > 0):
            str_times = str_times[0 : len(str_times) - 1]
        spec_time.append("""get_times({0}) -> {1};""".format(str(temp_extract), '[' + str_times + ']'))
    return []

get_item_hero_list_by_first()
chest_item_hero_by_first.append("get_item_hero_list_by_first(_, _) -> false.")
spec_time.append("get_times(_) -> false.")
data_chest.extend(chest_item_hero_by_first)
data_chest.extend(spec_time)

# 根据抽取类型获取消耗钻石数量
cost_gold_list = []
cost_gold_list.append("\n\n%% 根据抽取类型获取消耗钻石数量")
cost_gold_list.append("%% @spec get_gold_cost(extract_type :: int()) -> cost_gold :: int()")
@load_sheel(work_book, ur"钻石消耗")
def get_gold_cost(content):
    extract_type = int(get_value(content[BaseField4.extract_type], 0))
    extract_type_1 = int(get_value(content[BaseField4.extract_type_1], 0))
    gold_cost = int(get_value(content[BaseField4.gold_cost], 0))
    cost_gold_list.append("""get_gold_cost({0}, {1}) -> {2};""".format(extract_type, extract_type_1, gold_cost))
    return []
get_gold_cost()
cost_gold_list.append("get_gold_cost(_, _) -> 0.")
data_chest.extend(cost_gold_list)





gen_erl(chest_erl, data_chest)
