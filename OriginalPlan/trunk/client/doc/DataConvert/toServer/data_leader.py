#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
指挥官生成器
@author: ZhaoMing
@deprecated: 2015年01月21日
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"leader")

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

LeaderBaseIndex = """
    id,name,icon,desc,recruit,renown,item,superWeapon, type, mainAttrType,effectedHeroArm,
    skillName,skillDes,skillIcon, attrList,
    item_star_2, item_star_3, item_star_4, item_star_5,
    mainAttrValue_1, mainAttrValue_2, mainAttrValue_3, mainAttrValue_4, mainAttrValue_5,line,open
"""

LeaderLevIndex = """
    lev, exp
"""

LeaderWashIndex = """
    star, min_exp, max_exp, item_list, prestige, lock_gold
"""

LeaderAttrIndex = """
    attrType, lev, white_area, green_area, blue_area, purple_area, orange_area
"""

LeaderBaseField    = Field('LeaderBaseField'    , LeaderBaseIndex)
LeaderLevField     = Field('LeaderLevField'     , LeaderLevIndex)
LeaderWashField    = Field('LeaderWashField'    , LeaderWashIndex)
LeaderAttrField    = Field('LeaderAttrField'    , LeaderAttrIndex)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

leader_erl = "data_leader"
data_leader = module_header(ur"精彩活动配置", leader_erl, "zm", "leader.xlsx", "data_leader.py")

data_leader.append("""
-include("leader.hrl").

-export([
         %% 将领升级
         max_lev/0,
         max_exp/1,
         %% 将领基础信息
         get/1,
         get_all/0,
         get_skill_id/1,
         up_star_cost/2,
         get_main_attr/2,
         add_exp/1,
         wash_cost/1,
         lock_gold_cost/1,
         wash_attr/2,
         max_star/0,
         add_leader_cost/1,
         get_main_attr_effect_arms/1
        ]).

max_star() -> 5. 

""")

all_leader_list = []

leader_list = []

up_star_cost_list = []

main_attr_value_list = []

add_leader_cost_list = []
add_leader_cost_list.append("""
%% @doc 招募将领消耗
%% @spec add_leader_cost(LeaderID::int()) -> list() """)

skill_id_list = []
skill_id_list.append("""
%% @doc 超级武器技能ID
%% @spec get_skill_id(LeaderID::int()) -> SkillID::int() """)

get_main_attr_effect_arms_list = []
get_main_attr_effect_arms_list.append("""
%% @doc 主属性生效兵种
%% @spec get_main_attr_effect_arms(LeaderID::int()) -> [Arm::int()] """)

@load_sheel(work_book, ur"将领基础信息")
def get_base(content):
    id = int(content[LeaderBaseField.id])
    condition = get_str(content[LeaderBaseField.recruit], '')
    main_attr_type_list = get_str(content[LeaderBaseField.mainAttrType], '')
    hero_arm_list = get_str(content[LeaderBaseField.effectedHeroArm], '')
    super_weapon = int(get_value(content[LeaderBaseField.superWeapon], 0))
    attr_type_list = get_str(content[LeaderBaseField.attrList], '')
    item_star_2 = get_str(content[LeaderBaseField.item_star_2], '')
    item_star_3 = get_str(content[LeaderBaseField.item_star_3], '')
    item_star_4 = get_str(content[LeaderBaseField.item_star_4], '')
    item_star_5 = get_str(content[LeaderBaseField.item_star_5], '')
    main_attr_value_1 = int(get_value(content[LeaderBaseField.mainAttrValue_1], 0))
    main_attr_value_2 = int(get_value(content[LeaderBaseField.mainAttrValue_2], 0))
    main_attr_value_3 = int(get_value(content[LeaderBaseField.mainAttrValue_3], 0))
    main_attr_value_4 = int(get_value(content[LeaderBaseField.mainAttrValue_4], 0))
    main_attr_value_5 = int(get_value(content[LeaderBaseField.mainAttrValue_5], 0))
    shengwang = int(content[LeaderBaseField.renown])
    items = get_str(content[LeaderBaseField.item], '')
    is_open = int(content[LeaderBaseField.open])
    if is_open == 1:
        get_main_attr_effect_arms_list.append("get_main_attr_effect_arms(%d) -> [%s];"%(id, hero_arm_list))
        all_leader_list.append("%d"%(id))
        up_star_cost_list.append("up_star_cost(%d, 2) -> [{del_items, [%s]}];"%(id, item_star_2))
        up_star_cost_list.append("up_star_cost(%d, 3) -> [{del_items, [%s]}];"%(id, item_star_3))
        up_star_cost_list.append("up_star_cost(%d, 4) -> [{del_items, [%s]}];"%(id, item_star_4))
        up_star_cost_list.append("up_star_cost(%d, 5) -> [{del_items, [%s]}];"%(id, item_star_5))
        main_attr_value_list.append("get_main_attr(%d, 1) -> %d;"%(id, main_attr_value_1))
        main_attr_value_list.append("get_main_attr(%d, 2) -> %d;"%(id, main_attr_value_2))
        main_attr_value_list.append("get_main_attr(%d, 3) -> %d;"%(id, main_attr_value_3))
        main_attr_value_list.append("get_main_attr(%d, 4) -> %d;"%(id, main_attr_value_4))
        main_attr_value_list.append("get_main_attr(%d, 5) -> %d;"%(id, main_attr_value_5))
        add_leader_cost_list.append("add_leader_cost(%d) -> [{del_shengwang, %d}, {del_items, [%s]}];"%(id, shengwang, items))
        leader_list.append("""
get({0}) ->
    #leader_base{{
        id = {0},
        condition = [{1}],
        main_attr_type_list = [{2}],
        attr_type_list = [{3}]
    }};""".format(id, condition, main_attr_type_list, attr_type_list))
        skill_id_list.append("get_skill_id(%d) -> %d;"%(id, super_weapon))
    return []

