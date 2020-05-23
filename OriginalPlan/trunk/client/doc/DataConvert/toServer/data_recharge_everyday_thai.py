#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
每日充值
@author: ZhaoMing
@deprecated: 2013-11-20
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"rechargeEveryDay_thai")

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
    day, name, cost, heroID, exerciseId, gold, items, 
    overPrice, disCount, money, title, content
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

recharge_everyday_erl = "data_recharge_everyday_thai"
data_recharge_everyday = module_header(ur"每日充值配置", recharge_everyday_erl, "zm", "rechargeEveryDay_thai.xlsx", "data_recharge_everyday_thai.py")
data_recharge_everyday.append("""
-include("mail.hrl").
-include("recharge_everyday.hrl").

-export([
         get/1,
         send_mail/2,
         max_day/0
        ]).
""")

day_conf_list = []
day_conf_list.append("""
%% @doc 配置
%% @spec get(NthDay::int()) -> #recharge_everyday{} """)

max_day = 0

send_mail_list = []

@load_sheel(work_book, ur"每日首次充值")
def get_base(content):
    global max_day
    day = int(content[BaseField.day])
    name = get_str(content[BaseField.name], '')
    acc_gold = int(content[BaseField.cost])
    hero_id = int(get_value(content[BaseField.heroID], 0))
    exer_id = int(get_value(content[BaseField.exerciseId], 0))
    items = get_str(content[BaseField.items], '')
    gold = int(get_value(content[BaseField.gold], 0))
    over_price = int(get_value(content[BaseField.overPrice], 0))
    dis_count = get_str(content[BaseField.disCount], '')
    money = get_str(content[BaseField.money], '')

    title = get_str(content[BaseField.title], '')
    content = get_str(content[BaseField.content], '')

    if day > max_day:
        max_day = day
    day_conf_list.append("""get(%d) -> 
    #recharge_everyday{
          day = %d,
          name = <<"%s">>,
          acc_gold = %d,
          hero_id = %d,
          exer_id = %d,
          reward_list = [%s],
          over_price = %d,
          dis_count = <<"%s">>,
          money = <<"%s">>
    };"""%(day, day, name, acc_gold, hero_id, exer_id, items, over_price, dis_count, money))
    
    send_mail_list.append("""send_mail(RoleID, NthDay) when NthDay =:= %d ->
    catch lib_mail:send_mail(0, RoleID, <<"%s">>, <<"%s">>, [%s], ?MAIL_TYPE_SYSTEM);"""%(day, title, content, items))
    return []

get_base()

day_conf_list.append("get(_) -> false.")
send_mail_list.append("send_mail(_, _) -> ok.")

data_recharge_everyday.extend(day_conf_list)
data_recharge_everyday.extend(send_mail_list)

data_recharge_everyday.append("""
%% @doc 最大天数
%% @spec max_day() -> int() 
max_day() -> %d. """%(max_day))


gen_erl(recharge_everyday_erl, data_recharge_everyday)
