#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
提示配置
@author: ZhaoMing
@deprecated: 2013-11-20
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"tips")

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
    min_role_lev
    ,tip_id
    ,order
    ,classify_id
    ,needCount
    ,desc
    ,exp_reward
    ,coin_reward
    ,gold_reward
    ,item_reward
    ,tip_content
    ,panel
    ,descNum
    ,crystal
    ,iron
    ,uranium
"""
 
class FieldClassBase:
    def __init__(self):
        enum(FieldClassBase, BaseColumn)

# 生成域枚举           
BaseField = FieldClassBase()

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

tip_erl = "data_tip"
data_tip = module_header(ur"提示配置", tip_erl, "zm", "tip.xlsx", "data_tip.py")
data_tip.append("""
-include("tip.hrl").

-export([get/1, get_all/0, get_order/1, get_classify_id/1]).


get_order(TipID) ->
    case ?MODULE:get(TipID) of
        #tip_base{order = Order} -> Order;
        _ -> 0
    end.

get_classify_id(TipID) ->
    case ?MODULE:get(TipID) of
        #tip_base{classify_id = ClassifyID} -> ClassifyID;
        _ -> 0
    end.
""")

# tip_php = "base_tip.cfg"
# php_data_tip = module_php_header(ur"提示配置", tip_php, "zm", "tip.xlsx", "data_tip.py")

tip_base = []
tip_base.append("%% @spec get(tipID :: int()) -> #tip_base{} | false")

tip_id_list = []
@load_sheel(work_book, ur"提示配置")
def get_tip(content):
    tip_id = int(content[BaseField.tip_id])
    min_role_lev= int(get_value(content[BaseField.min_role_lev], 0))
    item_reward = str(get_value(content[BaseField.item_reward], ''))
    coin_reward = int(get_value(content[BaseField.coin_reward], 0))
    gold_reward = int(get_value(content[BaseField.gold_reward], 0))
    exp_reward  = int(get_value(content[BaseField.exp_reward], 0))
    target      = str(content[BaseField.tip_content])
    order       = int(get_value(content[BaseField.order], 0))
    classify_id = int(get_value(content[BaseField.classify_id], 0))
    crystal     = int(get_value(content[BaseField.crystal], 0))
    iron        = int(get_value(content[BaseField.iron], 0))
    uranium     = int(get_value(content[BaseField.uranium], 0))
    if tip_id == 76508:
        print uranium

    tip_base.append("""get({0}) ->
    #tip_base{{
        tip_id = {0}
        ,min_role_lev = {1}
        ,reward = [{{add_items, [{2}]}}, {{add_coin, {3}}}, {{add_gold, {4}}}, {{add_exp, {6}}}, {{add_crystal, {9}}}, {{add_iron, {10}}}, {{add_uranium, {11}}}]
        ,target = [{5}]
        ,order = {7}
        ,classify_id = {8}
    }};""".format(tip_id, min_role_lev, item_reward, coin_reward, gold_reward, target, exp_reward, order, classify_id, crystal, iron, uranium))
    tip_id_list.append("%d"%(tip_id))
    return []

get_tip()
tip_base.append("get(_) -> false.")

data_tip.extend(tip_base)
data_tip.append("%% @spec get_all() -> list(). ")
data_tip.append("get_all() -> [%s]."%(",".join(tip_id_list)))

gen_erl(tip_erl, data_tip)
# gen_php(tip_php, php_data_tip)
