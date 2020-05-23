#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
物品合成配置
@author: ZhaoMing
@deprecated: 2013-11-20
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"hero")

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

HeroColumn = """
    id,name,res,illusory,atkRes,tyre,head,heroNum,avNum,career,heroType,arm,scope,
    flyType,flyHeight,posLength,occupy,populace,pTime,atkRate,atkRate_1,
    atkScope,defType,priority,ignore,bombNum,main_atkCD,minor_atkCD,
    speed,turnSpeed,atkRange,atkRange_1,warnRange,
    skills,skillTurn,skills_1,skillTurn_1,passengerNum,passengerCareer,
    passengerAtkRes,passengerSkill,passengerAtkRate,passengerAttType,passengerAttRate,passengerAI,
    effect,heroMagic,moveMagic,standMagic,dieMagic,corpseMagic,dieSkill,speciaAI,
    immuneCharm,charmNum,comeOutRes,attrFactor,desc,robot
"""

ExpColumn = """
    lev
    ,exp
    ,def_factor
"""

QualityColumn = """
    hero_id
    ,quality
    ,items
    ,coin
    ,level
    ,attrList
    ,stockNum
    ,name
"""

QualityNameColumn = """
    quality
    ,lev
    ,name
"""

EliteQualityColumn = """
    hero_id
    ,elite_level
    ,need_item
    ,quality_level
    ,attrPercent
"""
StarAttrIndex = """
    id, star, attrList
"""

StarExpIndex = """
    star,exp
"""

StarLevIndex = """
    id, min_star, max_star
"""

StarCostIndex = """
    id,exp,gold
"""

# 生成域枚举           
BaseField         = Field('BaseField', HeroColumn)
ExpField          = Field('ExpField', ExpColumn)
QualityField      = Field('QualityField', QualityColumn)
EliteQualityField = Field('EliteQualityField', EliteQualityColumn)
StarAttrField     = Field('StarAttrField', StarAttrIndex)
StarExpField      = Field('StarExpField', StarExpIndex)
StarLevField      = Field('StarLevField', StarLevIndex)
StarCosField      = Field('StarCosField', StarCostIndex)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

hero_erl = "data_hero"
data_hero = module_header(ur"英雄配置", hero_erl, "zm", "hero.xlsx", "data_hero.py")

hero_star_erl = "data_hero_star"
data_hero_star = module_header(ur"英雄升星配置", hero_star_erl, 'zm', 'hero.xlsx', 'data_hero.py')
data_hero_star.append("""
-export([
         get_star_attr/2,
         max_exp/1,
         max_lev/1,
         cost_item_add_exp/1,
         default_star/1
        ]).
""")

monster_erl = "data_monster_1"
data_monster_1 = module_header(ur"英雄怪物配置", monster_erl, "zm", "hero.xlsx", "data_hero.py")
data_monster_1.append("""
-include("monster.hrl").
-include("hero_attr.hrl").

-export([get/1]).
""")

hero_php = "base_hero.cfg"
php_data_hero = module_php_header(ur"英雄配置", hero_php, "zm", "hero.xlsx", "data_hero.py")
data_hero.append("""
-include("hero.hrl").

-export([
         get/1, 
         get_all/0,
         get_all_arena/0,
         get_hero_arm/1,
         get_exp/1, 
         quality_cost/2,
         max_quality/1,
         get_def_factor/1,
         get_quality_attr_list/2,
         up_quality_need_lev/2,
         get_stock_num/2,
         elite_quality_cost/2,
         get_elite_quality_percent/2,
         up_elite_need_quality/2,
         max_elite_quality/1
        ]).

get_hero_arm(HeroID) ->
    case ?MODULE:get(HeroID) of
        #hero_base{hero_arm = T} -> T;
        _ -> 0
    end.
""")


monster_list = []
all_heros = []
all_arena_heros = []
hero_info = []
hero_info.append("%% @spec get(HeroID :: int()) -> #hero{} | false")
php_hero_info = []
php_hero_info.append("""return $base_hero = array( 
    0 => array('id' => 0, 'name' => ''),""")
