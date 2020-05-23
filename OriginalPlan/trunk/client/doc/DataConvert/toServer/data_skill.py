#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
技能配置
@author: ZhaoMing
@deprecated: 2014-07-08
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value,gen_php

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"skill")

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
BaseColumn = """
    skill_id ,name ,icon ,desc ,lvUpdDesc ,skillLvUpDesc , skillLvUpNumber, action
    ,totalFrame, fTime ,framePlay,cd ,skillType, isNormal ,effect ,ePer ,eNum 
    ,heroAttr ,lvAttr ,fightValeAdd,critical ,flankHurt, rateHurt ,targetType, range ,targetNum ,changeSkill
    ,keyframe ,keyType ,keyMagic ,prob ,sourceSkill ,targetSkill ,sourceBuff
    ,sBuffTime ,targetBuff ,tBuffTime ,playRate, rateTime, stunt ,stuntTime, hitAudio, skillActTime, skill_rage
    ,HeroName, SkillActivation, SkillOrder, Career, BuffID, BuffLastTime
"""

BaseColumn1 = """
    skill_id, name, icon, desc, cd, scope, skillType, effect, atkRate, eNum,lvAttr, hpRateHurt
    ,extraCure,targetNum,fTime,prepareMagic,keyFrame,keyMagic,touchMagic,effectMagic
    ,angryCost,useLevel,skillActionTime,skill_rage,targetType,targetBuff,tBuffTime,BuffTimePerLV
    ,SpecialAI
"""

class FieldClassBase:
    def __init__(self):
        enum(FieldClassBase, BaseColumn)

class FieldClassBase1:
    def __init__(self):
        enum(FieldClassBase1, BaseColumn1)

# 生成域枚举           
BaseField = FieldClassBase()
BaseField1 = FieldClassBase1()

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

skill_erl = "data_skill"
data_skill = module_header(ur"技能配置", skill_erl, "zm", "skill.xlsx", "data_skill.py")
data_skill.append("""
-include("skill.hrl").

-export([
    get/1,
    get_role_skill/1
    ]).

""")

skill_php = "base_skill.cfg"
data_php_skill = module_php_header(ur"物品配置", skill_php, "zm", "skill.xlsx", "data_skill.py")
stone_dict = {}
skill_base = []
php_skill_base = []
php_skill_base.append("return $base_skill = array(")
skill_base.append("%% @spec get(SkillID::int()) -> #skill_base{} | false.")
@load_sheel(work_book, ur"主动技能")
def get_base_skill(content):
    skill_id = int(content[BaseField.skill_id])
    skill_name = str(content[BaseField.name])
    is_normal = int(get_value(content[BaseField.isNormal], 0))
    if is_normal == 1:
        is_normal = "true"
    else :
        is_normal = "false"

    skill_range_1 = str(get_value(content[BaseField.range], "1,1,1"))
    target_skill_list = str(get_value(content[BaseField.targetSkill], ""))
    change_skill = str(get_value(content[BaseField.changeSkill], ""))
    e_num = int(get_value(content[BaseField.eNum], 0))
    flank_hurt = int(get_value(content[BaseField.flankHurt], 0))
    e_per = int(get_value(content[BaseField.ePer], 0))
    target_num = int(get_value(content[BaseField.targetNum], 1))
    skill_range_2 = str(get_value(content[BaseField.skill_rage],''))
    atk_scope = int(get_value(content[BaseField.effect], 0))
    skill_time = int(get_value(content[BaseField.skillActTime], 0))
    buff_id = int(get_value(content[BaseField.BuffID], 0))
    buff_last_time = int(get_value(content[BaseField.BuffLastTime], 0))



    skill_base.append("""get({0}) ->
    #skill_base{{
        id = {0}
        ,is_normal = {1}
        ,range = [{2}]
        ,target_skill_list = [{3}]
        ,change_skill = try lists:nth(2, [{4}]) catch _:_ -> 0 end
        ,e_num = {5}
        ,flank_hurt = {6}
        ,e_per = {7}
        ,target_num = {8}
        ,skill_time = {9}
        ,skill_range = [{10}]
        ,atk_scope = {11}
        ,buff_id = {12}
        ,buff_last_time = {13}
    }}; """.format(skill_id, is_normal, skill_range_1, target_skill_list, change_skill, e_num, flank_hurt,  e_per, target_num, skill_time, skill_range_2, atk_scope, buff_id, buff_last_time))
    php_skill_base.append("""    {0} => array('id' => {0}, 'name' => '{1}'),""".format(skill_id, skill_name))
    php_skill_base.append("""    '{1}' => array('id' => {0}, 'name' => '{1}'),""".format(skill_id, skill_name))
    return []

get_base_skill()
skill_base.append("get(SkillID) -> get_role_skill(SkillID).")
data_skill.extend(skill_base)

role_skill = []
role_skill.append("%% @spec get_role_skill(SkillID::int()) -> #role_skill{} | false.")
@load_sheel(work_book, ur"玩家技能")
def get_role_skill(content):
    skill_id = int(get_value(content[BaseField1.skill_id], 0))
    atk_rate = str(get_value(content[BaseField1.atkRate], ''))
    cd = int(get_value(content[BaseField1.cd], 0))
    atk_scope = int(get_value(content[BaseField1.scope], 0))
    skill_time = int(get_value(content[BaseField1.skillActionTime], 0))
    skill_range = str(get_value(content[BaseField1.skill_rage], ''))
    atk = int(get_value(content[BaseField1.eNum], 0))
    buff_id = int(get_value(content[BaseField1.targetBuff], 0))
    buff_last_time = int(get_value(content[BaseField1.tBuffTime], 0))
    per_lv_atk = int(get_value(content[BaseField1.lvAttr], 0))
    per_lv_buff_time = int(get_value(content[BaseField1.BuffTimePerLV], 0))
    special_ai = int(get_value(content[BaseField1.SpecialAI], 0))
    target_type = int(get_value(content[BaseField1.targetType], 0))

    role_skill.append("""get_role_skill({0}) ->
    #role_skill{{
        id = {0},
        atk = {6},
        atk_rate = [{1}],
        cd = {2},
        atk_scope = {3},
        skill_time = {4},
        skill_range = [{5}],
        buff_id = {7},
        buff_last_time = {8},
        per_lv_buff_time = {9},
        per_lv_atk = {10},
        special_ai = {11},
        target_type = {12}
    }};""".format(skill_id, atk_rate, cd, atk_scope, skill_time, skill_range, atk, buff_id, buff_last_time, per_lv_buff_time, per_lv_atk, special_ai, target_type))
    return []

get_role_skill()
role_skill.append("get_role_skill(_) -> false.")
data_skill.extend(role_skill)

php_skill_base.append(");")
data_php_skill.extend(php_skill_base)

gen_erl(skill_erl, data_skill)
gen_php(skill_php, data_php_skill)
