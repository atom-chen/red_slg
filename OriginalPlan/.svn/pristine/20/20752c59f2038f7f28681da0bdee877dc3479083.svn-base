#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
副本配置
@author: ZhaoMing
@deprecated: 2014-11-24
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, module_php_header, gen_erl, gen_xml, prev, get_value, gen_php, get_str

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"sign_7")

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

# 列表去重复
def unique_list(seq, excludes=[]):   
    seen = set(excludes)  # seen是曾经出现的元素集合   
    return [x for x in seq if x not in seen and not seen.add(x)]  

sign_7_erl = "data_sign_7"
data_sign_7 = module_header(ur"物品配置", sign_7_erl, "zm", "sign_7.xlsx", "data_sign_7.py")
data_sign_7.append("-export([get/1]).")

sign_7_reward = []
sign_7_reward.append("%% @spec get(NthDay :: int()) -> {Gold::int(), Coin::int(), ItemList::list(), HeroID::int()}")
@load_sheel(work_book, ur"7日签到")
def get_sign_reward(content):
    nth_day = int(content[0])
    gold = int(content[1])
    coin = int(content[2])
    item_list = get_str(content[3], '')
    hero_id = int(content[4])
    sign_7_reward.append("get(%d) -> {%d, %d, [%s], %d};"%(nth_day, gold, coin, item_list, hero_id))
    return []

get_sign_reward()
sign_7_reward.append("get(_) -> {0, 0, [], 0}.")
data_sign_7.extend(sign_7_reward)

gen_erl(sign_7_erl, data_sign_7)