@load_sheel(work_book, ur"英雄基础信息配置表")
def get_hero(content):
    hero_id = int(content[BaseField.id])
    name = str(content[BaseField.name])
    hero_type = int(get_value(content[BaseField.heroType], 0))
    hero_arm = int(get_value(content[BaseField.arm], 0))
    populace = int(content[BaseField.populace])
    main_atk_cd = int(get_value(content[BaseField.main_atkCD], 99999999))
    minor_atk_cd = int(get_value(content[BaseField.minor_atkCD], 99999999))
    hero_num = int(get_value(content[BaseField.heroNum], 1))
    scope = int(content[BaseField.scope])
    career = int(get_value(content[BaseField.career], 0))
    pos_length = int(get_value(content[BaseField.posLength], 1))
    occupy = get_str(content[BaseField.occupy], '')
    main_atk_rate = get_str(content[BaseField.atkRate], '')
    minor_atk_rate = get_str(content[BaseField.atkRate_1], '')
    atk_scope = get_str(content[BaseField.atkScope], '')
    def_type = int(content[BaseField.defType])
    priority_atk_career = get_str(content[BaseField.priority], '')
    ignore_atk_career = get_str(content[BaseField.ignore], '')
    bomb_num = get_str(content[BaseField.bombNum], '')
    speed = int(content[BaseField.speed])
    main_atk_range = get_str(content[BaseField.atkRange], '')
    minor_atk_range = get_str(content[BaseField.atkRange_1], '')
    main_skills = get_str(content[BaseField.skills], '')
    main_skill_turn = get_str(content[BaseField.skillTurn], '')
    minor_skills = get_str(content[BaseField.skills_1], '')
    minor_skill_turn = get_str(content[BaseField.skillTurn_1], '')
    die_skills = get_str(content[BaseField.dieSkill], '')
    robot = int(get_value(content[BaseField.robot], 0))
    special_ai = int(get_value(content[BaseField.speciaAI], 0))
    immune_type = get_str(content[BaseField.immuneCharm], '')
    control_num = int(get_value(content[BaseField.charmNum], 0))
    passengerNum = int(get_value(content[BaseField.passengerNum], 0))
    passengerCareer = get_str(content[BaseField.passengerCareer], '')
    passengerSkill = get_str(content[BaseField.passengerSkill], '')
    passengerAtkRate = get_str(content[BaseField.passengerAtkRate], '')
    passengerAttType = get_str(content[BaseField.passengerAttType], '')
    passengerAttRate = get_str(content[BaseField.passengerAttRate], '')
    hero_info.append("""get({0}) ->
    #hero_base{{
        hero_id = {0}
        ,hero_arm = {1}
    }}; """.format(hero_id, hero_arm))
    all_heros.append("%d"%(hero_id))
    if robot == 1:
        all_arena_heros.append("%d"%(hero_id))
    php_hero_info.append("    {0} => array('id' => {0}, 'name' => '{1}'),".format(hero_id, name))
    php_hero_info.append("    '{1}' => array('id' => {0}, 'name' => '{1}'),".format(hero_id, name))

    monster_list.append("""get({0}) ->
    #monster{{
        id = {0},
        populace = {1},
        hero_num = {8},
        hero_type = {9},
        scope = {10},
        pos_length = {11},
        occupy = [{12}],
        main_atk_rate = [{13}],
        minor_atk_rate = [{14}],
        atk_scope = [{15}],
        def_type = {16},
        priority_atk_career = [{17}],
        ignore_atk_career = [{18}],
        bomb_num = [{19}],
        main_atk_range = case length([{21}]) of 0 -> [0, 0]; 1 -> [{21}]++[0]; _ -> [{21}] end,
        minor_atk_range = case length([{22}]) of 0 -> [0, 0]; 1 -> [{22}]++[0]; _ -> [{22}] end,
        main_skills = [{23}],
        main_skill_turn = [{24}],
        minor_skills = [{25}],
        minor_skill_turn = [{26}],
        die_skills = [{27}],
        career = {28},
        special_ai = {29},
        immune_type = [{30}],
        control_num = {31},
        passenger_list = [[{32}], [{33}], [{34}], [{35}], [{36}]],
        passenger_num = {37},
        hero_arm = {38},
        attr_list = [
            {{?MAIN_ATK, {2}}},
            {{?MINOR_ATK, {3}}},
            {{?MAIN_ATK_CD, {4}}},
            {{?MINOR_ATK_CD, {5}}},
            {{?DEFENCE, {6}}},
            {{?HP, {7}}},
            {{?SPEED, {20}}}
           ]
    }};""".format(
        hero_id
        ,populace
        ,0
        ,0
        ,main_atk_cd
        ,minor_atk_cd
        ,0
        ,0
        ,hero_num
        ,hero_type
        ,scope
        ,pos_length
        ,occupy
        ,main_atk_rate
        ,minor_atk_rate
        ,atk_scope
        ,def_type
        ,priority_atk_career
        ,ignore_atk_career
        ,bomb_num
        ,speed
        ,main_atk_range
        ,minor_atk_range
        ,main_skills
        ,main_skill_turn
        ,minor_skills
        ,minor_skill_turn
        ,die_skills
        ,career
        ,special_ai
        ,immune_type
        ,control_num
        ,passengerCareer
        ,passengerSkill
        ,passengerAtkRate
        ,passengerAttType
        ,passengerAttRate
        ,passengerNum
        ,hero_arm
        ))
    return []
