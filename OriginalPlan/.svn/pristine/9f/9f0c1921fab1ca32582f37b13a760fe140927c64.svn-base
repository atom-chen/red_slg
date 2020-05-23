#!/usr/bin/env python
# -*- coding: UTF-8 -*-
'''
过滤字配置表
@author: ZhaoMing
@deprecated: 2014年7月31日
'''
import os
# 导入要用到的函数
from libs.utils import load_excel, load_sheel, module_header, gen_erl, gen_xml, prev, get_value

 # 导入礼包数据配置.xlsx，文件统一放置在docs目录
work_book = load_excel(ur"filter_string")

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

filter_erl = "data_filter"
data_filter = module_header(ur"过滤字配置表", filter_erl, "zm", "filter_string.xlsx", "data_filter.py")
data_filter.append("""
-export([talk/0, name/0]).
""")

filter_talk = []
@load_sheel(work_book, ur"聊天过滤")
def get_talk(content):
    s = str(content[0])
    filter_talk.append("<<%s>>"%(s))
    return []

get_talk()

data_filter.append("talk() -> [%s]."%(",".join(filter_talk)))

filter_name = []
@load_sheel(work_book, ur"名字过滤")
def get_name(content):
    s = str(content[0])
    filter_name.append("<<%s>>"%(s))
    return []

get_name()

data_filter.append("name() -> [%s]."%(",".join(filter_name)))


gen_erl(filter_erl, data_filter)