get_base()

leader_list.append("get(_) -> false.")
up_star_cost_list.append("up_star_cost(_, _) -> [].")
main_attr_value_list.append("get_main_attr(_, _) -> 0.")
add_leader_cost_list.append("add_leader_cost(_) -> [].")
skill_id_list.append("get_skill_id(_) -> 0.")
get_main_attr_effect_arms_list.append("get_main_attr_effect_arms(_) -> [].")

data_leader.append("get_all() -> [%s]."%(",".join(all_leader_list)))
data_leader.extend(leader_list)
data_leader.extend(up_star_cost_list)
data_leader.extend(main_attr_value_list)
data_leader.extend(add_leader_cost_list)
data_leader.extend(skill_id_list)
data_leader.extend(get_main_attr_effect_arms_list)

leader_max_lev = 0

leader_exp_list =[]

@load_sheel(work_book, ur"将领升级")
def get_lev(content):
    global leader_max_lev
    lev = int(content[LeaderLevField.lev])
    exp = int(content[LeaderLevField.exp])
    if lev > leader_max_lev:
        leader_max_lev = lev
    leader_exp_list.append("max_exp(%d) -> %d;"%(lev, exp))
    return []

get_lev()
leader_exp_list.append("max_exp(_) -> 0.")

data_leader.append("max_lev() -> %d."%(leader_max_lev))
data_leader.extend(leader_exp_list)

add_exp_list = []
wash_cost_list = []
lock_gold_cost_list = []

@load_sheel(work_book, ur"洗练经验及消耗")
def get_wash(content):
    star = int(content[LeaderWashField.star])
    min_exp = int(content[LeaderWashField.min_exp])
    max_exp = int(content[LeaderWashField.max_exp])
    item_list = get_str(content[LeaderWashField.item_list], '')
    prestige = int(content[LeaderWashField.prestige])
    lock_gold = int(content[LeaderWashField.lock_gold])
    
    add_exp_list.append("add_exp(%d) -> util:rand(%d, %d);"%(star, min_exp, max_exp))
    wash_cost_list.append("wash_cost(%d) -> [{del_prestige, %d}, {del_items, [%s]}];"%(star, prestige, item_list))
    lock_gold_cost_list.append("lock_gold_cost(%d) -> [{del_gold, %d}];"%(star, lock_gold))
    return []

get_wash()
add_exp_list.append("add_exp(_) -> 0.")
wash_cost_list.append("wash_cost(_) -> [].")
lock_gold_cost_list.append("lock_gold_cost(_) -> [].")

data_leader.extend(add_exp_list)
data_leader.extend(wash_cost_list)
data_leader.extend(lock_gold_cost_list)

wash_attr_list = []

@load_sheel(work_book, ur"洗练属性")
def get_wash_attr(content):
    attr_type = int(content[LeaderAttrField.attrType])
    lev = int(content[LeaderAttrField.lev])
    white_area = get_str(content[LeaderAttrField.white_area], '{0, 0, 0}')
    green_area = get_str(content[LeaderAttrField.green_area], '{0, 0, 0}')
    blue_area = get_str(content[LeaderAttrField.blue_area], '{0, 0, 0}')
    purple_area = get_str(content[LeaderAttrField.purple_area], '{0, 0, 0}')
    orange_area = get_str(content[LeaderAttrField.orange_area], '{0, 0, 0}')
    
    wash_attr_list.append("""
wash_attr(%d, %d) -> 
    WeightList = [%s, %s, %s, %s, %s],
    case util:list_rands_by_rate(WeightList, 1) of
        [{Min, Max, _}] when Max >= Min -> util:rand(Min, Max);
        _ -> 0
    end;
    """%(attr_type, lev, white_area, green_area, blue_area, purple_area, orange_area))
    return []
get_wash_attr()

wash_attr_list.append("wash_attr(_, _) -> 0.")

data_leader.extend(wash_attr_list)

gen_erl(leader_erl, data_leader)