get_hero()
monster_list.append("get(_) -> false.")
hero_info.append("get(_) -> false.")
data_hero.extend(hero_info)
data_monster_1.extend(monster_list)
php_hero_info.append(");")
php_data_hero.extend(php_hero_info)

data_hero.append("%% @spec get_all() -> [int()]")
data_hero.append("%% @doc 所有的英雄ID")
data_hero.append("get_all() -> [%s]."%(",".join(all_heros)))
data_hero.append("get_all_arena() -> [%s]."%(",".join(all_arena_heros)))

hero_exp = []
hero_exp.append("%% @spec get_exp(Level::int()) -> Exp::int() | false.")

hero_def_factor = []
hero_def_factor.append("%% @spec get_def_factor(Level::int()) -> int()")
@load_sheel(work_book, ur"英雄升级配置表")
def get_hero_exp(content):
    lev = int(content[ExpField.lev])
    exp = int(content[ExpField.exp])
    def_factor = int(content[ExpField.def_factor])
    #attr_list = get_str(content[ExpField.attrList], '')
    hero_exp.append("get_exp(%d) -> %d;"%(lev, exp))
    #hero_def_factor.append("get_def_factor(%d) -> %d;"%(lev, def_factor))

    return []
get_hero_exp()
hero_exp.append("get_exp(_) -> false.")
hero_def_factor.append("get_def_factor(_) -> 0.")
data_hero.extend(hero_exp)
data_hero.extend(hero_def_factor)

quality_cost = []
max_quality = {}
hero_quality_attr_list = []
stock_list = []
hero_quality_attr_list.append("%% @spec get_quality_attr_list(HeroID::int(), Quality::int()) -> list()")
up_quality_need_lev_list = []
up_quality_need_lev_list.append("""
%% @doc 升级军衔需要英雄等级
%% @spec up_quality_need_lev(HeroID::int(), Quality::int()) -> HeroLev::int() """)

@load_sheel(work_book, ur"英雄军衔配置表")
def get_hero_quailty(content):
    hero_id = int(content[QualityField.hero_id])
    quality = int(content[QualityField.quality])
    hero_lev = int(get_value(content[QualityField.level], 0))
    items = get_str(content[QualityField.items], '')
    coin = int(get_value(content[QualityField.coin], 0))
    attr_list = get_str(content[QualityField.attrList], '')
    stock_num = int(get_value(content[QualityField.stockNum], 0))
    max_quality.setdefault(hero_id, 0)
    if max_quality[hero_id] < quality:
        max_quality[hero_id] = quality
    quality_cost.append("quality_cost(%d, %d) -> [{del_items, [%s]}, {del_coin, %d}];"%(hero_id, quality, items, coin))
    stock_list.append("get_stock_num(%d, %d) -> %d;"%(hero_id, quality, stock_num))
    hero_quality_attr_list.append("get_quality_attr_list(%d, %d) -> [%s];"%(hero_id, quality, attr_list))
    up_quality_need_lev_list.append("up_quality_need_lev(%d, %d) -> %d;"%(hero_id, quality, hero_lev))
    return []
get_hero_quailty()
quality_cost.append("quality_cost(_, _) -> [].")
stock_list.append("get_stock_num(_, _) -> 0.")
hero_quality_attr_list.append("get_quality_attr_list(_, _) -> [].")
up_quality_need_lev_list.append("up_quality_need_lev(_, _) -> 0.")
data_hero.extend(quality_cost)
data_hero.extend(stock_list)
data_hero.extend(hero_quality_attr_list)
data_hero.extend(up_quality_need_lev_list)

max_quality_list = []
for i in max_quality:
    max_quality_list.append("max_quality(%d) -> %d;"%(i, max_quality[i]))
max_quality_list.append("max_quality(_) -> 0.")
data_hero.extend(max_quality_list)


elite_quality_cost = []
max_elite_quality = {}
elite_quality_attr_list = []
elite_quality_attr_list.append("%% @spec get_quality_attr_list(HeroID::int(), Quality::int()) -> list()")
up_elite_quality_need_list = []
up_elite_quality_need_list.append("""
%% @doc 升级精英品阶需要英雄军衔
%% @spec up_elite_need_quality(HeroID::int(), Elite::int()) -> Quality::int() """)

