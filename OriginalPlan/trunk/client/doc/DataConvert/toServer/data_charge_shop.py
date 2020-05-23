#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
充值商城配置表
@author: ZhaoMing
@deprecated: 2015年01月21日
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"charge_shop")

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

BaseColumn = """
    gold
    ,name
    ,icon
    ,money
    ,first_extra
    ,obtain_gold
    ,pos
    ,type
    ,hot
    ,month_obtain_gold
    ,CNY
    ,cont_days
    ,picture
    ,isView
    ,os
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

## ##################################
## 大陆配置
## ##################################

shop_erl = "data_charge_shop"
data_charge_shop = module_header(ur"充值商城配置", shop_erl, "zm", "charge_shop.xlsx", "data_charge_shop.py")
data_charge_shop.append("""
-include("charge_shop.hrl").

-export([
         get/2
         ,get_all/1
         ,get_month_card_id_list/1
         ,get_charge_id/2
        ]).
""")

conf = []
all_id = []
month_card_id_list = []

range_gold_list = []
range_gold_list.append("get_charge_id(_, _) -> 0.")

@load_sheel(work_book, ur"大陆")
def get_conf(content):
    name = str(content[BaseField.name])
    icon = int(content[BaseField.icon])
    gold = int(content[BaseField.gold])
    money = str(content[BaseField.money])
    first_extra = int(get_value(content[BaseField.first_extra], 0))
    obtain_gold = int(get_value(content[BaseField.obtain_gold], 0))
    pos = int(get_value(content[BaseField.pos], 0))
    charge_type = int(content[BaseField.type])
    hot = int(get_value(content[BaseField.hot], 0))
    day_obtian_gold = int(get_value(content[BaseField.month_obtain_gold], 0))
    cny = int(content[BaseField.CNY])
    cont_days = int(get_value(content[BaseField.cont_days], 0))
    picture = get_str(content[BaseField.picture], '')
    os = get_str(content[BaseField.os], '')

    if os == '-1':
        os = '0,1,2,3'
    os_str = os.replace(",", " orelse OS =:= ")
    
    if int(get_value(content[BaseField.isView], 0)) == 0:
        is_view = "false"
    else:
        is_view = "true"

    if charge_type == 1:
        month_card_id_list.append("{[%s], %d}"%(os, gold))

    if is_view == "true": 
        all_id.append("{[%s], %d}"%(os, gold))

    if charge_type != 1:
        range_gold_list.append("get_charge_id(OS, Gold) when Gold >= %d andalso (OS =:= %s)-> %d;"%(gold, os_str, gold))
    
    conf.append("""get(OS, {0}) when OS =:= {14} -> 
    #charge_shop_conf{{
        name = <<"{1}">>
        ,icon = {2}
        ,gold = {0}
        ,money = <<"{3}">>
        ,first_extra_gold = {4}
        ,obtain_gold = {5}
        ,pos = {6}
        ,type = {7}
        ,hot = {8}
        ,rmb = {9}
        ,day_obtian_gold = {10}
        ,cont_days = {11}
        ,picture = <<"{12}">>
        ,is_view = {13}
    }};
    """.format(
        gold, name, icon, money, first_extra, obtain_gold, 
        pos, charge_type, hot, cny,
        day_obtian_gold, cont_days, picture, is_view, os_str
        ))
    return []

get_conf()
conf.append("get(_, _) -> false.")
data_charge_shop.extend(conf)

range_gold_list.append("""
%% @doc 获取档位
%% @spec get_charge_id(OS::int(), Gold::int()) -> Gold::int() """)

range_gold_list.reverse()
data_charge_shop.extend(range_gold_list)

data_charge_shop.append("""
get_all(OS) ->
    [ID||{OSList, ID} <- [%s], lists:member(OS, OSList)]. 
"""%(",".join(all_id)))
data_charge_shop.append("""
get_month_card_id_list(OS) -> 
    [ID || {OSList, ID} <- [%s], lists:member(OS, OSList)].  """%(",".join(month_card_id_list)))

gen_erl(shop_erl, data_charge_shop)

## ##################################
## 台湾配置
## ##################################

shop_erl = "data_charge_shop_tw"
data_charge_shop = module_header(ur"充值商城配置", shop_erl, "zm", "charge_shop.xlsx", "data_charge_shop.py")
data_charge_shop.append("""
-include("charge_shop.hrl").
-export([
         get/2
         ,get_all/1
         ,get_month_card_id_list/1
         ,get_charge_id/2
        ]).
