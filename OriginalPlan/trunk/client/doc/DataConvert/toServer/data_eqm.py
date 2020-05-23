#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
装备配置
@author: ZhaoMing
@deprecated: 2013-11-20
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"eqm")

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
AttrIndex = """
    id
    ,rarity
    ,arm
    ,attrType
    ,hero_list
    ,attr_special
    ,name
"""
StarIndex = """
    itemID
    ,star
    ,items
    ,coin
    ,gold
"""
StrengthIndex = """
    star
    ,levelRequire
    ,addPercent
"""
StrengthExpIndex = """
    level
    ,exp
"""
SuitIndex = """
    suitID
    ,name
    ,itemList
    ,attr_2
    ,attr_4
    ,attr_6
"""

QualityExpIndex = """
    quality
    ,exp
    ,originValue
    ,raiseValue
"""
# 生成域枚举           
AttrField        = Field('AttrField', AttrIndex)
StarField        = Field('StarField', StarIndex)
StrengthField    = Field('StrengthField', StrengthIndex)
StrengthExpField = Field('StrengthExpField', StrengthExpIndex)
SuitField        = Field('SuitField', SuitIndex)
QualityExpField  = Field('QualityExpField', QualityExpIndex)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

eqm_erl = "data_eqm"
data_eqm = module_header(ur"装备配置", eqm_erl, "zm", "eqm.xlsx", "data_eqm.py")
data_eqm.append("""
-export([
         eqm_private/1
         ,star_cost/2
         ,max_star/1
         ,max_eqm_lev/1
         ,max_lev/0
         ,max_exp/1
         ,suit/1
         ,suit_attr/2
         ,get_all_suit/0
         ,get_suit_id_by_item_id/1
         ,get_quality_exp/1
         ,fit_hero_arms/1
         ,up_star_need_eqm_lev/1
         ,attr_per_by_star/1
         ,attr_per_by_quality/1
         ,attr_per_by_eqm_lev/2
         ,cost_coin_per_exp/0
         ,eqm_lev_factor/0
         ,get_add_attr_type_list/1
         ,get_attr_list/1
         ,can_up_star_item_list/2
        ]).

""")

eqm_private = []
eqm_private.append("%% @doc 根据物品获取专属的英雄")
eqm_private.append("%% @spec eqm_private(ItemID::int()) -> [HeroID::int()]")
fit_hero_arms = []
fit_hero_arms.append("%% @doc 该装备可穿在XXX英雄类型")
fit_hero_arms.append("%% @spec fit_hero_arms(ItemID::int()) -> [HeroArm::int()]")

add_attr_type_list = []
add_attr_type_list.append("""
%% @doc 该装备附加的属性类型
%% @spec get_add_attr_type_list(ItemID::int()) -> [{AttrType::int(), InitFactor::int()}] """)
attr_special_list = []
attr_special_list.append("""
%% @doc 装备获得的属性值
%% @spec get_attr_list(ItemID::int()) -> list() """)
@load_sheel(work_book, ur"装备ID和属性")
def get_eqm_attr(content):
    item_id = int(content[AttrField.id])
    hero_list = get_str(content[AttrField.hero_list], '')
    hero_arms = get_str(content[AttrField.arm], '')
    attr_type = get_value(content[AttrField.attrType], '{0, 0}')
    attr_list = get_str(content[AttrField.attr_special], '')
    eqm_private.append("eqm_private(%d) -> [%s];"%(item_id, hero_list))
    fit_hero_arms.append("fit_hero_arms(%d) -> [%s];"%(item_id, hero_arms))
    add_attr_type_list.append("get_add_attr_type_list(%d) -> [%s];"%(item_id, attr_type))
    attr_special_list.append("get_attr_list(%d) -> [%s];"%(item_id, attr_list))
    return []
get_eqm_attr()
eqm_private.append("eqm_private(_) -> [].")
fit_hero_arms.append("fit_hero_arms(_) -> [].")
add_attr_type_list.append("get_add_attr_type_list(_) -> [].")
attr_special_list.append("get_attr_list(_) -> [].")
data_eqm.extend(eqm_private)
data_eqm.extend(fit_hero_arms)
data_eqm.extend(add_attr_type_list)
data_eqm.extend(attr_special_list)

eqm_max_star = {}
eqm_star_cost = []
eqm_star_cost.append("%% @doc 升星消耗资源（不包含物品）")
eqm_star_cost.append("%% @spec star_cost(ItemID::int(), Star::int()) -> list()")

