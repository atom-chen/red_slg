#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
生产图纸配置
@author: ZhaoMing
@deprecated: 2015年01月21日
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"buildproduce")

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
    buildingid, order, itemId
"""

CostIndex = """
    itemId, level, time, crystal, iron, uranium, goldTime 
"""

PosIndex = """
    id, vipLev, gold
"""

BaseField    = Field('BaseField'    , BaseIndex)
PosField     = Field('PosField'     , PosIndex)
CostField    = Field('CostField'    , CostIndex)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

paper_erl = "data_paper"
data_paper = module_header(ur"生产图纸", paper_erl, "zm", "buildproduce.xlsx", "data_paper.py")

data_paper.append("""
-export([
         open_pos_cost/1,
         open_pos_condition/1,
         get_build_id/1,
         add_paper_cost/1,
         del_paper_gain/1,
         all_pos/0,
         all_pos_by_vip/0,
         all_paper_list/0,
         need_build_lev/1,
         need_time/1,
         one_gold_clean_time/1
        ]).
"""
)

get_build_id_list = []
get_build_id_list.append("""
%% @doc 根据图纸获得需要的建筑类型
%% @spec get_build_id(ItemID::int()) -> BuildID::int() """)

@load_sheel(work_book, ur"建筑对应图纸")
def get_base(content):
    build_id = int(content[BaseField.buildingid])
    item_id = int(content[BaseField.itemId])
    get_build_id_list.append("get_build_id(ItemID) when ItemID =:= %d -> %d;"%(item_id, build_id))
    return []

get_base()

get_build_id_list.append("get_build_id(_) -> 0.")

data_paper.extend(get_build_id_list)

all_paper_list = []

add_paper_cost_list = []
add_paper_cost_list.append("""
%% @doc 加入队列消耗
%% @spec add_paper_cost(ItemID::int()) -> list() """)

del_paper_gain_list = []
del_paper_gain_list.append("""
%% @doc 从队列删除图纸获得
%% @spec del_paper_gain(ItemID::int()) -> list() """)

need_build_lev_list = []
need_build_lev_list.append("""
%% @doc 图纸生产需要的建筑等级
%% @spec need_build_lev(ItemID::int()) -> BuildLev::int() """)

need_time_list = []
need_time_list.append("""
%% @doc 生产需要时间
%% @spec need_time(ItemID::int()) -> Second::int() """)

one_gold_clean_time_list = []
one_gold_clean_time_list.append("""
%% @doc 一元宝可以清除CD时间
%% @spec one_gold_clean_time(ItemID::int()) -> CDTime::int() """)

@load_sheel(work_book, ur"生产消耗")
def get_cost(content):
    item_id = int(content[CostField.itemId])
    build_lev = int(content[CostField.level])
    cost_time = int(content[CostField.time])
    crystal = int(get_value(content[CostField.crystal], 0))
    iron = int(get_value(content[CostField.iron], 0))
    uranium = int(get_value(content[CostField.uranium], 0))
    gold_time = int(content[CostField.goldTime])

    add_paper_cost_list.append("add_paper_cost(ItemID) when ItemID =:= %d -> [{del_crystal, %d}, {del_iron, %d}, {del_uranium, %d}];"%(item_id, crystal, iron, uranium))
    del_paper_gain_list.append("del_paper_gain(ItemID) when ItemID =:= %d -> [{add_crystal, %d}, {add_iron, %d}, {add_uranium, %d}];"%(item_id, crystal, iron, uranium))

    all_paper_list.append("%d"%(item_id))

    need_build_lev_list.append("need_build_lev(ItemID) when ItemID =:= %d -> %d;"%(item_id, build_lev))
    need_time_list.append("need_time(ItemID) when ItemID =:= %d -> %d;"%(item_id, cost_time))
    one_gold_clean_time_list.append("one_gold_clean_time(ItemID) when ItemID =:= %d -> %d;"%(item_id, gold_time))

    return []

get_cost()

add_paper_cost_list.append("add_paper_cost(_) -> [].")
del_paper_gain_list.append("del_paper_gain(_) -> [].")
need_build_lev_list.append("need_build_lev(_) -> 100.")
need_time_list.append("need_time(_) -> 0.")
one_gold_clean_time_list.append("one_gold_clean_time(_) -> 1.")

data_paper.extend(add_paper_cost_list)
data_paper.extend(del_paper_gain_list)
data_paper.extend(need_build_lev_list)
data_paper.extend(one_gold_clean_time_list)
data_paper.extend(need_time_list)


data_paper.append("""
%% @doc 所有图纸
%% @spec all_paper_list() -> list() 
all_paper_list() -> [%s]. """%(",".join(all_paper_list)))


open_pos_cost_list = []
open_pos_cost_list.append("""
%% @doc 开孔消耗
%% @spec open_pos_cost(Pos::int()) -> list() """)

open_pos_condition_list = []
open_pos_condition_list.append("""
%% @doc 开孔条件(满足一个即可)
%% @spec open_pos_condition(Pos::int()) -> list() """)

all_pos_list = []
all_pos_by_vip_list = []

@load_sheel(work_book, ur"生产序列解锁条件")
def get_pos(content):
    pos = int(content[PosField.id])
    vip_lev = int(get_value(content[PosField.vipLev], -1))
    gold = int(get_value(content[PosField.gold], 0))

    open_pos_cost_list.append("open_pos_cost(Pos) when Pos =:= %d -> [{del_gold, %d}];"%(pos, gold))
    open_pos_condition_list.append("open_pos_condition(Pos) when Pos =:= %d -> [{role_vip, %d}];"%(pos, vip_lev))
    all_pos_list.append("%d"%(pos))

    if vip_lev != -1:
        all_pos_by_vip_list.append("%d"%(pos))
    return []

get_pos()

open_pos_cost_list.append("open_pos_cost(_) -> [].")
open_pos_condition_list.append("open_pos_condition(_) -> [].")

data_paper.extend(open_pos_cost_list)
data_paper.extend(open_pos_condition_list)

data_paper.append("""
%% @doc 所有孔
%% @spec all_pos() -> [Pos::int()]
all_pos() -> [%s]. """%(",".join(all_pos_list)))

data_paper.append("""
%% @doc vip可以开的孔
%% @spec all_pos_by_vip() -> [Pos::int()]
all_pos_by_vip() -> [%s]. """%(",".join(all_pos_by_vip_list)))

gen_erl(paper_erl, data_paper)