""")
conf = []
all_id = []
month_card_id_list = []

range_gold_list = []
range_gold_list.append("get_charge_id(_, _) -> 0.")

@load_sheel(work_book, ur"台湾")
def get_conf(content):
    name = str(content[BaseField.name])
    icon = int(content[BaseField.icon])
    gold = int(content[BaseField.gold])
    money = str(content[BaseField.money])
    first_extra = int(get_value(content[BaseField.first_extra], 0))
    obtain_gold = int(get_value(content[BaseField.obtain_gold], 0))
    pos = int(get_value(content[BaseField.pos], 0))
    charge_type = int(content[BaseField.type])
    hot = int(get_value(content[BaseField.hot], 0))
    day_obtian_gold = int(get_value(content[BaseField.month_obtain_gold], 0))
    cny = int(content[BaseField.CNY])
    cont_days = int(get_value(content[BaseField.cont_days], 0))
    picture = get_str(content[BaseField.picture], '')
    os = get_str(content[BaseField.os], '')

    if os == '-1':
        os = '0,1,2,3'
    os_str = os.replace(",", " orelse OS =:= ")

    if int(get_value(content[BaseField.isView], 0)) == 0:
        is_view = "false"
    else:
        is_view = "true"

    if charge_type == 1:
        month_card_id_list.append("{[%s], %d}"%(os, gold))

    if is_view == "true": 
        all_id.append("{[%s], %d}"%(os, gold))
    
    if charge_type != 1:
        range_gold_list.append("get_charge_id(OS, Gold) when Gold >= %d andalso (OS =:= %s)-> %d;"%(gold, os_str, gold))

    conf.append("""get(OS, {0}) when OS =:= {14} -> 
    #charge_shop_conf{{
        name = <<"{1}">>
        ,icon = {2}
        ,gold = {0}
        ,money = <<"{3}">>
        ,first_extra_gold = {4}
        ,obtain_gold = {5}
        ,pos = {6}
        ,type = {7}
        ,hot = {8}
        ,rmb = {9}
        ,day_obtian_gold = {10}
        ,cont_days = {11}
        ,picture = <<"{12}">>
        ,is_view = {13}
    }};
    """.format(
        gold, name, icon, money, first_extra, obtain_gold, 
        pos, charge_type, hot, cny,
        day_obtian_gold, cont_days, picture, is_view, os_str
        ))
    return []

get_conf()
conf.append("get(_, _) -> false.")

range_gold_list.append("""
%% @doc 获取档位
%% @spec get_charge_id(Gold::int()) -> Gold::int() """)

range_gold_list.reverse()
data_charge_shop.extend(range_gold_list)

data_charge_shop.extend(conf)
data_charge_shop.append("""
get_all(OS) ->
    [ID||{OSList, ID} <- [%s], lists:member(OS, OSList)]. 
"""%(",".join(all_id)))
data_charge_shop.append("""
get_month_card_id_list(OS) -> 
    [ID || {OSList, ID} <- [%s], lists:member(OS, OSList)].  """%(",".join(month_card_id_list)))

gen_erl(shop_erl, data_charge_shop)

## ##############################
## 泰国
## ##############################
shop_erl = "data_charge_shop_thai"
data_charge_shop = module_header(ur"充值商城配置", shop_erl, "zm", "charge_shop.xlsx", "data_charge_shop.py")
data_charge_shop.append("""
-include("charge_shop.hrl").

-export([
         get/2
         ,get_all/1
         ,get_month_card_id_list/1
         ,get_charge_id/2
        ]).
""")

conf = []
all_id = []
month_card_id_list = []

range_gold_list = []
range_gold_list.append("get_charge_id(_, _) -> 0.")

@load_sheel(work_book, ur"泰国")
def get_conf(content):
    name = str(content[BaseField.name])
    icon = int(content[BaseField.icon])
    gold = int(content[BaseField.gold])
    money = str(content[BaseField.money])
    first_extra = int(get_value(content[BaseField.first_extra], 0))
    obtain_gold = int(get_value(content[BaseField.obtain_gold], 0))
    pos = int(get_value(content[BaseField.pos], 0))
    charge_type = int(content[BaseField.type])
    hot = int(get_value(content[BaseField.hot], 0))
    day_obtian_gold = int(get_value(content[BaseField.month_obtain_gold], 0))
    cny = int(content[BaseField.CNY])
    cont_days = int(get_value(content[BaseField.cont_days], 0))
    picture = get_str(content[BaseField.picture], '')
    os = get_str(content[BaseField.os], '')

    if os == '-1':
        os = '0,1,2,3'
    os_str = os.replace(",", " orelse OS =:= ")
    
    if int(get_value(content[BaseField.isView], 0)) == 0:
        is_view = "false"
    else:
        is_view = "true"

    if charge_type == 1:
        month_card_id_list.append("{[%s], %d}"%(os, gold))

    if is_view == "true": 
        all_id.append("{[%s], %d}"%(os, gold))

    if charge_type != 1:
        range_gold_list.append("get_charge_id(OS, Gold) when Gold >= %d andalso (OS =:= %s)-> %d;"%(gold, os_str, gold))
    
    conf.append("""get(OS, {0}) when OS =:= {14} -> 
    #charge_shop_conf{{
        name = <<"{1}">>
        ,icon = {2}
        ,gold = {0}
        ,money = <<"{3}">>
        ,first_extra_gold = {4}
        ,obtain_gold = {5}
        ,pos = {6}
        ,type = {7}
        ,hot = {8}
        ,rmb = {9}
        ,day_obtian_gold = {10}
        ,cont_days = {11}
        ,picture = <<"{12}">>
        ,is_view = {13}
    }};
    """.format(
        gold, name, icon, money, first_extra, obtain_gold, 
        pos, charge_type, hot, cny,
        day_obtian_gold, cont_days, picture, is_view, os_str
        ))
    return []

get_conf()
conf.append("get(_, _) -> false.")
data_charge_shop.extend(conf)

range_gold_list.append("""
%% @doc 获取档位
%% @spec get_charge_id(OS::int(), Gold::int()) -> Gold::int() """)

range_gold_list.reverse()
data_charge_shop.extend(range_gold_list)

data_charge_shop.append("""
get_all(OS) ->
    [ID||{OSList, ID} <- [%s], lists:member(OS, OSList)]. 
"""%(",".join(all_id)))
data_charge_shop.append("""
get_month_card_id_list(OS) -> 
    [ID || {OSList, ID} <- [%s], lists:member(OS, OSList)].  """%(",".join(month_card_id_list)))

gen_erl(shop_erl, data_charge_shop)
