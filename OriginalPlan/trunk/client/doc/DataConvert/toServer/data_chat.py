#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
聊天配置
@author: csh
@deprecated: 2014-07-17
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

import time

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"misc")

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
    type
    ,level
    ,times
    ,consume
    ,count
    ,rate
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

chat_erl = "data_chat"
data_chat = module_header(ur"聊天配置", chat_erl, "csh", "misc.xlsx", "data_chat.py")
data_chat.append("""
-export([get_level/0, get_times/0, get_consume/0, get_count/0, get_rate/0]).
""")

chat_base = []
chat_base.append("%% @spec get(chat:: int()) -> #chat_base{} | false")
@load_sheel(work_book, ur"Sheet1")
def get_data(content):
    type_id = int(get_value(content[BaseField.type], 0))
    level = int(get_value(content[BaseField.level], 0))
    times = int(get_value(content[BaseField.times], 0))
    consume = int(get_value(content[BaseField.consume], 0))
    count = int(get_value(content[BaseField.count], 0))
    rate = int(get_value(content[BaseField.rate], 0))

    if (type_id == 1) :
        chat_base.append("""get_level() -> {0}. \r\n""".format(level))
        chat_base.append("""get_times() -> {0}. \r\n""".format(times))
        chat_base.append("""get_consume() -> {0}. \r\n""".format(consume))
        chat_base.append("""get_count() -> {0}. \r\n""".format(count))
        chat_base.append("""get_rate() -> {0}. \r\n""".format(rate))
    return []

get_data()

data_chat.extend(chat_base)

gen_erl(chat_erl, data_chat)