can_up_star_item_list = []
can_up_star_item_list.append("""
%% @doc 可以用于升星的装备
%% @spec can_up_star_item_list(ItemID::int(), Star::int()) -> list() """)

@load_sheel(work_book, ur"装备提星消耗")
def get_eqm_star(content):
    item_id = int(content[StarField.itemID])
    star = int(content[StarField.star])
    item_list = get_str(content[StarField.items], '')
    coin = int(get_value(content[StarField.coin], 0))
    gold = int(get_value(content[StarField.gold], 0))
    eqm_max_star.setdefault(item_id, 0)
    if eqm_max_star[item_id] < star:
        eqm_max_star[item_id] = star
    eqm_star_cost.append("star_cost(%d, %d) -> [{del_coin, %d}, {del_gold, %d}];"%(item_id, star, coin, gold))
    can_up_star_item_list.append("can_up_star_item_list(%d, %d) -> [%s] ++ [%d];"%(item_id, star, item_list, item_id))
    return []
get_eqm_star()
eqm_star_cost.append("star_cost(_, _) -> [{del_gold, 1000000}].")
can_up_star_item_list.append("can_up_star_item_list(_, _) -> [].")
max_star_list = []
max_star_list.append("%% @doc 最大星级")
max_star_list.append("%% @spec max_star(ItemID::int()) -> int()")
for i in eqm_max_star:
    max_star_list.append("max_star(%d) -> %d;"%(i, eqm_max_star[i]))
max_star_list.append("max_star(_) -> 0.")
data_eqm.extend(eqm_star_cost)
data_eqm.extend(max_star_list)
data_eqm.extend(can_up_star_item_list)

strength_lev_list = []
strength_lev_list.append("%% @doc 最大装备等级")
strength_lev_list.append("%% @spec max_eqm_lev(Star::int()) -> MaxLevel::int()")

up_star_need_eqm_lev_list = []
up_star_need_eqm_lev_list.append("""
%% @doc 提星需要强化等级
%% @spec up_star_need_eqm_lev(Star::int()) -> EqmLev::int() """)
attr_per_by_star_list = []
attr_per_by_star_list.append("""
%% @doc 属性加成
%% @spec attr_per_by_star(Star::int()) -> Per::number() """)

@load_sheel(work_book, ur"提星的等级要求和加成属性")
def get_strength_max(content):
    star = int(content[StrengthField.star])
    eqm_lev = int(get_value(content[StrengthField.levelRequire], 0))
    per = int(content[StrengthField.addPercent])
    up_star_need_eqm_lev_list.append("up_star_need_eqm_lev(%d) -> %d;"%(star, eqm_lev))
    attr_per_by_star_list.append("attr_per_by_star(%d) -> %d;"%(star, per))
    return []
get_strength_max()
strength_lev_list.append("max_eqm_lev(_) -> 0.")
up_star_need_eqm_lev_list.append("up_star_need_eqm_lev(_) -> 1000.")
attr_per_by_star_list.append("attr_per_by_star(_) -> 0.")
data_eqm.extend(strength_lev_list)
data_eqm.extend(up_star_need_eqm_lev_list)
data_eqm.extend(attr_per_by_star_list)

max_lev = 0
max_exp_list = []
max_exp_list.append("""
%% @doc 获取当前等级的最大经验值
%% @spec max_exp(Lev::int()) -> Exp::int() """)
max_strength_lev = 0
@load_sheel(work_book, ur"装备强化需求经验")
def get_strength_exp(content):
    global max_lev
    level = int(content[StrengthExpField.level])
    exp = int(content[StrengthExpField.exp])
    if max_lev < level:
        max_lev = level
    max_exp_list.append("max_exp(%d) -> %d;"%(level, exp))
    return []
get_strength_exp()
max_exp_list.append("max_exp(_) -> 0.")
data_eqm.extend(max_exp_list)

data_eqm.append("""
%% @doc 获取最大强化等级
%% @spec max_lev() -> Lev::int() """)
data_eqm.append("max_lev() -> %d."%(max_lev))

all_suit = []
suit_list = []
suit_list.append("%% @doc 获取某个套装内的所有物品ID")
suit_list.append("%% @spec suit_list(SuitID::int()) -> [ItemID::int()]")

suit_attr_list = []
suit_attr_list.append("%% @doc 获取套装属性")
suit_attr_list.append("%% @spec suit_attr(SuitID::int(), Count::int()) -> AttrList::list()")

get_suit_id_by_item_id_list = []
get_suit_id_by_item_id_list.append("""
%% @doc 根据物品ID获取套装ID
%% @spec get_suit_id_by_item_id(ItemID::int()) -> SuitID::int() """)

