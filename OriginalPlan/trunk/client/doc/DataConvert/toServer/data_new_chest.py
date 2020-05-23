#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
抽宝箱配置表
@author: ZhaoMing
@deprecated: 2015年01月21日
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"new_chest")

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

BaseIndex = """
    type,name,itemID,weight,minNum,maxNum,needCount,canList,mustList, level
"""

CostIndex = """
    type, contN, gold, cdTime, items, canCrit, canHelp
"""

BaseField    = Field('BaseField'    , BaseIndex)
CostField    = Field('CostField'    , CostIndex)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

new_chest_erl = "data_new_chest"
data_new_chest = module_header(ur"抽宝箱配置", new_chest_erl, "zm", "new_chest.xlsx", "data_new_chest.py")

data_new_chest.append("""
-export([
         can_take/3,
         take_must_list/3,
         take_can_list/3,
         can_free/2,
         cd_time/2,
         can_help/2,
         take_cost/2,
         is_valid_take/2,
         get_all/0,
         get_all_type/0,
         extra_give_item_list/2,
         chest_crit_num/1
        ]).
"""
)

can_take_dict = {}
must_take_dict = {}
can_take_list = []
can_take_list.append("""
%% @doc 是否可以抽取
%% @spec can_take(ChestType, ItemID, AccCount) -> true | false.  """)

@load_sheel(work_book, ur"宝箱权重配置")
def get_base(content, all_content, row):
    type = int(prev(all_content, row, BaseField.type))
    item_id = int(content[BaseField.itemID])
    weight = int(content[BaseField.weight])
    min_num = int(content[BaseField.minNum])
    max_num = int(content[BaseField.maxNum])
    need_count = int(get_value(content[BaseField.needCount], 0))
    can_list = get_str(content[BaseField.canList], '')
    must_list = get_str(content[BaseField.mustList], '')
    role_lev = int(get_value(content[BaseField.level], 0))

    for sub in can_list.split(","):
        if sub.strip() != '':
            key = "%d, %s"%(type, sub.strip())
            can_take_dict.setdefault(key, [])
            can_take_dict[key].append("{%d, util:rand(%d, %d), %d, %d}"%(item_id, min_num, max_num, weight, role_lev))

    for sub in must_list.split(","):
        if sub.strip() != '':
            key = "%d, %s"%(type, sub.strip())
            must_take_dict.setdefault(key, [])
            must_take_dict[key].append("{%d, util:rand(%d, %d), %d, %d}"%(item_id, min_num, max_num, weight, role_lev))

    can_take_list.append("can_take(ChestType, ItemID, AccCount) when ChestType =:= %d, ItemID =:= %d, AccCount >= %d -> true;"%(type, item_id, need_count))
    return []

get_base()
can_take_list.append("can_take(_, _, _) -> false.")

take_must_list_list = []
take_must_list_list.append("""
%% @doc 必出列表
%% @spec take_must_list(ChestType :: int(), ContN :: int(), RoleLev::int()) -> list() """)

for k in must_take_dict:
    take_must_list_list.append("take_must_list(%s, RoleLev) -> [{ItemID, Num, Weight} || {ItemID, Num, Weight, Lev} <- [%s], RoleLev >= Lev];"%(k, ",".join(must_take_dict[k])))
take_must_list_list.append("take_must_list(_, _, _RoleLev) -> [].")

take_can_list_list =[]
take_can_list_list.append("""
%% @doc 可出列表
%% @spec take_can_list(ChestType :: int(), ContN :: int(), RoleLev::int()) -> list() """)

for k in can_take_dict:
    take_can_list_list.append("take_can_list(%s, RoleLev) -> [{ItemID, Num, Weight} || {ItemID, Num, Weight, Lev} <- [%s], RoleLev >= Lev];"%(k, ",".join(can_take_dict[k])))
take_can_list_list.append("take_can_list(_, _, _RoleLev) -> [].")

data_new_chest.extend(can_take_list)
data_new_chest.extend(take_must_list_list)
data_new_chest.extend(take_can_list_list)


can_free_list = []
can_free_list.append("""
%% @doc 是否可以免费
%% @spec can_free(ChestType::int(), ContN::int()) -> true | false.  """)