@load_sheel(work_book, ur"精英")
def get_elite_quailty(content):
    hero_id     = int(content[EliteQualityField.hero_id])
    elite_level = int(content[EliteQualityField.elite_level])
    need_item   = get_str(content[EliteQualityField.need_item], '')
    quality_level = int(content[EliteQualityField.quality_level])
    attr_percent= int(content[EliteQualityField.attrPercent])

    max_elite_quality.setdefault(hero_id, 0)
    if max_elite_quality[hero_id] < elite_level:
        max_elite_quality[hero_id] = elite_level
    elite_quality_cost.append("elite_quality_cost(%d, %d) -> [{del_items, [%s]}];"%(hero_id, elite_level, need_item))
    elite_quality_attr_list.append("get_elite_quality_percent(%d, %d) -> %d;"%(hero_id, elite_level, attr_percent))
    up_elite_quality_need_list.append("up_elite_need_quality(%d, %d) -> %d;"%(hero_id, elite_level, quality_level))
    return []
get_elite_quailty()

elite_quality_cost.append("elite_quality_cost(_, _) -> [].")
elite_quality_attr_list.append("get_elite_quality_percent(_, _) -> 0.")
up_elite_quality_need_list.append("up_elite_need_quality(_, _) -> 0.")
data_hero.extend(elite_quality_cost)
data_hero.extend(elite_quality_attr_list)
data_hero.extend(up_elite_quality_need_list)

max_elite_quality_list = []
for i in max_elite_quality:
    max_elite_quality_list.append("max_elite_quality(%d) -> %d;"%(i, max_elite_quality[i]))
max_elite_quality_list.append("max_elite_quality(_) -> 0.")
data_hero.extend(max_elite_quality_list)

star_attr_list = []
star_attr_list.append("""
%% @doc 英雄星级属性
%% @spec get_star_attr(HeroID::int(), Star::int()) -> list() """)

@load_sheel(work_book, ur"星级属性")
def get_star_attr(content):
    hero_id = int(content[StarAttrField.id])
    star = int(content[StarAttrField.star])
    attr_list = get_str(content[StarAttrField.attrList], '')
    star_attr_list.append("get_star_attr(HeroID, Star) when HeroID =:= %d, Star =:= %d -> [%s];"%(hero_id, star, attr_list))
    return []

get_star_attr()
star_attr_list.append("get_star_attr(_, _) -> [].")
data_hero_star.extend(star_attr_list)

max_exp_list = []
max_exp_list.append("""
%% @doc 升星需要经验
%% @spec max_exp(StarLev::int()) -> StarExp::int() """)
max_star_lev = 0
@load_sheel(work_book, ur"星级经验")
def get_star_exp(content):
    global max_star_lev
    lev = int(content[StarExpField.star])
    exp = int(get_value(content[StarExpField.exp], 0))
    if lev > max_star_lev:
        max_star_lev = lev
    max_exp_list.append("max_exp(Star) when Star =:= %d -> %d;"%(lev, exp))
    return []
    
get_star_exp()
max_exp_list.append("max_exp(_) -> 0.")
data_hero_star.extend(max_exp_list)

max_lev_list = []
max_lev_list.append("""
%% @doc 最大星级
%% @spec max_lev(HeroID::int()) -> MaxStarLev::int()
""")

default_star_list = []
default_star_list.append("""
%% @doc 默认星级
%% @spec default_star(HeroID::int()) -> StarLev::int()
""")

@load_sheel(work_book, ur"英雄星级")
def get_star_lev(content):
    global max_star_lev
    hero_id = int(content[StarLevField.id])
    default_star = int(content[StarLevField.min_star])
    max_star = int(content[StarLevField.max_star])
    default_star_list.append("default_star(%d) -> %d;"%(hero_id, max(0, min(default_star, max_star_lev))))
    max_lev_list.append("max_lev(%d) -> %d;"%(hero_id, min(max_star, max_star_lev)))
    return []
get_star_lev()

default_star_list.append("default_star(_) -> 0.")
max_lev_list.append("max_lev(_) -> 0.")


data_hero_star.extend(default_star_list)
data_hero_star.extend(max_lev_list)

cost_item_add_exp_list = []
cost_item_add_exp_list.append("""
%% @doc 消耗物品获得经验
%% @spec cost_item_add_exp(ItemID::int()) -> AddStarExp::int() """)
@load_sheel(work_book, ur"星级消耗物品")
def get_star_add_exp(content):
    item_id = int(content[StarCosField.id])
    exp = int(content[StarCosField.exp])
    cost_item_add_exp_list.append("cost_item_add_exp(ItemID) when ItemID =:= %d -> %d;"%(item_id, exp))
    return []
get_star_add_exp()
cost_item_add_exp_list.append("cost_item_add_exp(_) -> 0.")
data_hero_star.extend(cost_item_add_exp_list)

gen_erl(monster_erl, data_monster_1)
gen_erl(hero_erl, data_hero)
gen_php(hero_php, php_data_hero)
gen_erl(hero_star_erl, data_hero_star)