@load_sheel(work_book, ur"套装属性")
def get_suit(content):
    suit_id = int(content[SuitField.suitID])
    item_list = get_str(content[SuitField.itemList], '')
    attr_2 = get_str(content[SuitField.attr_2], '{1, 0}')
    attr_4 = get_str(content[SuitField.attr_4], '{1, 0}')
    attr_6 = get_str(content[SuitField.attr_6], '{1, 0}')
    suit_list.append("suit(%d) -> [%s];"%(suit_id, item_list))
    all_suit.append("%d"%(suit_id))
    suit_attr_list.append("suit_attr(SuitID, Num) when SuitID =:= %d, Num >= 6 -> [%s] ++ suit_attr(SuitID, 4) ++ suit_attr(SuitID, 2);"%(suit_id, attr_6))
    suit_attr_list.append("suit_attr(SuitID, Num) when SuitID =:= %d, Num >= 4 -> [%s] ++ suit_attr(SuitID, 2);"%(suit_id, attr_4))
    suit_attr_list.append("suit_attr(SuitID, Num) when SuitID =:= %d, Num >= 2 -> [%s];"%(suit_id, attr_2))

    for item_id in item_list.split(","):
        get_suit_id_by_item_id_list.append("get_suit_id_by_item_id(%s) -> %d;"%(item_id, suit_id))

    return []
get_suit()
suit_list.append("suit(_) -> [].")
suit_attr_list.append("suit_attr(_, _) -> [].")
get_suit_id_by_item_id_list.append("get_suit_id_by_item_id(_) -> 0.")
data_eqm.extend(suit_list)
data_eqm.extend(suit_attr_list)
data_eqm.extend(get_suit_id_by_item_id_list)

data_eqm.append("""
%% @doc 所有的套装
%% @spec get_all_suit() -> [SuitID::int()]
get_all_suit() -> [%s]. """%(",".join(all_suit)))

quality_exp_list = []
quality_exp_list.append("%% @doc 吞噬装备 品阶附加经验")
quality_exp_list.append("%% @spec get_quality_exp(Quality::int()) -> Exp::int()")

attr_per_by_quality_list = []
attr_per_by_quality_list.append("""
%% @doc 装备品质附加属性百分比
%% @spec attr_per_by_quality(Quality::int()) -> AttrPer::number() """)
attr_per_by_eqm_lev_list = []
attr_per_by_eqm_lev_list.append("""
%% @doc 装备品质&装备强化等级附加属性百分比
%% @spec attr_per_by_eqm_lev(Quality::int(), EqmLev::int()) -> AttrPer::number() """)
@load_sheel(work_book, ur"装备品质属性和经验值")
def get_quality_extra_exp(content):
    quality = int(content[QualityExpField.quality])
    exp = int(content[QualityExpField.exp])
    quality_attr_per = int(content[QualityExpField.originValue])
    eqm_lev_attr_per = int(content[QualityExpField.raiseValue])
    quality_exp_list.append("get_quality_exp(%d) -> %d;"%(quality, exp))
    attr_per_by_quality_list.append("attr_per_by_quality(%d) -> %d;"%(quality, quality_attr_per))
    attr_per_by_eqm_lev_list.append("attr_per_by_eqm_lev(%d, EqmLev) -> EqmLev * %d;"%(quality, eqm_lev_attr_per))

    return []
get_quality_extra_exp()
quality_exp_list.append("get_quality_exp(_) -> 0.")
attr_per_by_quality_list.append("attr_per_by_quality(_) -> 0.")
attr_per_by_eqm_lev_list.append("attr_per_by_eqm_lev(_, _) -> 0.")
data_eqm.extend(quality_exp_list)
data_eqm.extend(attr_per_by_quality_list)
data_eqm.extend(attr_per_by_eqm_lev_list)

@load_sheel(work_book, ur"强化消耗和强化上限")
def get_config(content):
    cost_coin = int(content[0])
    eqm_lev_factor = int(content[1])
    data_eqm.append("""
%%%% @doc 每点经验需要消耗金币
%%%% @spec cost_coin_per_exp() -> Coin::int()
cost_coin_per_exp() -> %d.
"""%(cost_coin))
    data_eqm.append("""
%%%% @doc 强化等级上限系数（是战队等级的K倍）
%%%% @spec eqm_lev_factor() -> Factor::int()
eqm_lev_factor() -> %d."""%(eqm_lev_factor))
    return []
get_config()

gen_erl(eqm_erl, data_eqm)
