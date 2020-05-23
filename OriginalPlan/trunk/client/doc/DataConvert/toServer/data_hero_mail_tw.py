#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
 英雄邮件配置(繁体版)
@author: csh
@deprecated: 2014-11-26
'''
import os
# import random
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

import time

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
# 繁体版
work_book_tw = load_excel(ur"hero_mail_tw")

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
#  英雄邮件配置表
BaseColumn1 = """
    hero_id
    ,condition
    ,hero_name
    ,title
    ,content_named
    ,content
    ,reward_item
    ,reward_coin
    ,reward_gold
    ,reward_arena_coin
    ,reward_union_coin
"""

class FieldClassBase1:
    def __init__(self):
        enum(FieldClassBase1, BaseColumn1)

# 生成域枚举           
BaseField1 = FieldClassBase1()

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

# 繁体版
hero_mail_erl_tw = "data_hero_mail_tw"
data_hero_mail_tw = module_header(ur"英雄郵件配置(繁体版)", hero_mail_erl_tw, "csh", "hero_mail_tw.xlsx", "data_hero_mail.py")
data_hero_mail_tw.append("""
-export([
        get_condition/1
        ,get_hero_name/1
        ,get_title/1
        ,get_content/1
        ,get_affix/1
        ]).
""")

# 获取英雄邮件发送条件
hero_mail_condition_tw = []
hero_mail_condition_tw.append("\n\n%% 获取英雄邮件发送条件")
hero_mail_condition_tw.append("%% @spec get_condition(hero_id :: int()) -> condition :: lists | false")
@load_sheel(work_book_tw, ur"英雄郵件配置表" )
def get_condition_tw(content):
    hero_id = int(get_value(content[BaseField1.hero_id], 0))
    condition1 = get_value(content[BaseField1.condition], '')
    try :
        condition2 = str(int(condition1))
    except :
        condition2 = str(condition1)
    condition = '[' + condition2 + ']'
    hero_mail_condition_tw.append("""get_condition({0}) -> {1};""".format(hero_id, condition))
    return []
get_condition_tw()
hero_mail_condition_tw.append("get_condition(_) -> false.")
data_hero_mail_tw.extend(hero_mail_condition_tw)

# 获取英雄名字
mail_hero_name_tw = []
mail_hero_name_tw.append("\n\n%% 获取英雄名字")
mail_hero_name_tw.append("%% @spec get_heroM_name(hero_id :: int()) -> hero_name :: string()")
@load_sheel(work_book_tw, ur"英雄郵件配置表")
def get_hero_name_tw(content):
    hero_id = int(get_value(content[BaseField1.hero_id], 0))
    hero_name = '<<"' + str(get_value(content[BaseField1.hero_name], '')) + '">>'
    mail_hero_name_tw.append("""get_hero_name({0}) -> {1};""".format(hero_id, hero_name))
    return []
get_hero_name_tw()
mail_hero_name_tw.append("get_hero_name(_) -> false.")
data_hero_mail_tw.extend(mail_hero_name_tw)

# 获取标题
hero_mail_title_tw = []
hero_mail_title_tw.append("\n\n%% 获取标题")
hero_mail_title_tw.append("%% @spec get_title(hero_id :: int()) -> title :: string() | false")
@load_sheel(work_book_tw, ur"英雄郵件配置表")
def get_title_tw(content):
    hero_id = int(get_value(content[BaseField1.hero_id], 0))
    title = '<<"' + str(get_value(content[BaseField1.title], '')) + '">>'
    hero_mail_title_tw.append("""get_title({0}) -> {1};""".format(hero_id, title))
    return []
get_title_tw()
hero_mail_title_tw.append("get_title(_) -> false.")
data_hero_mail_tw.extend(hero_mail_title_tw)
    
# 获取英雄邮件内容(称呼和内容)
hero_mail_content_tw = []
hero_mail_content_tw.append("\n\n%% 获取英雄邮件内容")
hero_mail_content_tw.append("%% @spec get_content(hero_id :: int()) -> {named :: string, content :: string}")
@load_sheel(work_book_tw, ur"英雄郵件配置表" )
def get_content_tw(content):
    hero_id = int(get_value(content[BaseField1.hero_id], 0))
    content_named = '<<"' + str(get_value(content[BaseField1.content_named], '')) + '">>'
    content = '<<"' + str(get_value(content[BaseField1.content], '')) + '">>'
    hero_mail_content_tw.append("""get_content({0}) -> {{{1}, {2}}};""".format(hero_id, content_named, content))
    return []
get_content_tw()
hero_mail_content_tw.append("get_content(_) ->  false.")
data_hero_mail_tw.extend(hero_mail_content_tw)

# 整理附件数据,没有数据的不写入
def get_affix_str(str_item, icoin, igold, iarena, iunion):
    str_result = ''
    if icoin != 0 :
        str_result = str_result + '{coin,' + str(icoin) + '}'
    if igold != 0 :
        if len(str_result) != 0 :
            str_result = str_result + ','
        str_result = str_result + '{gold,' + str(igold) + '}'
    if iarena != 0 :
        if len(str_result) != 0 :
            str_result = str_result + ','
        str_result = str_result + '{arena_coin,' + str(iarena) + '}'
    if iunion != 0 :
        if len(str_result) != 0 :
            str_result = str_result + ','
        str_result = str_result + '{union_coin,' + str(iunion) + '}'
    if len(str_item) != 0 :
        if len(str_result) != 0 :
            str_result = str_result + ','
        str_result = str_result + str_item
    return str_result

# 获取英雄邮件附件内容
hero_mail_affix_tw = []
hero_mail_affix_tw.append("\n\n%% 获取英雄邮件附件内容")
hero_mail_affix_tw.append("%% @spec get_affix(hero_id :: int()) -> affix :: lists | false")
@load_sheel(work_book_tw, ur"英雄郵件配置表" )
def get_affix_tw(content):
    hero_id = int(get_value(content[BaseField1.hero_id], 0))
    reward_item = str(get_value(content[BaseField1.reward_item], ''))
    reward_coin = int(get_value(content[BaseField1.reward_coin], 0))
    reward_gold = int(get_value(content[BaseField1.reward_gold], 0))
    reward_arena_coin = int(get_value(content[BaseField1.reward_arena_coin], 0))
    reward_union_coin = int(get_value(content[BaseField1.reward_union_coin], 0))
    str_affix = get_affix_str(reward_item, reward_coin, reward_gold, reward_arena_coin, reward_union_coin)
    hero_mail_affix_tw.append("""get_affix({0}) -> [{1}];""".format(hero_id, str_affix))
    return []
get_affix_tw()
hero_mail_affix_tw.append("get_affix(_) -> false.")
data_hero_mail_tw.extend(hero_mail_affix_tw)


gen_erl(hero_mail_erl_tw, data_hero_mail_tw)
