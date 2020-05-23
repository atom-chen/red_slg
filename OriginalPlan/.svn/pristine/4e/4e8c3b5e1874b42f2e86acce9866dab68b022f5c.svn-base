#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
怪物配置
@author: ZhaoMing
@deprecated: 2013-11-20
'''
import os
import __builtin__
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"monster")

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
BaseColumn = """
    id,name,shareDataID,populace,main_atk,minor_atk,defence,hp,level
"""
ShareDataColumn = """
    id,name,res,illusory,atkRes,tyre,head,
    heroNum,avNum,heroType,scope,flyType,flyHeight,
    posLength,occupy,populace,atkRate,atkRate_1,atkScope,
    defType,priority,ignore,bombNum,speed,turnSpeed,ai,
    atkRange,atkRange_1,main_atkCD,minor_atkCD,warnRange,
    skills,skillTurn,skills_1,skillTurn_1,
    passengerNum,passengerCareer,passengerAtkRes,passengerSkill,
    passengerAtkRate,passengerAttType,passengerAttRate,passengerAI,
    effect,heroMagic,moveMagic,standMagic,dieMagic,
    corpseMagic,dieSkill,career,speciaAI,immuneCharm,charmNum,comeOutRes,arm
"""
# 生成域枚举        
BaseField = Field('BaseField' , BaseColumn)
ShareField = Field('ShareField', ShareDataColumn)

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

monster_erl = "data_monster"
data_monster = module_header(ur"怪配置", monster_erl, "zm", "monster.xlsx", "data_monster.py")
data_monster.append("""
-include("monster.hrl").
-include("hero_attr.hrl").

-export([get/1]).
""")

monster_base = {}
@load_sheel(work_book, ur"monster")
def get_monster(content):
    monster_id = int(content[BaseField.id])
    share_id = int(content[BaseField.shareDataID])
    main_atk = int(content[BaseField.main_atk])
    minor_atk = int(get_value(content[BaseField.minor_atk], 0))
    defence = int(get_value(content[BaseField.defence], 0))
    hp = int(content[BaseField.hp])
    level = int(content[BaseField.level])
    monster_base.setdefault(monster_id, {})
    monster_base[monster_id]['share_id'] = share_id
    monster_base[monster_id]['main_atk'] = main_atk
    monster_base[monster_id]['minor_atk'] = minor_atk
    monster_base[monster_id]['defence'] = defence
    monster_base[monster_id]['hp'] = hp
    monster_base[monster_id]['level'] = level
    return []
get_monster()

share_base = {}
@load_sheel(work_book, ur"shareData")
def get_share_data(content):
    share_id = int(content[ShareField.id])
    hero_num = int(get_value(content[ShareField.heroNum], 1))
    hero_type = int(get_value(content[ShareField.heroType], 0))
    scope = int(get_value(content[ShareField.scope], 0))
    pos_length = int(get_value(content[ShareField.posLength], 1))
    occupy = get_str(content[ShareField.occupy], '')
    main_atk_rate = get_str(content[ShareField.atkRate], '')
    minor_atk_rate = get_str(content[ShareField.atkRate_1], '')
    atk_scope = get_str(content[ShareField.atkScope], '')
    def_type = int(get_value(content[ShareField.defType], 1))
    priority_atk_career = get_str(content[ShareField.priority], '')
    ignore_atk_career = get_str(content[ShareField.ignore], '')
    bomb_num = get_str(content[ShareField.bombNum], '')
    speed = int(get_value(content[ShareField.speed], 100000000))
    main_atk_range = get_str(content[ShareField.atkRange], '')
    minor_atk_range = get_str(content[ShareField.atkRange_1], '')
    main_skills = get_str(content[ShareField.skills], '')
    main_skill_turn = get_str(content[ShareField.skillTurn], '')
    minor_skills = get_str(content[ShareField.skills_1], '')
    minor_skill_turn = get_str(content[ShareField.skillTurn_1], '')
    die_skills = get_str(content[ShareField.dieSkill], '')
    populace = int(get_value(content[ShareField.populace], 0))
    main_atk_cd = int(get_value(content[ShareField.main_atkCD], 99999999))
    minor_atk_cd = int(get_value(content[ShareField.minor_atkCD], 99999999))
    career = int(get_value(content[ShareField.career], 0))
    special_ai = int(get_value(content[ShareField.speciaAI], 0))
    immune_type = get_str(content[ShareField.immuneCharm], '')
    control_num = int(get_value(content[ShareField.charmNum], 0))
    hero_arm = int(get_value(content[ShareField.arm], 0))

    share_base.setdefault(share_id, {})
    share_base[share_id]['populace'] = populace
    share_base[share_id]['main_atk_cd'] = main_atk_cd
    share_base[share_id]['minor_atk_cd'] = minor_atk_cd
    share_base[share_id]['hero_num'] = hero_num
    share_base[share_id]['hero_type'] = hero_type
    share_base[share_id]['scope'] = scope
    share_base[share_id]['pos_length'] = pos_length
    share_base[share_id]['occupy'] = occupy
    share_base[share_id]['main_atk_rate'] = main_atk_rate
    share_base[share_id]['minor_atk_rate'] = minor_atk_rate
    share_base[share_id]['def_type'] = def_type
    share_base[share_id]['atk_scope'] = atk_scope
    share_base[share_id]['priority_atk_career'] = priority_atk_career
    share_base[share_id]['ignore_atk_career'] = ignore_atk_career
    share_base[share_id]['bomb_num'] = bomb_num
    share_base[share_id]['speed'] = speed
    share_base[share_id]['main_atk_range'] = main_atk_range
    share_base[share_id]['minor_atk_range'] = minor_atk_range
    share_base[share_id]['main_skills'] = main_skills
    share_base[share_id]['main_skill_turn'] = main_skill_turn
    share_base[share_id]['minor_skills'] = minor_skills
    share_base[share_id]['minor_skill_turn'] = minor_skill_turn
    share_base[share_id]['die_skills'] = die_skills
    share_base[share_id]['career'] = career
    share_base[share_id]['special_ai'] = special_ai
    share_base[share_id]['immune_type'] = immune_type
    share_base[share_id]['control_num'] = control_num
    share_base[share_id]['hero_arm'] = hero_arm
    return []
get_share_data()

monster_list = []
for id in monster_base:
    share_id = monster_base[id]['share_id']
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
        level = {29},
        attr_list = [
            {{?MAIN_ATK, {2}}},
            {{?MINOR_ATK, {3}}},
            {{?MAIN_ATK_CD, {4}}},
            {{?MINOR_ATK_CD, {5}}},
            {{?DEFENCE, {6}}},
            {{?HP, {7}}},
            {{?SPEED, {20}}}
           ],
       special_ai = {30},
       control_num = {31},
       immune_type = [{32}],
       hero_arm = {33}
    }};""".format(
        id
        ,share_base[share_id]['populace']
        ,monster_base[id]['main_atk']
        ,monster_base[id]['minor_atk']
        ,share_base[share_id]['main_atk_cd']
        ,share_base[share_id]['minor_atk_cd']
        ,monster_base[id]['defence']
        ,monster_base[id]['hp']
        ,share_base[share_id]['hero_num']
        ,share_base[share_id]['hero_type']
        ,share_base[share_id]['scope']
        ,share_base[share_id]['pos_length']
        ,share_base[share_id]['occupy']
        ,share_base[share_id]['main_atk_rate']
        ,share_base[share_id]['minor_atk_rate']
        ,share_base[share_id]['atk_scope']
        ,share_base[share_id]['def_type']
        ,share_base[share_id]['priority_atk_career']
        ,share_base[share_id]['ignore_atk_career']
        ,share_base[share_id]['bomb_num']
        ,share_base[share_id]['speed']
        ,share_base[share_id]['main_atk_range']
        ,share_base[share_id]['minor_atk_range']
        ,share_base[share_id]['main_skills']
        ,share_base[share_id]['main_skill_turn']
        ,share_base[share_id]['minor_skills']
        ,share_base[share_id]['minor_skill_turn']
        ,share_base[share_id]['die_skills']
        ,share_base[share_id]['career']
        ,monster_base[id]['level']
        ,share_base[share_id]['special_ai']
        ,share_base[share_id]['control_num']
        ,share_base[share_id]['immune_type']
        ,share_base[share_id]['hero_arm']
        ))

monster_list.append("get(MonsterID) -> data_monster_1:get(MonsterID).")

data_monster.extend(monster_list)

gen_erl(monster_erl, data_monster)