can_help_list = []
can_help_list.append("""
%% @doc 是否可以使用互助
%% @spec can_help(ChestType::int(), ContN::int()) -> true | false """)

cd_time_list = []
cd_time_list.append("""
%% @doc 免费CD
%% @spec cd_time(ChestType::int(), ContN::int()) -> CDTime::int() """)

take_cost_list = []
take_cost_list.append("""
%% @doc 抽取花费
%% @spec take_cost(ChestType::int(), ContN::int()) -> Gold::int() """)

is_valid_take_list = []
is_valid_take_list.append("""
%% @doc 是否是有效的抽取次数
%% @spec is_valid_take(ChestType, ContN) -> true | false.  """)


extra_give_item_list = []
extra_give_item_list.append("""
%% @doc 额外赠送物品
%% @spec extra_give_item_list(ChestType::int(), ContN::int()) -> list() """)

all_take_list = []

all_type_list = []

chest_crit_num_list = []
chest_crit_num_list.append("""
%% @doc 根据宝箱类型获取可以暴击的次数
%% @spec chest_crit_num( ChestType::int() ) -> ContN::int() """)

@load_sheel(work_book, ur"宝箱花费")
def get_cost(content, all_content, row):
    type = int(prev(all_content, row, CostField.type))
    cont_n = int(content[CostField.contN])
    gold = int(content[CostField.gold])
    cd = int(get_value(content[CostField.cdTime], 0))
    item_list = get_str(content[CostField.items], '')
    can_crit = int(get_value(content[CostField.canCrit], 0))
    can_help = int(get_value(content[CostField.canHelp], 0))

    take_cost_list.append("take_cost(ChestType, ContN) when ChestType =:= %d, ContN =:= %d -> %d;"%(type, cont_n, gold))
    all_take_list.append("{%d, %d}"%(type, cont_n))

    all_type_list.append("%d"%(type))

    is_valid_take_list.append("is_valid_take(ChestType, ContN) when ChestType =:= %d, ContN =:= %d -> true;"%(type, cont_n))

    if cd != 0: 
        can_free_list.append("can_free(ChestType, ContN) when ChestType =:= %d, ContN =:= %d -> true;"%(type, cont_n))
        cd_time_list.append("cd_time(ChestType, ContN) when ChestType =:= %d, ContN =:= %d -> %d;"%(type, cont_n, cd))
    
    if can_crit == 1:
        chest_crit_num_list.append("chest_crit_num(ChestType) when ChestType =:= %d -> %d;"%(type, cont_n))

    if can_help == 1:
        can_help_list.append("can_help(ChestType, ContN) when ChestType =:= %d, ContN =:= %d -> true;"%(type, cont_n))

    extra_give_item_list.append("extra_give_item_list(ChestType, ContN) when ChestType =:= %d, ContN =:= %d -> [{add_items, [%s]}];"%(type, cont_n, item_list))
    return []
get_cost()

can_free_list.append("can_free(_, _) -> false.")
cd_time_list.append("cd_time(_, _) -> 0.")
take_cost_list.append("take_cost(_, _) -> 0.")
is_valid_take_list.append("is_valid_take(_, _) -> false.")
extra_give_item_list.append("extra_give_item_list(_, _) -> [].")
chest_crit_num_list.append("chest_crit_num(_) -> 0.")
can_help_list.append("can_help(_, _) -> false.")

data_new_chest.extend(can_free_list)
data_new_chest.extend(cd_time_list)
data_new_chest.extend(take_cost_list)
data_new_chest.extend(is_valid_take_list)
data_new_chest.extend(extra_give_item_list)
data_new_chest.extend(chest_crit_num_list)
data_new_chest.extend(can_help_list)

data_new_chest.append("""
%% @doc 所有的抽取类型
%% @spec get_all() -> list()
get_all() -> [%s]. """%(",".join(all_take_list)))

data_new_chest.append("""
%% @doc 所有宝箱类型
%% @spec get_all_type() -> list()

get_all_type() -> [%s]. """%(",".join(unique_list(all_type_list))))

gen_erl(new_chest_erl, data_new_chest)
